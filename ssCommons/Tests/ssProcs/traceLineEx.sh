#!/bin/bash

# Tips: all the quotes	--> "'` 
# Tips: script path	--> $(readlink -f "${0%/*}")

current_dir=$(pwd)
script_dir="$0"
# Need this for relative symlinks.
while [ -h "$script_dir" ] ; do
    ls=`ls -ld "$script_dir"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        script_dir="$link"
    else
        script_dir=`dirname "$script_dir"`"/$link"
    fi
done
script_dir=$(readlink -f "${script_dir%/*}")

#echo "current_dir [$current_dir]"
#echo "script_dir [$script_dir]"

script_to_find=cwRunScript.sh

path_to_search=$script_dir
file_to_search=$path_to_search/$script_to_find


while [ "$path_to_search" ]
do
    if [ -f "$file_to_search" ]
    then
        break
    else
        path_to_search=${path_to_search%/*}
        file_to_search=$path_to_search/$script_to_find
    fi
done

if [ -f "$file_to_search" ]
then
    script_name_with_no_ext=$(readlink -f "${0}")
    script_name_with_no_ext=${script_name_with_no_ext%\.*}

    "$file_to_search" "$script_name_with_no_ext.cws" "$@"
fi


