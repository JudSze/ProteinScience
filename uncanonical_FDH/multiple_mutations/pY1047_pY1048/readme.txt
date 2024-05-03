#files needed
do.sh
process.R
individual_list.txt -> to update with right mutations to run
pdb file with starting structure
select_thresh.sh

#NB
phosphoSer -> s
phosphoTyr -> y
phosphoThr -> p

							       residue;chain;position;mutation
We wrote in the individual_list.txt the double phosphorylation pY1047(y) pY1048(y). https://foldxyasara.switchlab.org/index.php/FoldX_tools_in_YASARA

#run for each model
./do.sh clusterXX.pdb  individual_list.txt

