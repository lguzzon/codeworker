#!/bin/bash

# Tips: all the quotes	--> "'`
# Tips: script path	--> $(readlink -f "${0%/*}")

current_dir=$(pwd)
script_dir="$0"
# Need this for relative symlinks.
while [ -h "$script_dir" ]; do
  ls=$(ls -ld "$script_dir")
  link=$(expr "$ls" : '.*-> \(.*\)$')
  if expr "$link" : '/.*' >/dev/null; then
    script_dir="$link"
  else
    script_dir=$(dirname "$script_dir")"/$link"
  fi
done
script_dir=$(readlink -f "${script_dir%/*}")

#echo "current_dir [$current_dir]"
#echo "script_dir [$script_dir]"

main_script_path=$(readlink -f "${1%/*}")
#echo "main_script_path [$main_script_path]"
CWP_INCLUDES_STR=""
if [ -n "${CWP_INCLUDES}" ]; then
  CWP_INCLUDES_STR="-i ${CWP_INCLUDES}"
fi
script_file=$1
shift
"${script_dir}/cw.sh" -i "${script_dir}/ssCommons" ${CWP_INCLUDES_STR} -nologo -varexist -fast -script "${script_file}" -path "${main_script_path}" -args "$@"
