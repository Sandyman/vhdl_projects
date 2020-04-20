`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2020 20:29:51
// Design Name: 
// Module Name: fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_light_controller(
    input clk,
    input reset,
    input button,
    output led0_g, // Road
    output led0_r,
    output led1_g, // X-ing
    output led1_r);

wire clock;

wire xing_red;
wire xing_green;
wire xing_set;
wire xing_flash_expired;
wire xing_grace_expired;
wire xing_green_expired;

wire flash;
wire btn;
wire done;
wire go;

wire road_red;
wire road_yellow;
wire road_set;
wire road_grace_expired;
wire road_green_expired;
wire road_yellow_expired;

wire [7:0] pwm_reg;

localparam brightness = 240; // 0 (lightest) .. 249 (darkest, off even?)

assign led0_r = (pwm_reg >= brightness) && road_red;
assign led0_g = (pwm_reg >= brightness) && road_green;

assign led1_r = (pwm_reg >= brightness) && xing_red;
assign led1_g = (pwm_reg >= brightness) && xing_green;

clock_divider clock_div(
    .reset(reset),
    .clk(clk),
    .clock(clock));

pwm pwm(
    .reset(reset),
    .clock(clk),
    .pwm(pwm_reg));

road_timer road_tim(
    .reset(reset),
    .clock(clock),
    .set(road_set),
    .grace_expired(road_grace_expired),
    .green_expired(road_green_expired),
    .yellow_expired(road_yellow_expired));

road_fsm road_state_machine(
    .reset(reset),
    .clock(clock),
    .btn(btn),
    .done(done),
    .grace_expired(road_grace_expired),
    .green_expired(road_green_expired),
    .yellow_expired(road_yellow_expired),
    .set(road_set),
    .go(go),
    .red(road_red),
    .green(road_green));

xing_timer xing_tim(
    .reset(reset),
    .clock(clock),
    .set(xing_set),
    .flash(flash),
    .flash_expired(xing_flash_expired),
    .grace_expired(xing_grace_expired),
    .green_expired(xing_green_expired));

xing_fsm xing_state_machine(
    .reset(reset),
    .clock(clock),
    .button(button),
    .go(go),
    .flash(flash),
    .grace_expired(xing_grace_expired),
    .green_expired(xing_green_expired),
    .flash_expired(xing_flash_expired),
    .set(xing_set),
    .btn(btn),
    .done(done),
    .red(xing_red),
    .green(xing_green));

endmodule
