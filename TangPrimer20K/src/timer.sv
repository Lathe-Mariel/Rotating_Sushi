module timer #(
  parameter COUNT_MAX = 27
) (
  input  wire  clk,
  output logic overflow
);

  logic [21:0] counter = 'd0;

  always_ff @ (posedge clk) begin
    if (counter == COUNT_MAX) begin
      counter  <= 'd0;
      overflow <= 'd1;
    end else begin
      counter  <= counter + 'd1;
      overflow <= 'd0;
    end
  end

endmodule