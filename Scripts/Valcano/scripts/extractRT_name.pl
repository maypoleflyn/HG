#!/usr/bin/perl

###extract RT domain sequence from introproscan output

###perl extractRT.pl *tsv *gff *type(c/g) outprefix

 
    use warnings;
    use strict;

   
 open LOT,"<$ARGV[0]";
 open LOP,"<$ARGV[1]";
   
# my $op=$ARGV[3]."_name";
  
# open LOF,">$op";    
 
 my $type;

if($ARGV[2] eq "c"){

       $type="PF07727";     

                   } 

if($ARGV[2] eq "g"){

       $type="cd01647";   

                   } 


 
     
##############################

    my @a;
    my %hash;
    my %h;

  while(<LOT>){
        chomp;
    @a=split/\t/,$_;
    if($a[4] eq $type ){
        $hash{$a[0]}=[$a[6],$a[7]];
                   }
             } 

#########generate FASTA file 
 
  my $time=time().".fa";

  open LOJ,">$time";

   my $b1;
   my $b2;
   my $b3;

  my @c;
  my $d=0;
  my %na; 
  my %sec;
  while(<LOP>){
         chomp;
   if($_=~/getorf/){                        
     if($_=~/Target=(\S+)/){
           $b2=$1; 
           @c=split/\t/,$_;
           $b1=$c[0];
                          
            if($_=~/Name=(.*?);md/){    
                 $b3=$1;
                                   }
           $h{$b3}=$b2;
           $na{$b3}=$c[0];
           # print "$b3\t$b2\n";
           
                            }
                   }
                           
       if($_=~/^>/){
            $d=1;
                  }
               
       if($d==1){

          print LOJ "$_\n";
 
                }

               }
              
##################
                    my %count;

         system("samtools faidx $time");         
        my @keys= keys%hash;
    
              foreach my $index(@keys){
                   
                      my $l=$h{$index};
                 
                         my $g="$l:$hash{$index}->[0]-$hash{$index}->[1]";
                         $count{$g}++;                      
                  if($count{$g}==1){
             #    system("samtools faidx $time $l:$hash{$index}->[0]-$hash{$index}->[1]");

                # my $out=&seq($time,$l,$hash{$index}->[0],$hash{$index}->[1]);
                      #   if(length($out)>30){  
                      #     print ">$index\n$out\n";                       
                                          
                           print  "$na{$index}\t$index\t$g\n"; 
                                   }
                           
         
                               
            
                                      }
           system("rm $time $time.fai");

 sub seq {

      my $genome=$_[0];
      my $chr=$_[1];
      my $start=$_[2];
      my $end=$_[3];

      my $sq=`samtools faidx $genome $chr:$start-$end`;
      my @sqa=split/\n/,$sq;

              my $seqs=""; 

          foreach my $index (@sqa){
                    unless($index =~/>/){
                 $seqs.=$index; 
                                        }        
                                 }
                                                           
           return($seqs);                              
          
        }



      
           
 









    
 
 

                 

















 
                    
   

