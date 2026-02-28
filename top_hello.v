`timescale 1ns / 1ps

module top_full_check(
    input wire clk,               // 虽然本次测试主要用组合逻辑，但保留时钟端口
    input wire [3:0] btn,         // BTN0 - BTN3
    
    // 单色 LED (LD4 - LD7)
    output wire [3:0] led,      
    
    // RGB LED LD0
    output wire led0_r, output wire led0_g, output wire led0_b,
    // RGB LED LD1
    output wire led1_r, output wire led1_g, output wire led1_b,
    // RGB LED LD2
    output wire led2_r, output wire led2_g, output wire led2_b,
    // RGB LED LD3
    output wire led3_r, output wire led3_g, output wire led3_b
    );

    // ------------------------------------------
    // 1. 单色 LED 测试：全部常亮
    // ------------------------------------------
    assign led = 4'b1111;

    // ------------------------------------------
    // 2. RGB LED 交互测试
    // 逻辑：每个灯有一个"默认颜色"，当对应的按钮按下时，切换到"激活颜色"
    // ------------------------------------------
    
    // --- LD0 测试 (对应 BTN0) ---
    // 默认：红色 (R=1, G=0, B=0)
    // 按下 BTN0：变为 黄色 (R=1, G=1, B=0) -> 只有 G 通道受按钮控制
    assign led0_r = 1'b1;
    assign led0_g = btn[0];       // 按下(1)变黄，松开(0)变红
    assign led0_b = 1'b0;

    // --- LD1 测试 (对应 BTN1) ---
    // 默认：绿色 (R=0, G=1, B=0)
    // 按下 BTN1：变为 青色 (R=0, G=1, B=1) -> 只有 B 通道受按钮控制
    assign led1_r = 1'b0;
    assign led1_g = 1'b1;
    assign led1_b = btn[1];       // 按下(1)变青，松开(0)变绿

    // --- LD2 测试 (对应 BTN2) ---
    // 默认：蓝色 (R=0, G=0, B=1)
    // 按下 BTN2：变为 紫色/品红 (R=1, G=0, B=1) -> 只有 R 通道受按钮控制
    assign led2_r = btn[2];       // 按下(1)变紫，松开(0)变蓝
    assign led2_g = 1'b0;
    assign led2_b = 1'b1;

    // --- LD3 测试 (对应 BTN3) ---
    // 默认：白色 (R=1, G=1, B=1)
    // 按下 BTN3：变为 熄灭 (R=0, G=0, B=0) -> 所有通道受按钮反相控制
    assign led3_r = ~btn[3];      // 按下(1)变0(灭)，松开(0)变1(亮)
    assign led3_g = ~btn[3];
    assign led3_b = ~btn[3];

endmodule