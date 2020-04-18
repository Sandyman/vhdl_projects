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

// We slow down the 50 MHz clock to 8 Hz
`define CLOCK_MAX_COUNT     23'd6249999
`define TICKS_PER_SECOND    8

module clock_divider(
    input reset,
    input clk,
    output clock);

reg [22:0] counter = 23'd0;
reg clock_out;

assign clock = clock_out;

always @ (posedge clk)
begin
    if (reset)
        counter <= 23'd0;
    else if (counter >= `CLOCK_MAX_COUNT)
    begin
        counter <= 23'd0;
        clock_out <= ~clock_out;
    end
    else
        counter <= counter + 1;
end

endmodule


module road_timer(
    input reset,
    input clock,
    input set,
    output grace_expired,
    output green_expired,
    output yellow_expired);

reg [7:0] counter = 0;

assign grace_expired = (counter >= 2 * `TICKS_PER_SECOND);
assign green_expired = (counter >= 20 * `TICKS_PER_SECOND);
assign yellow_expired = (counter >= 5 * `TICKS_PER_SECOND);

always @ (posedge clock)
begin
    if (reset || set)
        counter <= 0;
    else if (~ (grace_expired && green_expired && yellow_expired))
        counter <= counter + 1;
end
endmodule


module road_fsm(
    input reset,
    input clock,
    input btn,
    input done,
    input grace_expired,
    input green_expired,
    input yellow_expired,
    output reg set,
    output reg go,
    output red,
    output green);

localparam GN=0, YL=1, RD=2, GC=3;

reg [3:0] current;
reg [3:0] next;

assign red = current[RD] | current[GC] | current[YL];
assign green = current[GN] | current[YL];

always @ (posedge clock)
begin
    if (reset)
    begin
        current <= 4'b0;
        current[GC] <= 1'b1;
    end
    else
        current <= next;        
end

always @ (*)
begin
    next = 4'b0000;
    set = 1'b0;
    go = 1'b0;
    case (1'b1)
        current[GN]: begin
            if (green_expired && btn) begin
                next[YL] = 1'b1;
                set = 1;
            end
            else
                next[GN] = 1'b1;
        end
        current[YL]: begin
            if (yellow_expired) begin
                next[RD] = 1'b1;
                set = 1;
                go = 1;
            end
            else
                next[YL] = 1'b1;
        end
        current[RD]: begin
            if (done) begin
                set = 1;
                next[GC] = 1'b1;
            end
            else
                next[RD] = 1'b1;
        end
        current [GC]: begin
            if (grace_expired) begin
                set = 1;
                next[GN] = 1'b1;
            end
            else
                next[GC] = 1'b1;
        end
    endcase
end

endmodule


module xing_timer(
    input reset,
    input clock,
    input set,
    output flash,
    output grace_expired,
    output green_expired,
    output flash_expired);

reg [7:0] counter = 0;

assign grace_expired = (counter >= 2 * `TICKS_PER_SECOND);
assign green_expired = (counter >= 12 * `TICKS_PER_SECOND);
assign flash_expired = (counter >= 8 * `TICKS_PER_SECOND);

always @ (posedge clock)
begin
    if (reset || set)
        counter <= 0;
    else if (~ (grace_expired && green_expired && flash_expired))
        counter <= counter + 1;
end

//
// The next part creates a 1Hz "flash" clock
//
reg [2:0] flash_clk = 2'd0;
reg flash_out;

always @ (posedge clock)
begin
    if (reset) begin
        flash_clk <= 2'd0;
    end
    else if (flash_clk >= (`TICKS_PER_SECOND / 2)) begin
        flash_clk <= 2'd0;
        flash_out <= ~ flash_out;
    end
    else
        flash_clk <= flash_clk + 1;
end

assign flash = flash_out;

endmodule


module xing_fsm(
    input reset,
    input clock,
    input button,
    input go,
    input flash,
    input grace_expired,
    input green_expired,
    input flash_expired,
    output reg set,    
    output btn,
    output reg done,
    output red,
    output green);

localparam RD=0, // Red 
           GR=1, // Grace period before Green
           GN=2, // Green
           FL=3, // Flashing Red
           GC=4; // Grace period before Red

reg [4:0] current;
reg [4:0] next;

reg button_pressed = 0;
reg clr_button = 0;

assign green = current[GN];
assign red = current[RD] || current[GR] || current[GC] || current[FL] && flash;

assign btn = button_pressed;

always @ (posedge clock)
begin
    if (reset || clr_button) begin
        button_pressed <= 0;
    end
    else
        button_pressed <= button_pressed | button;
end

always @ (posedge clock)
begin
    if (reset)
    begin
        current <= 5'b00000;
        current[GC] <= 1'b1;
    end
    else
        current <= next;        
end

always @ (*)
begin
    next = 5'b00000;
    set = 1'b0;
    done = 1'b0;
    clr_button = 1'b0;
    case (1'b1)
    current[RD]: begin
        if (go) begin
            clr_button = 1;
            set = 1;
            next[GR] = 1'b1;
        end
        else
            next[RD] = 1'b1;
    end
    current[GR]: begin
        if (grace_expired) begin
            set = 1;
            next[GN] = 1'b1;
        end
        else
            next[GR] = 1'b1;
    end
    current[GN]: begin
        if (green_expired) begin
            set = 1;
            next[FL] = 1'b1;
        end
        else
            next[GN] = 1'b1;
    end
    current[FL]: begin
        if (flash_expired) begin
            set = 1;
            next[GC] = 1'b1;
        end
        else
            next[FL] = 1'b1;
    end
    current[GC]: begin
        if (grace_expired) begin
            set = 1;
            done = 1;
            next[RD] = 1'b1;
        end
        else
            next[GC] = 1'b1;
    end
    endcase
end

endmodule


module traffic_light_controller(
    input clk,
    input reset,
    input button,
    output led0_g, // Road
    output led0_r,
    output led1_g, // X-ing
    output led1_r);

wire clock;

wire xing_set;
wire xing_flash_expired;
wire xing_grace_expired;
wire xing_green_expired;

wire flash;
wire btn;
wire done;
wire go;

wire road_set;
wire road_grace_expired;
wire road_green_expired;
wire road_yellow_expired;

clock_divider clock_div(
    .reset(reset),
    .clk(clk),
    .clock(clock));

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
    .red(led0_r),
    .green(led0_g));

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
    .red(led1_r),
    .green(led1_g));

endmodule
