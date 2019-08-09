#!/bin/bash

# Tips: all the quotes  --> "'`
# Tips: script path --> $(readlink -f "${0%/*}")

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
codeworkerAppDir=${script_dir}/bin/linux/$(lscpu | grep Architecture | awk '{ print $2 }')
codeworkerApp=${codeworkerAppDir}/codeworker
if ! [ -f "${codeworkerApp}" ]; then
  cd "${script_dir}/src" || (echo "ERROR - Directory does not exist [${script_dir}/src]" && exit)
  make deploy
  if ! [ -f "${codeworkerApp}" ]; then
    echo "Error can not find and build codeworker [${codeworkerApp}]"
  else
    LD_LIBRARY_PATH="${codeworkerAppDir}:$LD_LIBRARY_PATH" "${codeworkerApp}" "$@"
  fi
else
  LD_LIBRARY_PATH="${codeworkerAppDir}:$LD_LIBRARY_PATH" "${codeworkerApp}" "$@"
fi
