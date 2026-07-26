module clkdiv (
    input        clk,
    input        nrst,
    input [25:0] max,
    output logic clk_out,
    output logic tc
) ;

    logic [25:0] count ;

    always_ff @(posedge clk or negedge nrst) begin
        if (nrst == 1'b0) begin // reset asserted
            count   <= 26'd0 ;
          	clk_out <=  1'b0 ;
          	tc      <=  1'b0 ;
        end else begin
          if (count >= max) begin
            tc    <=  1'b1 ;
            count <= 26'd0 ;
          end else begin
            tc    <= 1'b0 ;
            count <= count + 26'd1 ;
          end
          if (count <= {1'b0, max[25:1]}) begin
          		clk_out <= 1'b1 ;
            end else begin
            	clk_out <= 1'b0 ;
            end
        end
    end
endmodule : clkdiv

