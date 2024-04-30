#!/bin/bash

# Define the name of kubernetes controller
k='microk8s.kubectl'

# Define Job Prefix
job_prefix_name="${1}"

# Search for Job via prefix
for job_name in $($k get jobs | egrep "${job_prefix_name}" | awk '{print $1}');
do
  # Check is running
  if [ -n "$($k get jobs ${job_name} 2> /dev/null | egrep ${job_prefix_name} | awk '{print $1}')" ];
  then
    # Kill any running jobs with the defined prefix
    printf "Attempting, to stop job: ${job_name}\n"
    $k delete jobs ${job_name}
  fi
done
