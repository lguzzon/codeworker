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

architetture_dir=${script_dir}/../bin/linux/$(lscpu | grep Architecture | awk '{ print $2 }')
echo "Codeworker [${architetture_dir}]"
if [ -d "${architetture_dir}" ]; then
  rm -R ${architetture_dir}
fi
mkdir -p "${architetture_dir}"
mv "${script_dir}"/deploy/* "${architetture_dir}"
svn info >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
  svn --parents --force -q add "${architetture_dir}"/*
  svn --parents --force -q add "${architetture_dir}"/lib/*
fi
