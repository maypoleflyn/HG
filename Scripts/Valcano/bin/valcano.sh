#!/usr/bin/bash

list2_ltr_seq.pl $1 $2 $3

makeblastdb -in $3.ltr.fa -dbtype nucl

tblastn -query ../00-volcano/dataset/Gyp_marker.fa -db $3.ltr.fa -out $3.gyp.out -max_target_seqs 1000000000 -max_hsps 1 -evalue 10e-5 
tblastn -query ../00-volcano/dataset/copia.marker.fa -db $3.ltr.fa -out $3.cop.out -max_target_seqs 1000000000 -max_hsps 1 -evalue 10e-5

extract_RT_from_blast.pl $3.gyp.out  |sort -k 1,1 -k 3,3nr -|perl -e 'while(<>){chomp;@a=split/\t/,$_;$hash{$a[0]}++;if($hash{$a[0]}==1){print ">$a[0]\n$a[4]\n";}}' -> gypsy.RT.fa
extract_RT_from_blast.pl $3.cop.out  |sort -k 1,1 -k 3,3nr -|perl -e 'while(<>){chomp;@a=split/\t/,$_;$hash{$a[0]}++;if($hash{$a[0]}==1){print ">$a[0]\n$a[4]\n";}}' -> copia.RT.fa 

cat copia.RT.fa ../00-volcano/dataset/copia.marker.fa  > copia.rt.fa
cat gypsy.RT.fa ../00-volcano/dataset/Gyp_marker.fa > gypsy.rt.fa 


mafft copia.rt.fa > copia.rt.align
fasttree -quote copia.rt.align > copia.rt.tree

mafft gypsy.rt.fa > gypsy.rt.align
fasttree -quote gypsy.rt.align > gypsy.rt.tree

assign_domain_based.pl $3.ltr.acc copia.rt.fa gypsy.rt.fa >cluster_ltr_acc_domain

obtain_lib_list_num.pl clust.out.clstr >clust.out.clstr.list

re_judge.pl clust.out.clstr.list cluster_ltr_acc_domain > re_judge.out

add_family_info.pl re_judge.out TE.cov > fam_coverage.info
