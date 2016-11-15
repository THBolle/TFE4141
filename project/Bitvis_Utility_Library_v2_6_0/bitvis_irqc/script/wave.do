onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /irqc_tb/C_CLK_PERIOD
add wave -noupdate -radix hexadecimal /irqc_tb/clock_ena
add wave -noupdate -divider Clock,Reset,SBI
add wave -noupdate -radix hexadecimal /irqc_tb/clk
add wave -noupdate -radix hexadecimal /irqc_tb/arst
add wave -noupdate -radix hexadecimal /irqc_tb/cs
add wave -noupdate -radix hexadecimal /irqc_tb/addr
add wave -noupdate -radix hexadecimal /irqc_tb/rd
add wave -noupdate -radix hexadecimal /irqc_tb/wr
add wave -noupdate -radix hexadecimal /irqc_tb/din
add wave -noupdate -radix hexadecimal /irqc_tb/dout
add wave -noupdate -radix hexadecimal /irqc_tb/rdy
add wave -noupdate -divider {C2P, P2C and Regs}
add wave -noupdate -radix hexadecimal -childformat {{/irqc_tb/i_irqc/i_irqc_core/p2c.rw_ier -radix hexadecimal} {/irqc_tb/i_irqc/i_irqc_core/p2c.awt_itr -radix hexadecimal} {/irqc_tb/i_irqc/i_irqc_core/p2c.awt_icr -radix hexadecimal} {/irqc_tb/i_irqc/i_irqc_core/p2c.awt_irq2cpu_ena -radix hexadecimal}} -expand -subitemconfig {/irqc_tb/i_irqc/i_irqc_core/p2c.rw_ier {-radix hexadecimal} /irqc_tb/i_irqc/i_irqc_core/p2c.awt_itr {-radix hexadecimal} /irqc_tb/i_irqc/i_irqc_core/p2c.awt_icr {-radix hexadecimal} /irqc_tb/i_irqc/i_irqc_core/p2c.awt_irq2cpu_ena {-radix hexadecimal}} /irqc_tb/i_irqc/i_irqc_core/p2c
add wave -noupdate -radix hexadecimal -childformat {{/irqc_tb/i_irqc/i_irqc_core/c2p.aro_irr -radix hexadecimal} {/irqc_tb/i_irqc/i_irqc_core/c2p.aro_ipr -radix hexadecimal} {/irqc_tb/i_irqc/i_irqc_core/c2p.aro_irq2cpu_allowed -radix hexadecimal}} -expand -subitemconfig {/irqc_tb/i_irqc/i_irqc_core/c2p.aro_irr {-color White -radix hexadecimal} /irqc_tb/i_irqc/i_irqc_core/c2p.aro_ipr {-radix hexadecimal} /irqc_tb/i_irqc/i_irqc_core/c2p.aro_irq2cpu_allowed {-radix hexadecimal}} /irqc_tb/i_irqc/i_irqc_core/c2p
add wave -noupdate -radix hexadecimal /irqc_tb/i_irqc/i_irqc_core/igr
add wave -noupdate -divider {IRQ in and out}
add wave -noupdate -radix hexadecimal /irqc_tb/irq2cpu
add wave -noupdate -radix hexadecimal /irqc_tb/irq2cpu_ack
add wave -noupdate -color Cyan -radix hexadecimal /irqc_tb/irq_source
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {193798 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {270375 ps}
