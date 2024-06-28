#!/bin/bash
host=$1
path=$2

file_list=$(curl -s -k -H "Accept: application/json, text/plain, */*" -H "Content-Type: application/json;charset=UTF-8" -H "Accept-Encoding: indentity"  --data-binary "{\"path\":\"$path\",\"password\":\"\",\"page_num\":1,\"page_size\":100}" "$host/api/public/path" | sed -e 's/},{/},\n{/g' | grep '"type":0,' | sed -e "s/,/\n/g" -e "s/{/\n/g" -e "s/}/\n/g" | grep ""name"" | sed -e "s/:/\n/g" | grep -v ""name"" | sed -e 's/"//g')
for file in $(echo $file_list)
do 
url="${host}${path}${file}"
echo $url
done 

path_list=$(curl -s -k -H "Accept: application/json, text/plain, */*" -H "Content-Type: application/json;charset=UTF-8" -H "Accept-Encoding: indentity"  --data-binary "{\"path\":\"$path\",\"password\":\"\",\"page_num\":1,\"page_size\":100}" "$host/api/public/path" | sed -e 's/},{/},\n{/g' | grep '"type":1,' | sed -e "s/,/\n/g" -e "s/{/\n/g" -e "s/}/\n/g" | grep ""name"" | sed -e "s/:/\n/g" | grep -v ""name"" | sed -e 's/"//g')
for path1 in $(echo $path_list)
do
newpath=$(echo "$path/$path1" | sed -e 's/\/\//\//g')
# echo $newpath
./alist2.sh $host $newpath
done

