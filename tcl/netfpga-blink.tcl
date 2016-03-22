set device xc7vx690tffg1761-3
set project_name blink
set project_dir  project


create_project -name ${project_name} -force -dir "./${project_dir}" -part ${device}
#create_fileset -srcset sources_1
add_files -fileset sources_1 ./hdl/blink.v

#create_fileset -constrset constrs_1
add_files -fileset constrs_1 ./xdc/blink.xdc

#add system reset processor
create_ip -name proc_sys_reset -vendor xilinx.com -library ip -module_name proc_sys_reset_0
set proc_sys_reset_obj [get_ips proc_sys_reset_0]
reset_target all $proc_sys_reset_obj
generate_target all $proc_sys_reset_obj

set synth_obj [get_runs synth_1]
set_property strategy "Vivado Synthesis Defaults" $synth_obj
set_property flow "Vivado Synthesis 2014" $synth_obj
set_property part ${device} $synth_obj
current_run -synthesis $synth_obj
launch_runs $synth_obj
wait_on_run $synth_obj

set impl_obj [get_runs impl_1]
launch_runs $impl_obj -to_step write_bitstream
wait_on_run $impl_obj
open_run $impl_obj
write_bitstream -force ./bitfiles/${project_name}_strip.bit

reset_run $synth_obj
set_property verilog_define ALTERNATE=1 [current_fileset]
current_run -synthesis $synth_obj
launch_runs $synth_obj
wait_on_run $synth_obj
launch_runs $impl_obj -to_step write_bitstream
wait_on_run $impl_obj
open_run $impl_obj
write_bitstream -force ./bitfiles/${project_name}_alter.bit
