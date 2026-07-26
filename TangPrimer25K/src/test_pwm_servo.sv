module test_pwm_servo(
    input              clk,
    input              reset,
    input              sw,
    output logic       servo_pwm
) ;

logic [9:0] counter;
logic clk10m;
logic clk10k;
logic [7:0] counter_pwm;
logic [7:0] pwm_width;

always_ff @(posedge clk10m)begin
    if(counter == 999)begin
        counter <= 0;
        clk10k <= 1;
    end else begin
        counter <= counter + 1;
        clk10k <= 0;
    end

    if (clk10k == 1'b1) begin
        if(counter_pwm < 200)begin
            counter_pwm <= counter_pwm + 8'b1;
            if(counter_pwm < pwm_width) begin
                servo_pwm <= 1;
            end else begin
                servo_pwm <= 0;
            end
        end else begin
            counter_pwm <= 0;
            servo_pwm <= 0;
        end
    end else begin

    end
end

    Gowin_PLL your_instance_name(
        .clkin(clk), //input  clkin
        .clkout0(clk10m), //output  clkout0 10MHz
        .mdclk() //input  mdclk
);

    always_ff @(posedge clk) begin
        if (sw == 1) begin
            pwm_width <= 24;
        end else begin
            pwm_width <= 19;
        end


    end /* always */

endmodule : test_pwm_servo
