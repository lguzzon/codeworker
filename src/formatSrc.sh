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

pushd "$script_dir"

(hash astyle || sudo apt -y install astyle)
astyle  -A3 -f -j -p -Y -K -R -H -U --options=none -z2 -Q -m0 "*.cpp"
astyle  -A3 -f -j -p -Y -K -R -H -U --options=none -z2 -Q -m0 "*.h"
astyle  -A3 -f -j -p -Y -K -R -H -U --options=none -z2 -Q -m0 "*.cpp"
astyle  -A3 -f -j -p -Y -K -R -H -U --options=none -z2 -Q -m0 "*.h"

popd
