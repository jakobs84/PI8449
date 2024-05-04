transcript on

vlib work
vmap work

vlog -work work {../inverseSbox.v}
vlog -work work {../keyExpansion.v}
vlog -work work {../mixColumns.v}
vlog -work work {../sbox.v}
vlog -work work {../addRoundKey.v}
vlog -work work {../inverseSubBytes.v}
vlog -work work {../inverseMixColumns.v}
vlog -work work {../inverseShiftRows.v}
vlog -work work {../shiftRows.v}
vlog -work work {../subBytes.v}
vlog -work work {../encryptRound_reg.v}
vlog -work work {../decryptRound_reg.v}
vlog -work work {../AES_Decrypt_reg.v}
vlog -work work {../AES_Encrypt_reg.v}
vlog -work work {../AES.v}
vlog -work work {../AES_tb.v}


vsim -t 1ns -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L work -sv_seed random -voptargs="+acc" AES_tb

add wave -noupdate /AES_tb/a/in
add wave -noupdate /AES_tb/a/encrypted128
add wave -noupdate /AES_tb/a/encrypted192
add wave -noupdate /AES_tb/a/encrypted256
add wave -noupdate /AES_tb/a/decrypted128
add wave -noupdate /AES_tb/a/decrypted192
add wave -noupdate /AES_tb/a/decrypted256
add wave -noupdate /AES_tb/d128
add wave -noupdate /AES_tb/d192
add wave -noupdate /AES_tb/d256


view structure
view signals
run 600ns