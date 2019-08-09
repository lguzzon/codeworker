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

deps=$(ldd codeworker | awk 'BEGIN{ORS=" "}codeworker~/^\//{print codeworker}$3~/^\//{print $3}' | sed 's/,$/\n/')
for dep in $deps; do
  echo "$dep"
  cp "$dep" "${script_dir}/deploy/"
done

# svn --force -q add "${script_dir}/../bin/linux/"
