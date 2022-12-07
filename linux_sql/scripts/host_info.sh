#! bin/bash

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

if [ $# -ne 5 ]; then
  echo "5 parameters required"
  exit 1
fi


hostname=$(hostname -f)
lscpu_out=`lscpu`
mem_out=$(cat /proc/meminfo)

cpu_number=$(echo "$lscpu_out" | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out" | egrep -i '^Archi' | awk '{print $2}' | xargs)
cpu_model=$(echo "$lscpu_out" | egrep '^Model+(\s)' | awk '{print $3,$4,$5,$6,$7}' | xargs)
cpu_mhz=$(echo "$lscpu_out" | egrep '^CPU+\s+MHz' | awk '{print $3}' | xargs)
L2_cache=$(echo "$lscpu_out" | egrep '^L2' | awk '{print $3}' | xargs)
total_mem=$(echo "$mem_out" | egrep '^MemT' | awk '{print $2}' | xargs)
timestamp=$(vmstat -t| tail -1 | awk '{print $18,$19}' | xargs)

insert_stmt="INSERT INTO host_info(hostname, cpu_number, cpu_architecture, cpu_model, cpu_mhz, L2_cache, total_mem, timestamp) VALUES('$hostname', '$cpu_number', '$cpu_architechture', '$cpu_model', '$cpu_mhz', '$L2_cache', '$total_mem', '$timestamp')"

export PGPASSWORD=$psql_password

psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"

exit $?
