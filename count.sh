#!/bin/bash
export LC_NUMERIC="en_US.UTF-8"
#declare -a ArrPubkey
declare -a ArrStake
#declare -a ArrVote
declare -a ArrWithdraw

if [ -n "$1" ]
then
 str="solana stakes $2 $1 > tmp"
else
 str="solana stakes ~/solana/vote-account-keypair.json > tmp"
fi 
#echo $str

eval $str

Counter=-1
iCounter=0
undel=0
Undelegated=0

while read line; do 

 if [[ $line == *"undelegated"* ]]; then
  undel=1
  ((Undelegated++))
 elif [[ $line == *"Active Stake"* ]]; then
  temp="${line//[^0-9.]/}"           # ONLY DIGIT

 elif [[ $line == *"Withdraw"* ]]; then
  if [[ $undel == "1" ]]; then       #   undelegated IGNORE 
   undel=0
  else
   pr="0"
   j=0
   for value in ${ArrWithdraw[@]}; do
   
    if [[ ${ArrWithdraw[j]} == ${line:(-44)} ]]; then      #ALLREADY EXIST
     pr="1" 
     break 
    fi
    ((j++))
   done
  
   if [[ $pr == "0" ]]; then
    ((iCounter++))
    ArrStake[j]=0                                          #NUMBER INDEX OF EXIST 
    ArrWithdraw[j]=${line:(-44)}
   fi 
   a=${ArrStake[j]}
   ArrStake[j]=$(bc<<<"scale=5;$a+$temp")
  
#  echo "$j.....${ArrWithdraw[j]}.......${ArrStake[j]}"
   ((Countr++))
  fi 
 fi
 
 #a=${line:0:2}
 
done < tmp

((iCountr++))
j=0
sum=0
for value in ${ArrWithdraw[@]}; do
 echo "Виздравер...${ArrWithdraw[j]}   Сумма стейков...${ArrStake[j]}"
 sum=$(bc<<<"scale=5;$sum+${ArrStake[j]}")
 ((j++))
done
echo "Стейк от $iCounter виздраверов"
echo "Всего $Countr стейков на сумму $sum"
if [[ Undelegated  -ne 0 ]]; then
 echo "Undelegated Stakes $Undelegated"
fi

if [ -f $tmp ]; then
 rm tmp
fi
