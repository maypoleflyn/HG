#!/usr/bin/perl

   use warnings;
   use strict;

my $usage="\nUsage:\n\nperl assign_domain_based.pl cluster_ltr_acc copia.rt.fa gyp.rt.fa >cluster_ltr_acc_domain\n\n";

if(@ARGV <2){ die "$usage\n";}

   open LOD,"<$ARGV[0]";
   open LOP,"<$ARGV[1]";
   open LOT,"<$ARGV[2]";

################################
     my %c;          
while(<LOP>){
        chomp;
  my @a=split/\t/,$_;
 if($_=~/>(.*)/){
       $c{$1}++;
                }
            } 

#####################################    
     my %g;
while(<LOT>){
        chomp;
  my @b=split/\t/,$_;
 if($_=~/>(.*)/){
       $g{$1}++;
                }
            }
#############################################

    while(<LOD>){
          chomp;
        my @d=split/\t/,$_;
         
        if(defined($c{$d[0]}) && !defined($g{$d[0]})){ 
               print "$_\tCopia\n";
                                                     }
        if(!defined($c{$d[0]}) && defined($g{$d[0]})){
                 print "$_\tGypsy\n";
                                                     }
        if(!defined($c{$d[0]}) && !defined($g{$d[0]})){
                 print "$_\tunknown\n";
                                                      }
        if(defined($c{$d[0]}) && defined($g{$d[0]})){
                print "$_\tboth\n";
                                                     }
               }
         
           











        
  

    
    
        
 

