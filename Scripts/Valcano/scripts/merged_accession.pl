#!/usr/bin/perl

#### Usage:
#### perl merged_accession.pl cluster.list full_ltr.ltr.acc > cluster_ltr_acc

    use warnings;
    use strict;

my $usage="\nUsage:\nperl merged_accession.pl full_ltr.ltr.acc cluster.list > cluster_ltr_acc\n";


 if(@ARGV<2){
          die "$usage\n";
           }


   open LOD,"<$ARGV[0]";
   open LOP,"<$ARGV[1]";   

    my %hash;
    my @a;
    my @b;

  while(<LOD>){
         chomp;
     @a=split/\t/,$_;
     $hash{$a[1]}=$a[0];
              }
 close(LOD);

####
 
 print "#CLUSTER\tFamily\tELEMENT\tTREEID\n";


  while(<LOP>){
         chomp;
       @b=split/\t/,$_;     
      print "$_\t$hash{$b[2]}\n";
             }



















 

   



     
  



