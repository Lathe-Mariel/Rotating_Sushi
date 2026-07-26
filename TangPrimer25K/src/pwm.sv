module pwm (
    input        clk,
    input        nrst,
    input [15:0] period,
    input [15:0] compare,
    output logic line,
    output logic tc
) ;

    logic [15:0] count ;

    always_ff @(posedge clk or negedge nrst) begin
        if (nrst == 1'b0)
            count <= 'd0 ;
        else begin
            if (tc) 
                count <= 'd0 ;
            else
                count <= count + 'd1 ;
            if (count > compare)
                line <= 'b0 ;
            else
                line <= 'b1 ;
            if (count >= period)
                tc <= 'b1 ;
            else
                tc <= 'b0 ;
        end
    end

endmodule : pwm
