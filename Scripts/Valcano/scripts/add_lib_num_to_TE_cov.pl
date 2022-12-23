#!/usr/bin/perl


##### perl *pl *name_num *TE.cov


    use warnings;
    use strict;

my $usage="\n\nUsage:\nperl add_lib_num_to_TE_cov.pl\n";


if(@ARGV<2){

     die "$usage\n";
           }
             

  




   open LOD,"<$ARGV[0]";
   open LOP,"<$ARGV[1]";
 
   my %hash;
   my @a;

 while(<LOD>){
         chomp;
    @a=split/\s+/,$_;
    $hash{$a[3]}=$_;
            }
close(LOD);

    my @c;
  while(<LOP>){
          chomp;   
    @c=split/\t/,$_;
  
    if($_=~/TE_/){          
    print "$_\tCluter\tFamily\tElement\tLib_NUM\n";
                 }else{
    
    if(defined($hash{$c[0]})){
          print "$_\t$hash{$c[0]}\n";
                             }
               }
             }  
      
               
 







 


                 



 
