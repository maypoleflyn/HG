#!/usr/bin/perl

  use warnings;
  use strict;
  




  my %hash;    
  my $name;
  my $cc=0;
 while(<>){
     chomp;
    $cc++;
  if($_=~/>(.*)/){
       $name=$1."\t".$cc;
                 }
  if($_=~/Sbjct(\s+)(\d+)(\s+)(\S+)(\s+)/){

       $hash{$name}.=$4;
                 }
          }


  my @key=keys%hash;
    my $count;
  foreach my $index(@key){
           $count++;
           my $length=length($hash{$index});
           my $seq=$hash{$index};
            $seq=~s/-//g; 
         print "$index\t$length\t$count\t$seq\n";
                         }
           
