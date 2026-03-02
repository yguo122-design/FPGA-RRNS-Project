## 这个是对encoder_3nrm_mld, decoder_3nrm_mld进行测试，使用UART进行信息反馈的一个配置文件
## Clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports { clk }]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }]

## Switch 0 (用作复位)
set_property -dict { PACKAGE_PIN A8 IOSTANDARD LVCMOS33 } [get_ports { sw0 }]

## LEDs (LD4, LD5)
## 注意：您提供的 XDC 中 led[0] 是 LD4, led[1] 是 LD5
set_property -dict { PACKAGE_PIN H5 IOSTANDARD LVCMOS33 } [get_ports { led0 }] # LD4
set_property -dict { PACKAGE_PIN J5 IOSTANDARD LVCMOS33 } [get_ports { led1 }] # LD5

## UART TX
set_property -dict { PACKAGE_PIN D10 IOSTANDARD LVCMOS33 } [get_ports { uart_tx_pin }]