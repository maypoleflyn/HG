#!/usr/bin/perl


    use warnings;
    use strict;

###################################

    open LOP,"<$ARGV[0]";

    my @b;     
    my %hash;
 
   while(<LOP>){
           chomp;
       @b=split/\t+/,$_;
       $hash{$b[0]}{$b[1]}++;
       $hash{$b[1]}{$b[0]}++;                           
               }



########################################


    open LOD,"<$ARGV[1]";

  my $n1;
  my $n2;
  my @d;
 while(<LOD>){
      chomp;
    @d=split/\s+/,$_;
    $n1=$d[1];
    $n2=$d[5];
      if(defined($hash{$n1}{$n2}) || defined($hash{$n2}{$n1})){
                  next; 
                                                              }                               
         print "$_\n";
                     
              }



