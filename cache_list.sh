#!/bin/bash
#
#echo "L2 cache sharing topology:"
#declare -A seen
#for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
#    idx="$cpu/cache/index2"
#    if [[ -f "$idx/shared_cpu_list" ]]; then
#        cpus=$(cat "$idx/shared_cpu_list")
#        # Deduplicate by unique CPU set
#        if [[ -z "${seen[$cpus]}" ]]; then
#            echo "  L2 shared by CPUs: $cpus"
#            seen[$cpus]=1
#        fi
#    fi
#done
echo "L2 cache topology (ID → CPUs):"
declare -A seen

for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
    idx="$cpu/cache/index2"
    if [[ -f "$idx/shared_cpu_list" ]]; then
        cid=$(cat "$idx/id")
        cpus=$(cat "$idx/shared_cpu_list")
        if [[ -z "${seen[$cid]}" ]]; then
            echo "  L2 ID $cid → CPUs: $cpus"
            seen[$cid]=1
        fi
    fi
done

