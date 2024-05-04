#!/bin/bash
folder=/home/szenei/UncanonicalFDH/UncanonicalFDH/uncanonical_FDH/pdbminer/results
cd $folder
for enzyme_folder in *;
do
	cd $enzyme_folder
	for enzyme_file in *_copy.pdb
	do
		foldx --command=RepairPDB --pdb-dir=$PWD --pdb=$enzyme_file
		cd ..
	done
done
