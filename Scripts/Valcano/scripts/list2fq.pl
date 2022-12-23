#!/usr/bin/perl

    use warnings;
    use strict;

   open LOD,"<$ARGV[0]";


   my $e=$ARGV[1].".copia.fa";
   my $f=$ARGV[1].".gyp.fa";
 
    my @a;
  
  while(<LOD>){
          chomp;
     $_=~s/\.\./-/;
     @a=split/\t/,$_;   
  if($_=~/Copia/){
        system("samtools faidx $ARGV[2] $a[0] >> $e");
       #  print "samtools faidx $ARGV[2] $a[0]\n";
                 }
  if($_=~/Gypsy/){
        system("samtools faidx $ARGV[2] $a[0] >> $f");
                 }
               }                    
