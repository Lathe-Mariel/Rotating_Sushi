module top(
input wire clk,
input wire sw,
output wire MS1,
output wire MS2,
output wire MS3,
output wire motor_pul,
output wire motor_enable,
output wire motor_direction,
output wire A4988_sleep,
output wire A4988_reset,
output wire [5:0] onboard_led
);

logic overflow;

logic current_direction;
reg motor_pulse;
reg [16:0] position;
reg [16:0] interval_time;
reg [16:0] current_interval_count;
reg [5:0] onboard_led;
reg pulse_triger;
reg [9:0] sleep;
reg m_enable;
reg [8:0] encoder_counter;

parameter FULL_STROKE_STEP = 16'd32768;
parameter ACCEL1 = 16'd100;   //accel rate 1/4
parameter ACCEL2 = 16'd400;  //accel rate 1/2
parameter ACCEL3 = 16'd1440;  //up to FIRST_INTERVAL
parameter FIRST_INTERVAL = 16'd1450;

timer timer_instance(clk, overflow);

initial begin
  position = 16'd0;
  current_direction = 1'b0;
  interval_time = FIRST_INTERVAL;
  encoder_counter = 0;
end


/*instanciate matrix driver
  // Assign row, col to outpus.
  logic [7:0] row, col;
  assign anode   = ~col;
  assign cathode = row;
  reg [3:0] diameter;
  wire debounced_rotary_a;
  wire debounced_rotary_b;
  logic overflow;

  // matrix_led_driver instance.
  matrix_led_driver inst_0 (
    .clk  (clk),
    .sw1  (sw1),
    .row  (row),
    .col  (col),
    .diameter (diameter)
  );
/*



/*
always @(negedge enc_pul_a)begin
  if(encoder_counter > 9'd40)begin
    encoder_counter <= 9'd40;
  end
  else if(encoder_counter == 9'd0) begin
    encoder_counter <= 9'd1;
  end
  else if(enc_pul_b)begin
    encoder_counter <= encoder_counter - 9'd1;
  end else begin
    encoder_counter <= encoder_counter + 9'd1;
  end
end
*/

always @(posedge overflow)begin
  if(current_interval_count == interval_time + encoder_counter)begin
    pulse_triger = 1'b1;
    current_interval_count <= 16'b0;
  end else begin
    pulse_triger = 1'b0;
    current_interval_count <= current_interval_count + 16'b1;
  end
end

always @(posedge pulse_triger)begin
  if(sleep)begin
    m_enable = 1'b1;
    sleep <= sleep + 'd1;
  end
  else begin
    m_enable = 1'b0;
    if(position == FULL_STROKE_STEP)begin
      current_direction <= current_direction + 1'b1;
      interval_time <= FIRST_INTERVAL;
      sleep <= 'b1;
      motor_pulse <= motor_pulse + 1'b1;
      position <= 16'd0;
    end

    else if(!sw)begin
      interval_time <= 16'd60;
      position = position + 16'd1;
      motor_pulse <= motor_pulse + 1'b1;
    end

    else begin // if(current_direction)begin    //move to minus direction
      if (position <= ACCEL1) begin
        if(position & 2'd1)begin
          interval_time <= interval_time - 16'd1;
        end
      end
      else if (position <= ACCEL2) begin
        if(position & 1'b1)begin
          interval_time <= interval_time - 16'd1;
        end
      end
      else if (position <= ACCEL3) begin
        interval_time <= interval_time - 16'd1;
      end
      else if(position >= FULL_STROKE_STEP - ACCEL1)begin
        if(position & 2'b1)begin
          interval_time <= interval_time + 16'd1;
        end
      end
      else if(position >= FULL_STROKE_STEP - ACCEL2 )begin
        if(position & 1'b1)begin
          interval_time <= interval_time + 16'd1;
        end
      end
      else if(position >= FULL_STROKE_STEP - ACCEL3 )begin
        interval_time <= interval_time + 16'd1;
      end

      position <= position + 16'd1;
      motor_pulse <= motor_pulse + 1'b1;
    end

  end
end

assign motor_enable = m_enable;
assign motor_direction = current_direction;
assign motor_pul = motor_pulse;
assign A4988_sleep = 'b1;
assign A4988_reset = 'b1;

assign MS1 = 'b1;
assign MS2 = 'b1;
assign MS3 = 'b1;

assign onboard_led = ~position[15:0];

endmodule

module timer1 #(
  parameter COUNT_MAX = 27000000
) (
  input  wire  clk,
  output logic overflow
);

  logic [$clog2(COUNT_MAX+1)-1:0] counter = 'd0;

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

`default_nettype wire