#!/bin/sh

if [ $# != 2 ] ; then
  echo "Usage: $0 <command-to-run> <output-file>"
  exit 1
fi

command_to_run=$1
log_output_file=$2
interval_between_measurements=1
scripts_dir="$(dirname $(readlink -f $0))"

$command_to_run &
$scripts_dir/cpu-and-memory-usage-logger.sh $! $interval_between_measurements > $log_output_file &
wait
