module Fibonacci #(BITS=32)(
    input CLK,
    input [BITS-1:0] A, 
    input IEA,
    output reg [BITS-1:0] Y, 
    output reg OE
);

   reg [BITS-1:0] prev1, prev2; 
   reg [BITS-1:0] n;
   enum {StINIT, StCalc, StOE} state;

   initial begin
      state <= StINIT;
   end

   always @ (posedge CLK) begin
      case (state)
         StINIT: begin
            OE <= 0;
            if (IEA) begin
               n <= A; 
               if (A == 0) begin
                  Y <= 0; // F(0) = 0
                  state <= StOE;
               end
               else if (A == 1) begin
                  Y <= 1; // F(1) = 1
                  state <= StOE;
               end
               else begin
                  prev1 <= 1; 
                  prev2 <= 0; 
                  state <= StCalc;
               end
            end
         end

         StCalc: begin
            if (n > 1) begin
               Y <= prev1 + prev2; 
               prev2 <= prev1;     
               prev1 <= Y;         
               n <= n - 1;         
            end
            else begin
               state <= StOE;
            end
         end

         StOE: begin
            OE <= 1; 
            if (OE && !IEA) begin
               state <= StINIT; 
            end
         end
      endcase
   end

endmodule
