#!/bin/bash
target=$1

structures= find ./TEs -name *_Repair.pdb
echo $structures

for structure in $structures
do
python3 /home/szenei/ProteinScience/structure_analysis/structural_alignment.py $target $structure | grep -e RMSD -e "TM-score    ="
done