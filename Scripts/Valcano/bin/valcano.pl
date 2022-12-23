#!/usr/bin/perl

=head1 NAME

valcano: The pipeline to characterize the LTR-RTs family, classify and predict the burst families


=head1 Usage

  volcano [options]

=head1 Example

  volcano -l ltr.list -g genome.fa -p prefix 

=cut

   use warnings;
   use strict;
   use Getopt::Long;
   use Cwd;

   my $p;
   my $l;
   my $g;
   my $gz;
   my $log;
   my $h;

  GetOptions(
    "help"=>\$h,
    "p=s" =>\$p,
    "l=s"=>\$l, 
    "gz=i"=>\$gz,  
    "g=s"=>\$g);

 if($h || !defined($l) || !defined($p) || !defined($g) ){
            die `pod2text $0`;
             }


############################################# LTR family and obtain coverage

   system("list_to_5ltr.pl $l $g > $p.ltr.fa");


   system("cd-hit-est -i $p.ltr.fa -o clust.out -c 0.8 -aL 0.8 -T 0 -M 0 -n 5 -d 200");
   system("obtain_lib_list.pl clust.out.clusr > cluster.list");   
   system("RepeatMasker -e ncbi -pa 80  -q -no_is -norna -nolow -div 40 -lib clust.out -cutoff 225 $g"); 
   system("fam_coverage.pl clust.out $g.out $gz  > fam_coverage");
   
###############################################
###############################################


  system("list2_ltr_seq.pl $l $g $p; makeblastdb -in $p.ltr.fa -dbtype nucl; tblastn -query gyp.marker.fa -db $p.ltr.fa -out gyp.fa.out -max_target_seqs 1000000000 -max_hsps 1 -evalue 10e-5;tblastn -query copia.marker.fa -db $p.ltr.fa -out");
  


################














