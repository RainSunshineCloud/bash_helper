#!/bin/bash

#binlog文件
dir="../data/"
exp="KBJ01148-bin\.22[2-3]{1}[0-9]{2}"
next_start=22253
stop_start=22371
position=736938976

#mysql路径
mysqlbinlog_bin_path=/usr/local/mysql/bin/mysqlbinlog
user="root"
pwd="sd-9898w"

#存储路径
store_dir="../binlog_file"

for file in `ls ${dir}`;do
if [[ "$file" =~ $exp  ]];then
   num="${file:13}"
   abspath="${dir}/${file}"
   storepath="${store_dir}/${file}.sql"
   if [ ${num} -gt ${next_start} ] && [ ${num} -lt ${stop_start} ]; then
     echo $abspath
     $mysqlbinlog_bin_path -u${user} -p${pwd} "$abspath" > $storepath
   elif [ ${num} -eq ${next_start} ]; then
     echo $abspath
     $mysqlbinlog_bin_path -u${user} -j${position} -p${pwd} ${abspath} > $storepath
   fi
fi
done
