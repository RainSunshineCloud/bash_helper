#!/bin/bash
#删除redis指定key


host="10.0.50.61"
port=6379
pwd="online2019!kankanredis"
db=10
match_pattern="*\[quanzi\]_myFollowList_V2*"
log_path="/tmp/test.log"

#游标.开始为0，内部使用不更改
scan_num=0


while true;do
  #导出为csv
  lines=$(redis-cli -h $host --csv  -p $port -n $db -a $pwd scan $scan_num match ${match_pattern})
  #分割
  lines_arr=(${lines//\",/ })
  #数量
  arr_num=${#lines_arr[*]};
  #空key
  if [ $arr_num -lt 2 ];then
    #游标
    scan_num=$(echo $lines | sed 's/"//g' | sed 's/,//g')
    #结束
    if [ $scan_num -eq 0 ];then
      exit;
    else
      #还有数据
      continue;
    fi
  fi
  
  num=1
  for line in ${lines_arr[@]};do
    #处理引号问题
    if [ $arr_num -ne $num  ];then
      line=$line\"
    fi

    #是游标     
    if [ $num -eq 1 ];then
      scan_num=$(echo $line | sed 's/"//g')
    else
      #删除key
      echo -E 'del ' "${line}" |  redis-cli -h $host -p $port -n $db -a $pwd --raw --pipe
      echo $line >> $log_path
    fi
    #数组加1
    num=$(($num+1))
  done
  sleep 5;
done
