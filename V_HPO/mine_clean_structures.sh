#!/bin/bash
structures_to_mine=$1
path_to_results=$2

PDBminer -i $structures_to_mine -n 4 -f csv

folder=$path_to_results
cd $folder

for enzyme_folder in */
do
for enzyme_file in $folder/$enzyme_folder/*.csv
do
python3 /home/szenei/ProteinScience/V_HPO/search_for_x_ray.py $enzyme_file $folder/$enzyme_folder
done
cd $enzyme_folder
for enzyme_file in *.pdb
do
foldx --command=RepairPDB --pdb-dir=$PWD --pdb=$enzyme_file
done
cd ..
done
