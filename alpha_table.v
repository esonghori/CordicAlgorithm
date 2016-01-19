`include "cordic.vh"

module alpha_table
#( 
  parameter DEC  = 2,
  parameter FRAC = 14,
  parameter MOD = `MOD_CIR // MOD = {`MOD_CIR=1,`MOD_LIN=0,`MOD_HYP=-1}
)
(
  iter,
  alphai
);

  localparam L = DEC + FRAC;
  localparam ITER = FRAC + 1;
  localparam LOG_ITER = $clog2(ITER); 

  input [LOG_ITER-1:0] iter;
  output [L-1:0] alphai;

  reg [L-1:0] mem [ITER-1:0];

  generate
    if(MOD == `MOD_CIR) begin
      initial begin
        $readmemb("tables/circular.txt", mem); 
      end
    end else if (MOD == `MOD_LIN) begin
      initial begin
        $readmemb("tables/linear.txt", mem); 
      end
    end else begin //if (MOD == `MOD_HYP)
      initial begin
        $readmemb("tables/hyperbolic.txt", mem); 
      end
    end
  endgenerate

  assign alphai = (iter<ITER)?mem[iter]:0;

endmodule
