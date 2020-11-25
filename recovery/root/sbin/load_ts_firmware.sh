#!/system/bin/sh

module_path=/sbin/modules

touch_class_path=/sys/class/touchscreen
touch_path=
firmware_path=/vendor/firmware
firmware_file=
device=$(getprop ro.boot.device)

wait_for_poweron()
{
	local wait_nomore
	local readiness
	local count
	wait_nomore=60
	count=0
	while true; do
		readiness=$(cat $touch_path/poweron)
		if [ "$readiness" == "1" ]; then
			break;
		fi
		count=$((count+1))
		[ $count -eq $wait_nomore ] && break
		sleep 1
	done
	if [ $count -eq $wait_nomore ]; then
		return 1
	fi
	return 0
}

# Load all needed modules
# Load all needed modules
insmod $module_path/bq2597x_mmi.ko
insmod $module_path/ets_fps_mmi.ko
insmod $module_path/exfat.ko
# insmod $module_path/focaltech_0flash_mmi.ko
insmod $module_path/fpc1020_mmi.ko
insmod $module_path/mmi_annotate.ko
insmod $module_path/mmi_info.ko
insmod $module_path/mmi_parallel_charger.ko
insmod $module_path/mmi_sys_temp.ko
insmod $module_path/moto_f_usbnet.ko
insmod $module_path/mpq-adapter.ko
insmod $module_path/mpq-dmx-hw-plugin.ko
insmod $module_path/nova_0flash_mmi.ko
insmod $module_path/qca_cld3_wlan.ko
insmod $module_path/qpnp_adaptive_charge.ko
insmod $module_path/qpnp-power-on-mmi.ko
insmod $module_path/rdbg.ko
insmod $module_path/sensors_class.ko
insmod $module_path/snd_smartpa_aw882xx.ko
insmod $module_path/tzlog_dump.ko
insmod $module_path/utags.ko
insmod $module_path/watchdog_cpu_ctx.ko
insmod $module_path/watchdogtest.ko
insmod $module_path/abov_sar_mmi_overlay.ko

cd $firmware_path
touch_product_string=$(ls $touch_class_path)
insmod $module_path/focaltech_0flash_mmi.ko
firmware_file="focaltech-txd-ft8756-06-0000-odessa.bin"


touch_path=/sys$(cat $touch_class_path/$touch_product_string/path | awk -Fodessa '{print $1}')
wait_for_poweron
echo $firmware_file > $touch_path/doreflash
echo 1 > $touch_path/forcereflash
sleep 5
echo 1 > $touch_path/reset

return 0

