#!/usr/bin/perl


    use warnings;
    use strict;

  my $usage="perl re_judge.pl clust.out.clstr.list cluster_ltr_acc_domain > re_judge.out\n";

  if(@ARGV<2){die "$usage\n";}

  
  open LOD,"<$ARGV[0]";
  open LOP,"<$ARGV[1]";
  
  my %hash;
  my @a;
  

  while(<LOP>){
       chomp;
    @a=split/\t/,$_;
    $hash{$a[1]}=[$a[0],$a[2]];
         
              }
  close(LOP);

#####################################

   my %pri;
   my %sec;
   my %num;
   my %res;

  while(<LOD>){
        chomp;
   my @b=split/\t/,$_;

   $num{$b[1]}=$b[3];

   if($b[2]=~/unknown/){
      $pri{$b[1]}{"u"}++;
                      }
   if($b[2]=~/Copia/){
       $pri{$b[1]}{"c"}++; 
                     }
   if($b[2]=~/Gyp/){
       $pri{$b[1]}{"g"}++;
                   }
    
  my $tmp=$hash{$b[2]}->[1];
  my $tid=$hash{$b[2]}->[0];

     unless(defined($tmp)){
            $tmp="unknown";  
                          }
    
     unless(defined($tid)){
            $tid="unknown";
                          }

      $sec{$b[1]}{$tmp}++;
      $res{$b[1]}{$tmp}=$tid;
              }
close(LOD);   

###########################################


     my @keys=keys%num;
     my %judge;
     my %tree;
 foreach my $index(@keys){

            my $n=$num{$index};
            unless(defined($pri{$index}{"c"})){
                      $pri{$index}{"c"}=0; 
                                              }
            unless(defined($pri{$index}{"g"})){
                      $pri{$index}{"g"}=0;
                                              }
            my $cn=$pri{$index}{"c"};
            my $gn=$pri{$index}{"g"};


            unless(defined($sec{$index}{"Copia"})){$sec{$index}{"Copia"}=0;}
            unless(defined($sec{$index}{"unknown"})){$sec{$index}{"unknown"}=0;}
            unless(defined($sec{$index}{"Gypsy"})){$sec{$index}{"Gypsy"}=0;}
            unless(defined($sec{$index}{"both"})){$sec{$index}{"both"}=0;} 

            my $c2n=$sec{$index}{"Copia"};
            my $n2n=$sec{$index}{"unknown"};
            my $g2n=$sec{$index}{"Gypsy"};
            my $b2n=$sec{$index}{"both"};  


           if($cn >$gn){
               if($c2n >0){ 
                     $judge{$index}="Copia";
                     $tree{$index}="Copia";
                             }
               if($c2n==0 && $g2n==0 && $b2n==0){ 
                      $judge{$index}="Copia";
                      $tree{$index}="unknown";        
                                                }

                if($c2n == 0 && $g2n == 0  && $n2n == 0){
                      $judge{$index}="Copia";
                      $tree{$index}="both";    
                                                }


                if($c2n == 0 && $g2n > 0 && $b2n >0){
                      $judge{$index}="Copia";
                      $tree{$index}="both";
                                                }

                 if($c2n == 0 && $g2n > 0 && $b2n ==0){
                      $judge{$index}="Copia";
                      $tree{$index}="Gypsy";
                                                 }
                     
                      
                        }             
           
#####################################

            if($cn < $gn){
               if($g2n >0){
                     $judge{$index}="Gypsy";
                     $tree{$index}="Gypsy";
                             }
               if($g2n==0 && $c2n==0 && $b2n==0){
                      $judge{$index}="Gypsy";
                      $tree{$index}="unknown";      
                                                }

                if($c2n==0 && $g2n==0 && $n2n==0){
                      $judge{$index}="Gypsy"; 
                      $tree{$index}="both";  
                                                }

                
                if($c2n > 0 && $g2n == 0 && $b2n >0){
                      $judge{$index}="Gypia";
                      $tree{$index}="both";
                                                }

                 if($c2n > 0 && $g2n == 0 && $b2n ==0){
                      $judge{$index}="Gypsy";
                      $tree{$index}="Copia";
                                                }
  

                         }             
   
           
##########################################

              if($cn ==$gn){

               if($c2n >$g2n){
                     $judge{$index}="Copia";
                     $tree{$index}="Copia";
                
                             }
               if($c2n <$g2n){
                      $judge{$index}="Gypsy";
                      $tree{$index}="Gypsy";      
                                                }

                if($c2n==0 && $g2n==0 && $n2n==0){
                      $judge{$index}="unknown"; 
                      $tree{$index}="both";  
                                                }


                if($c2n==0 && $g2n==0 && $b2n==0){
                      $judge{$index}="unknown";
                      $tree{$index}="unknown";
                                                }

                            }            


##############################################




       print "$index\t$num{$index}\t$judge{$index}\t$tree{$index}\t$res{$index}{$tree{$index}}\n";



########################################################

                                           }


############################################################


                            














   





     
 













   



















