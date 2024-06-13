/*
Wejścia: clk, przycisk(key), pass_check

Wyjścia: LED_sterring, PIPO_shift, Pipo_reset
*/
//4 diody jako sygnalizacji wpisów znaków, 1 dioda jako alarm,
/*
0000 0 1
1000 0 2
1100 0 3
1110 0 4
1111 0 5
0000 1 6        3 bity (dwie dotakowe możliwości)
*/

/*
0000
0001
0011
0111
1111
5 możliwości (2^3, 3 bity, 3 nadmiarowo)
0x00,0x01,0x02,0x03,0x04

0x5 alarm on
0x6 alarm off
+0x8 blink on
*/
module machine_state(
    input clk,
    input key,
    input pass_check,
    input counting,

    output reg [3:0] LED_sterring,
    output reg pipo_shif,
    output reg pipo_reset,
    //output reg alarm,
    output reg pipo_load;
    output reg lock;
);

    reg setting_new_pass;
    reg [2:0] sign_counter;
    reg [1:0] bad_pass;
    parameter state = state0;

    parameter state0 = 3'b000;
    parameter state1 = 3'b001;
    parameter state2 = 3'b010;
    parameter state3 = 3'b011;

always @(posedge clk)
    begin
        LED_sterring <= {setting_new_pass,sign_counter};

        case (state)
            state0: //stan IDLE, jeśli wprowadzono 4 znaki i wciśnięto przycisk należy rozpoącząć sprawdzanie poprawności hasła, 
                begin
                    if(key & (sign_counter == 2'b100))
                        begin
                            pipo_reset <= 1'b0;
                            pipo_load <= 1'b0;
                            if(setting_new_pass)
                            begin
                                pipo_load <= 1'b1;    //Jeżeli znajdujemy się w trybie ustawiania hasła to wpisujemy nowe hasło
                            end
                            state <= state2;
                        end
                    else if(key) //w przeciwnym razie należy wpisać kolejny 4-bitowy znak
                        begin
                            state <= state1;
                            pipo_reset <= 1'b0;
                            pipo_load <= 1'b0;
                            sign_counter = sign_counter + 1;
                            pipo_shift <= 1'b1;
                        end
                end 
            state1:
                begin //na szerokość jendego zbocza zegarowego zostanie wygenrowany sygnał pipo_shift
                    state <= state0;
                    pipo_shift <= 1'b0;
                end
            state2:                     // resetujemy liczbę wpisanych znaków
                begin
                    if(setting_new_pass) //obecność stanu 2 oznacza wypełnienie rejestru przesuwającego czterema znakami
                        begin           //Jeżeli znajdujemy się w trybie ustawiania hasła kasujemy wcześniej ustawione sygnały oraz przechodzimy do stanu 0
                            pipo_reset <= 1'b0;
                            pipo_load <= 1'b0;
                            setting_new_pass <= 1'b0;
                            state <= state0;
                            sign_counter <= 3'b000;
                        end
                    else if(pass_check)
                        begin               //Jeżeli hasło jest poprawne to kasujemy ew. wystąpienie alarmu, resetujemy licznik niepoprawnie wpisanych haseł, oraz otwieramy zamek
                            state <= state3;
                            bad_pass <= 2'b00;
                            //alarm <= 1'b0;
                            LED_sterring <= 4'b0110;
                            pipo_reset <= 1'b1;
                            lock <= 1'b1;
                            sign_counter <= 3'b000;
                        end
                    else                    //Jeżeli hasło jest niepoprawne to inkrementujemy liczbę niepoprawnie wpisanych haseł, jeżeli ta liczba jest równa co najmniej 3 to ustawiamy
                                            // alarm, resetujemy rejestr przesuwający
                        begin
                            state <= state0
                            bad_pass <= bad_pass + 1;
                            sign_counter <= 3'b000;
                            if(bad_pass == 2'b11)
                                begin
                                    //alarm <= 1'b1;
                                    LED_sterring <= 4'b0101;
                                end
                            pipo_reset <= 1'b1;
                        end
                end
            state3:
                begin       //Jeśli podczas oczekiwanie na zakończenie odliczania wciśnięto przycisk to rozpoczynamy ustawienie nowego stanu, w momencie gdy odliczanie się zakończy
                            // przechodzimy do stanu 0 oraz zamykamy zamek
                    pipo_reset <= 1'b0;
                    if(counting & key)  begin
                            state <= state0;
                            setting_new_pass <= 1'b1;
                        end
                    else if (counting)
                        state <= state3;
                    else    begin
                            state <= state0;
                            lock <= 1'b0;
                        end
                end
            default: state <= state0;
        endcase
    end

endmodule