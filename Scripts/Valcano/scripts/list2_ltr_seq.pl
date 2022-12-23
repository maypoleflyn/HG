#!/usr/bin/perl

##perl list2_ltr_seq.pl *list *genome
#
#    obtain the LTR seq

      use warnings;
      use strict;

my $usage="\n\nUsage:\nperl list2_ltr_seq.pl *list *genome.fa prefix\n";


 if(@ARGV<3){
        die "$usage\n";
            }









     open LOD,"<$ARGV[0]";

     my $o_1=$ARGV[2].".ltr.fa";
     my $o_2=$ARGV[2].".ltr.acc";   


     open LOP,">$o_1";
     open LOT,">$o_2";

       
      my @a;
      my $f;
      my $n1; 
      my $seq_c=0;
      my $nw;
     
    
      my $chr;
 
  while(<LOD>){
        chomp;
    unless($_=~/#/){
       @a=split/\t/,$_;
      if($a[0] =~/(\d+)\.\.(\d+)/){  
               $f=$1;
               $nw=$2; 
               $n1=$a[0]."_LTR#".$a[10]."/".$a[9];  
                                  }  
       if($a[0] =~/(.*?):/){
                $chr=$1; 
                           }                                  

      #print "$n1\t$n2\t$n3\t$chr\t$f\t$in1\t$t\t$in2\n"; 

       my $sq1=&seq($ARGV[1],$f,$nw,$chr,$a[8]); 
      
        

     # print ">$n1\n$sq1\n>$n2\n$sq2\n>$n3\n$sq3\n"; 
        $seq_c++;
       
       print LOP  ">$seq_c\n$sq1\n";
       print LOT "$seq_c\t$n1\n";    
         
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



  
   
