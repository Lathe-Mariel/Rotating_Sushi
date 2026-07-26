module gw_gao(
    \pwm_width[7] ,
    \pwm_width[6] ,
    \pwm_width[5] ,
    \pwm_width[4] ,
    \pwm_width[3] ,
    \pwm_width[2] ,
    \pwm_width[1] ,
    \pwm_width[0] ,
    sw,
    servo_pwm,
    \counter_pwm[7] ,
    \counter_pwm[6] ,
    \counter_pwm[5] ,
    \counter_pwm[4] ,
    \counter_pwm[3] ,
    \counter_pwm[2] ,
    \counter_pwm[1] ,
    \counter_pwm[0] ,
    clk10k,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \pwm_width[7] ;
input \pwm_width[6] ;
input \pwm_width[5] ;
input \pwm_width[4] ;
input \pwm_width[3] ;
input \pwm_width[2] ;
input \pwm_width[1] ;
input \pwm_width[0] ;
input sw;
input servo_pwm;
input \counter_pwm[7] ;
input \counter_pwm[6] ;
input \counter_pwm[5] ;
input \counter_pwm[4] ;
input \counter_pwm[3] ;
input \counter_pwm[2] ;
input \counter_pwm[1] ;
input \counter_pwm[0] ;
input clk10k;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \pwm_width[7] ;
wire \pwm_width[6] ;
wire \pwm_width[5] ;
wire \pwm_width[4] ;
wire \pwm_width[3] ;
wire \pwm_width[2] ;
wire \pwm_width[1] ;
wire \pwm_width[0] ;
wire sw;
wire servo_pwm;
wire \counter_pwm[7] ;
wire \counter_pwm[6] ;
wire \counter_pwm[5] ;
wire \counter_pwm[4] ;
wire \counter_pwm[3] ;
wire \counter_pwm[2] ;
wire \counter_pwm[1] ;
wire \counter_pwm[0] ;
wire clk10k;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i(clk10k),
    .data_i({\pwm_width[7] ,\pwm_width[6] ,\pwm_width[5] ,\pwm_width[4] ,\pwm_width[3] ,\pwm_width[2] ,\pwm_width[1] ,\pwm_width[0] ,sw,servo_pwm,\counter_pwm[7] ,\counter_pwm[6] ,\counter_pwm[5] ,\counter_pwm[4] ,\counter_pwm[3] ,\counter_pwm[2] ,\counter_pwm[1] ,\counter_pwm[0] }),
    .clk_i(clk10k)
);

endmodule
