#!/bin/sh

if [ $# != 3 ] ; then
  echo "Usage: $0 <experiment-name> <experiment-factors-description> <experiment-command>"
  exit 1
fi

experiment_name=$1
experiment_factors_description=$2
experiment_command=$3

output_dir="experiments/$experiment_name"
scripts_dir="../../"

mkdir -p $output_dir
cd $output_dir
  # Record factors
  echo $experiment_factors_description > factors.txt

  # Run experiment
  start_time=$(date +%s)
  $scripts_dir/run-and-log-cpu-and-memory.sh "$experiment_command" raw-cpu-and-memory-log.txt
  end_time=$(date +%s)

  # Record experiment time
  echo $start_time $end_time > time-log.txt
cd -

