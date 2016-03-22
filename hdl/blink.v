`timescale 1ns / 1ps

module blink 
    #(
        parameter P = 26
     )
     (
    input wire FPGA_SYSCLK_P,
    input wire FPGA_SYSCLK_N,
    input wire reset,
    output wire [1:0] LED,
    output wire [3:0] ETH_A_LED,
    output wire [3:0] ETH_B_LED
    );
  
    wire rst;
    wire clk;
    wire eth_led_clk;
    reg [31:0] count;
    wire [31:0] count_next;
    reg [3:0] eth_led;
    wire [3:0] eth_led_next;
    wire [3:0] eth_led_a;
    wire [3:0] eth_led_b;
    wire led_driver_0;
    wire led_driver_1;
    wire per_reset;
    wire high_lvl;
    wire low_lvl;

    /* next state and output logic */
    assign count_next = count + 1;
    assign led_driver_0 = count[P];
    assign high_lvl = 1;
    assign low_lvl = 0;
  
    /* ethernet leds logic */
    assign eth_led_clk = count[P-2];
    assign eth_led_a = eth_led;

`ifdef ALTERNATE
    localparam INITIAL_VAL = 4'b1111;
    assign eth_led_next = 4'b1111 ^ eth_led;
    assign led_driver_1 = ~led_driver_0;
    assign eth_led_b = ~eth_led_a;
`else
    localparam INITIAL_VAL = 4'b0001;
    assign eth_led_next = {eth_led[2:0],eth_led[3]};
    assign led_driver_1 = led_driver_0;
    assign eth_led_b = eth_led_a;
`endif

   IBUF resetibuf (
   .O (rst),
   .I (reset)
   );
    
   IBUFGDS clkibufgds
   (.O  (clk),
    .I  (FPGA_SYSCLK_P),
    .IB (FPGA_SYSCLK_N)
    );
 
  OBUF obuf_led0 (
  .I (led_driver_0),
  .O (LED[0])
  );
  
  OBUF obuf_led1 (
  .I (led_driver_1),
  .O (LED[1])
  );
  
  genvar i;
  generate
    for (i=0; i<4; i=i+1)
        begin
            OBUF obuf_eth_a_led (
                .I (eth_led_a[i]),
                .O (ETH_A_LED[i])
            );
            OBUF obuf_eth_b_led (
                .I (eth_led_b[i]),
                .O (ETH_B_LED[i])
            );
        end
    endgenerate
        
    proc_sys_reset_0 proc_sys_reset (
  .peripheral_reset (per_reset),
  .slowest_sync_clk (clk),
  .ext_reset_in (rst),
  .aux_reset_in (low_lvl),
  .mb_debug_sys_rst (low_lvl),
  .dcm_locked (high_lvl)
  );
    always @(posedge clk)
        begin
            if (per_reset == 1)
                begin
                    count <= 'h00;
                end
            else
                begin
                    count <= count_next;
                end
        end //always
                  
    always @(posedge eth_led_clk or posedge per_reset)
        begin
            if (per_reset == 1)
                begin
                    eth_led <= INITIAL_VAL;
                end
            else
                begin
                    eth_led <= eth_led_next;
                end
         end //always
       
endmodule
