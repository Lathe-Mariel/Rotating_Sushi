module gw_gao(
    \interval_time[8] ,
    \interval_time[7] ,
    \interval_time[6] ,
    \interval_time[5] ,
    \interval_time[4] ,
    \interval_time[3] ,
    \interval_time[2] ,
    \interval_time[1] ,
    \interval_time[0] ,
    \encoder_counter[8] ,
    \encoder_counter[7] ,
    \encoder_counter[6] ,
    \encoder_counter[5] ,
    \encoder_counter[4] ,
    \encoder_counter[3] ,
    \encoder_counter[2] ,
    \encoder_counter[1] ,
    \encoder_counter[0] ,
    \deb1/count[5] ,
    \deb1/count[4] ,
    \deb1/count[3] ,
    \deb1/count[2] ,
    \deb1/count[1] ,
    \deb1/count[0] ,
    pulse_triger,
    enc_pul_a,
    enc_pul_b,
    enc_a,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \interval_time[8] ;
input \interval_time[7] ;
input \interval_time[6] ;
input \interval_time[5] ;
input \interval_time[4] ;
input \interval_time[3] ;
input \interval_time[2] ;
input \interval_time[1] ;
input \interval_time[0] ;
input \encoder_counter[8] ;
input \encoder_counter[7] ;
input \encoder_counter[6] ;
input \encoder_counter[5] ;
input \encoder_counter[4] ;
input \encoder_counter[3] ;
input \encoder_counter[2] ;
input \encoder_counter[1] ;
input \encoder_counter[0] ;
input \deb1/count[5] ;
input \deb1/count[4] ;
input \deb1/count[3] ;
input \deb1/count[2] ;
input \deb1/count[1] ;
input \deb1/count[0] ;
input pulse_triger;
input enc_pul_a;
input enc_pul_b;
input enc_a;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \interval_time[8] ;
wire \interval_time[7] ;
wire \interval_time[6] ;
wire \interval_time[5] ;
wire \interval_time[4] ;
wire \interval_time[3] ;
wire \interval_time[2] ;
wire \interval_time[1] ;
wire \interval_time[0] ;
wire \encoder_counter[8] ;
wire \encoder_counter[7] ;
wire \encoder_counter[6] ;
wire \encoder_counter[5] ;
wire \encoder_counter[4] ;
wire \encoder_counter[3] ;
wire \encoder_counter[2] ;
wire \encoder_counter[1] ;
wire \encoder_counter[0] ;
wire \deb1/count[5] ;
wire \deb1/count[4] ;
wire \deb1/count[3] ;
wire \deb1/count[2] ;
wire \deb1/count[1] ;
wire \deb1/count[0] ;
wire pulse_triger;
wire enc_pul_a;
wire enc_pul_b;
wire enc_a;
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
    .trig0_i(enc_a),
    .data_i({\interval_time[8] ,\interval_time[7] ,\interval_time[6] ,\interval_time[5] ,\interval_time[4] ,\interval_time[3] ,\interval_time[2] ,\interval_time[1] ,\interval_time[0] ,\encoder_counter[8] ,\encoder_counter[7] ,\encoder_counter[6] ,\encoder_counter[5] ,\encoder_counter[4] ,\encoder_counter[3] ,\encoder_counter[2] ,\encoder_counter[1] ,\encoder_counter[0] ,\deb1/count[5] ,\deb1/count[4] ,\deb1/count[3] ,\deb1/count[2] ,\deb1/count[1] ,\deb1/count[0] ,pulse_triger,enc_pul_a,enc_pul_b}),
    .clk_i(pulse_triger)
);

endmodule
