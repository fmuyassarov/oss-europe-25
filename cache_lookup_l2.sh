#!/bin/bash
# Usage: ./cache_lookup.sh 2 4 66 68

if [ $# -eq 0 ]; then
    echo "Usage: $0 <cpu list>"
    exit 1
fi

cores=("$@")

echo "L2 cache usage for CPUs: ${cores[*]}"
declare -A seen
for cpu in "${cores[@]}"; do
    idx="/sys/devices/system/cpu/cpu$cpu/cache/index2"
    if [[ -f "$idx/id" ]]; then
        cid=$(cat "$idx/id")
        size=$(cat "$idx/size")
        cpus=$(cat "$idx/shared_cpu_list")
        if [[ -z "${seen[$cid]}" ]]; then
            echo "  L2 ID $cid (size $size) → shared by CPUs: $cpus"
            seen[$cid]=1
        fi
    fi
done

