#!/usr/bin/perl

   use warnings;
   use strict;

   my @a;

   open LOD,"<$ARGV[0]";
   open LOP,">bed";
   open LOT,">time";
   
   my %hash1;
   my %hash2;
   my $acc;
   my %hash3;
   my $count=0;
  while(<LOD>){
      chomp;
    unless($_=~/^#/){
      @a=split/\t/,$_;
      if($_=~/^(.*?):(\d+)..(\d+)/){
            $count++;
           $acc=$1.":".$2."-".$3;  

          # print LOP "$1\t$2\t$3\n";
          # print LOT "$count\t$acc\t$a[0]\t$a[8]\t$a[9]\t$a[11]\n";  
       
             
           unless($a[11] eq "NA"){  

           print LOP "$1\t$2\t$3\n";
           print LOT "$count\t$acc\t$a[0]\t$a[8]\t$a[9]\t$a[11]\n";

           

                                   
           $hash1{$count}=[$a[9],$a[11]];

           $hash2{$acc}=$count;   
           $hash3{$acc}=$a[8];
                                }
                         }
                    }
           }

    system("bedtools getfasta -fi $ARGV[1] -bed bed >tmp1.fa");

  open LOH,"<tmp1.fa";
  open LOE,">input.fa"; 
  my $na;
  my $seq;
  my %sq;
  while(<LOH>){
      chomp;
    if($_=~/>(\S+)/){
           $na=$1;
        print LOE ">$hash2{$1}\n";
        
                    }else{
            if($hash3{$na} eq "-"){  
      
                   $seq=reverse($_);   
                   $seq=~tr/ATGCatgc/TACGtacg/; 
                print LOE "$seq\n";
                $sq{$hash2{$na}}=$seq;     
                                  }else{
        print LOE "$_\n";
               $sq{$hash2{$na}}=$_;

                                       }

                         }
             }


  system("/home/work/bin/cd-hit-v4.8.1-2019-0228/cd-hit-est -i input.fa -o clust.out -c 0.8 -aL 0.8 -T 0 -M 0 -n 5 ");   


  open LOL,"<clust.out.clstr";
  open LOK,">rps.fasta";
  my %h;
  my $m;
  while(<LOL>){
       chomp;
   if($_=~/^>(.*)/){
          $m=$1; 
                   }else{
   if($_=~/>(.*?)\.\.\./){
                          
     
          unless($h{$m}){
           

             $h{$m}=[$1,$hash1{$1}->[1]];

                        }else{
                               

    
              if($h{$m}->[1] > $hash1{$1}->[1]){   

                   $h{$m}=[$1,$hash1{$1}->[1]];
                                              }

                             }
      
                         }      
                         } 
             }

 my @key=keys %h;

    foreach my $index(@key){
               my $gr=  $hash1{$h{$index}->[0]}->[0];
               print LOK ">$h{$index}->[0]_\#$gr\n$sq{$h{$index}->[0]}\n";
                           }
      










    
   






















   
