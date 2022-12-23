#!/usr/bin/perl


##### perl *pl *name_num *TE.cov

    use warnings;
    use strict;


my $usage="\n\nUsage:\n\nperl add_family_info.pl re_judge.out TE.cov\n";

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
    $hash{$a[0]}=$_;
            }
close(LOD);

    my @c;
  while(<LOP>){
          chomp;   
    @c=split/\t/,$_;
  
    if($_=~/TE_/){          
    print "$_\tFamily\tNUM\tType\tTREE_type\tID\n";
                 }else{
    
    if(defined($hash{$c[0]})){
          print "$_\t$hash{$c[0]}\n";
                             }
               }
             }  
      
               
 







 


                 



 
