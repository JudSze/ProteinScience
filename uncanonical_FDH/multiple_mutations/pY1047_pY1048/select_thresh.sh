#!/bin/bash

#example calling script
#./select_thresh.sh $1
#$1 is the threshold for the ddg score
#./select_thresh.sh 3

THRESH=$1

echo "structure,ddg_avg,ddg_sd" > ddg_thresh_${THRESH}_models.txt

for model in model*/; do
   #modelno=$(echo "${model//[^0-9]/}")

   awk -v varthresh=${THRESH} -v varmodel=${model} '$1 >= varthresh {sub("/","",varmodel); print varmodel","$1","$2}' $model/final_average >> ddg_thresh_${THRESH}_models.txt
done




