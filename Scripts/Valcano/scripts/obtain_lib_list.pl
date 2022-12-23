#!/usr/bin/perl

####perl obtain_lib_list.pl *clustr 

    use warnings;
    use strict;

 open LOD,"<$ARGV[0]";
 open LOP,"<$ARGV[0]"; 
   
   my %hash;
   my @a;
   my $n1;
   my $n2;
 
 while(<LOD>){ 
         chomp;
     @a=split/\s+/,$_;
   if($_=~/^>(.*)/){
          $n1=$1;
                    }
   if($_=~/\*/){
           $a[2]=~/>(.*?)\.\.\./;
          my $tmp1=$1;              
          $hash{$n1}=$tmp1;
 
               }
            }
close(LOD);

############################

    my @b;
    my $n3;
 while(<LOP>){
        chomp;
    @b=split/\s+/,$_;               
   
  if($_=~/^>(.*)/){
           $n2=$hash{$1};
           $n3=$1;   
                   }else{
          $b[2]=~/>(.*?)\.\.\./;
          my $tmp2=$1;       
         
 
      print "$n3\t$n2\t$1\n";

                        }
              }   
           
















 
                
          
   









 
