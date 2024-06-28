#!/bin/bash
for host in $(cat ./alist.txt)
do 
{
result=$(curl -s -k -m 3 --retry 1 -H "Accept: application/json, text/plain, */*" -H "Content-Type: application/json;charset=UTF-8" -H "Accept-Encoding: indentity" --data-binary "{\"path\":\"/\",\"password\":\"\",\"page_num\":1,\"page_size\":30}" "$host/api/public/path" | grep '"files":\[{"name"')
if [ -z "$result" ]
then 
echo "不能访问 alist: $host"
# continue
# echo $result
else 
echo "能访问 alist: $host"
# 
echo $host >> 能访问.txt
# path_list=$(curl -s -k -H "Accept: application/json, text/plain, */*" -H "Content-Type: application/json;charset=UTF-8" -H "Accept-Encoding: indentity"  --data-binary "{\"path\":\"/\",\"password\":\"\",\"page_num\":1,\"page_size\":100}" "$host/api/public/path" | sed -e "s/,/\n/g" -e "s/{/\n/g" -e "s/}/\n/g" | grep ""name"" | sed -e "s/:/\n/g" | grep -v ""name"" | sed -e 's/"//g')
# for path in $(echo $path_list)
# do
# echo "### "
# curl -s -k -H "Accept: application/json, text/plain, */*" -H "Content-Type: application/json;charset=UTF-8" -H "Accept-Encoding: indentity" --data-binary "{\"path\":\"/$path\",\"password\":\"\",\"page_num\":1,\"page_size\":30}"  "https://$host/api/public/path"
# done
#
fi 
} &
done 
wait
