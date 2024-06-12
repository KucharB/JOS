module debouncer #(
	parameter l_bit = 4
)
(
	input 			clk,
	input 			clr,
	input 			ce,
	input 			s_in,
	output 			key_en,
	//output 			key_up
);
	
	reg [l_bit-1:0] p_out;
      
  always @(posedge clk)
	begin
		if(clr)
			p_out <= {l_bit{1'b0}};
		else
			if (ce)
				p_out <= {p_out[l_bit-2:0],s_in};
	end
				
	assign key_up = (&p_out[l_bit-2:0]) & ~p_out[l_bit-1] & ce;	
	//assign key_en = (&p_out[l_bit-1:0]);
endmodule

