#!/usr/bin/perl

##perl list2ltr.pl *list *genome

      use warnings;
      use strict;

my $usage="\n\nUsage:\nObtain the 5-LTR sequences\nperl list_to_5ltr.pl  *list *genome.fa\n";


if(@ARGV<2){
      die "$usage\n";
           }





     open LOD,"<$ARGV[0]";
     
      my @a;
      my $f;
      my $t;
      my $in1;
      my $in2; 
      my $n1;
      my $n2;
      my $n3;
      my $chr;
 
  while(<LOD>){
        chomp;
    unless($_=~/#/){
       @a=split/\t/,$_;
      if($a[0] =~/(\d+)\.\.(\d+)/){  
              $f=$1;
              $n1=$a[0]."_LTR#".$a[10]."/".$a[9];  
                                  }

      if($a[6] =~/(\d+)\.\.(\d+)/){                     
                $in1=$1;
                $in2=$2;
                $n3=$a[0]."_INT_".$a[9];                
                                  }      
       if($a[0] =~/(.*?):/){
                $chr=$1; 
                           }                                  

     # print "$n1\t$in2\t$n3\t$chr\t$f\t$in1\t$_\n"; 

       my $sq1=&seq($ARGV[1],$f,$in1,$chr,$a[8]); 
     
     # print ">$n1\n$sq1\n>$n2\n$sq2\n>$n3\n$sq3\n"; 
       print ">$n1\n$sq1\n";
     #   print ">$n2\n$sq2\n";

                  }
             }

 
    sub seq{

       my $genome=$_[0];
       my $start=$_[1];
       my $end=$_[2];
       my $chr=$_[3];
       my $fx=$_[4];          

        my $ss=`samtools faidx $genome $chr:$start-$end`;
        my @se=split/\n/,$ss;
        my $seqs=""; 

          foreach my $index (@se){
                    unless($index =~/>/){
                 $seqs.=$index; 
                                        }        
                                 }
                 if($fx eq "-" ){
                    $seqs=~tr/ATGC/TACG/;
                    $seqs=reverse($seqs);                    
                                }                                               
           return($seqs);                                  
                                              
 
          } 


       
 

 
  
   
 




  
   
