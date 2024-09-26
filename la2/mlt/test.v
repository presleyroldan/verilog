`timescale 1ns/100ps

module mlt#(BITS=8)();

   reg clk;
   reg [BITS]a, b, y;
   reg iea, ieb, oe;		

   Multiplier#(.BITS(BITS))
       m(.CLK(clk),
         .A(a),     .B(b),
	 .IEA(iea), .IEB(ieb),
	 .Y(y),     .OE(oe));

   always #7.5 clk=~clk;	

   integer i;
   initial begin
      clk=1'b0;			
      iea=0; ieb=0;
      for (i=0; i<=5; i++) begin
	 a=i; b=i;	        
         #30 iea=1; ieb=1;	
         #30 iea=0;		
	 wait (oe);		
	 $display("mlt(%1d,%1d)=%1d",a,b,y);
         #30 ieb=0;	        
	 wait (!oe);		
      end
     $stop;
   end

// `include "monitor"

endmodule
