module sw_debounce(
input clock_in,
input sw_in,
output  sw_out);

reg sw_out;
reg sw_prv;
reg [5:0]count;

always @(posedge clock_in) begin
  if (sw_prv == sw_in) begin
    if (count == 0) begin
      sw_out = sw_in;
    end
    else begin
     count = count + 1;
    end
  end
  else begin
    count = 1;
  end
  sw_prv = sw_in;
end
endmodule