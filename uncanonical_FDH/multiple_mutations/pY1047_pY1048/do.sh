#!/usr/bin/env bash

pdb=$1
mutfile=$2

foldx_dir=/usr/local/foldx5_2021/
foldx_bin=${foldx_dir}/foldx

repair_cfg="repair.cfg"
mutate_cfg="mutate.cfg"
interface_cfg="interface.cfg"

nruns=5
sysname=${pdb%".pdb"}
repaired_pdb=${sysname}_Repair.pdb
pdb_list=PdbList_${sysname}_Repair.fxout

mkdir $sysname
cd $sysname
cp ../$pdb . 
cp ../$mutfile individual_list.txt
cp $foldx_dir/rotabase.txt .

if [ ! -f $repaired_pdb ]; then

	cat << EOF > $repair_cfg
command=RepairPDB
pdb=$pdb

temperature=298
water=-CRYSTAL
complexWithDNA=true
EOF

	$foldx_bin -f $repair_cfg &> repair.log
fi


if [ ! -f $pdb_list ]; then
	cat << EOF > $mutate_cfg
command=BuildModel
pdb=$repaired_pdb
mutant-file=individual_list.txt
numberOfRuns=$nruns
temperature=298
EOF

	$foldx_bin -f $mutate_cfg &> mutate.log
fi


cat <<EOF > $interface_cfg
command=AnalyseComplex
pdb-list=$pdb_list
temperature=298
pH=7
ionStrength=0.050
vdwDesign=2
pdbHydrogens=false
EOF

$foldx_bin -f $interface_cfg &> interface.log
#Summary_WT_model_1_Repair_1_3_AC.fxout

wt_energies_f="wt_energies"
mut_energies_f="mut_energies"
echo -n '' > $wt_energies_f
echo -n '' > $mut_energies_f
for i in $(seq 0 $(($nruns-1))); do
	mut_file="Summary_${sysname}_Repair_1_${i}_AC.fxout"
	wt_file="Summary_WT_${sysname}_Repair_1_${i}_AC.fxout"
	echo $(tail -n1 $mut_file | cut -f6) >> $mut_energies_f
	echo $(tail -n1 $wt_file  | cut -f6) >> $wt_energies_f
done

Rscript ../process.R

