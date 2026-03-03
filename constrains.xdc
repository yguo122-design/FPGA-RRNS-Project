## ---------------------------------------------------------
## Arty A7-100T Constraints for RRNS Test
## Top Module: test_controller
## ---------------------------------------------------------

## 1. Clock (100MHz)
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { clk }]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }]

## 2. Reset (Switch 0: OFF=Reset, ON=Run)
## 对应代码端口: rst_n
set_property -dict { PACKAGE_PIN A8 IOSTANDARD LVCMOS33 } [get_ports { rst_n }]

## 3. LEDs
## LD4 (H5) -> Pass
## LD5 (J5) -> Fail
## 对应代码端口: led_pass, led_fail
set_property -dict { PACKAGE_PIN H5 IOSTANDARD LVCMOS33 } [get_ports { led_pass }] 
set_property -dict { PACKAGE_PIN J5 IOSTANDARD LVCMOS33 } [get_ports { led_fail }] 

## 4. UART TX
## 对应代码端口: uart_tx (即 uart_tx.u_uart_tx_inst.uart_tx_pin)
## Pin D10 是 FPGA TX -> 电脑 USB-UART RX
set_property -dict { PACKAGE_PIN D10 IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]
## UART RX
set_property -dict { PACKAGE_PIN A9 IOSTANDARD LVCMOS33 } [get_ports { uart_rx }]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]