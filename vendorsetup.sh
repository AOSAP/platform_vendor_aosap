#aosp_devices=('blueline' 'bonito' 'crosshatch' 'dragon' 'marlin' 'sargo' 'taimen')
#caf_devices=('oneplus3')
aosp_devices=('taimen')

function lunch_devices() {
    add_lunch_combo du_${device}-user
    add_lunch_combo du_${device}-userdebug
}

#if [[ $( grep -i "caf" manifest/README.md) ]]; then
    #for device in ${caf_devices[@]}; do
        #lunch_devices
    #done
#else
    for device in ${aosp_devices[@]}; do
        lunch_devices
    done
#fi
