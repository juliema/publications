#!usr/bin/env perl

## This script will  calculate uncorrected p-distances from a 
##  aligned phylip or fasta file of n sequences. Each file will produce one distance file.

use strict;
use warnings;

system "ls -l *.afa >filenames";
open FH, "<filenames";
while (<FH>) {
        if (/(\S+).afa/) {
                my $file=$1;
                print "$file\n";
                open FH1, "<$file.afa";
                open OUT, ">$file.phy";
                while (<FH1>) {
                        if (/^>(\S+)/){
                                my $name=$1;
                                print OUT "\n$name\t";
                        }
                        else {
                                my $seq=$_;
                                chomp $seq;
                                print OUT "$seq";
                        }
                }
        }
}
close FH;
close FH1;
system "ls -l *.phy >filenames";
open FHf, "<filenames";
while (<FHf>) {
        my @namearray=();
        my %length=();
        my @seqarray=();
        my @bigarray=();
        if (/(\S+).phy/) {
        #if (/(3lines).phy/) {
                my $file=$1;
                open OUT, ">P-dist.$file.txt";
                open FH, "<$file.phy"; # print "$file.phy\n";
                my $row=0;
                while (<FH>) {
                        #print;
                        if (/^(\S+)\s+(\S+)/ && ! /^\d+\s+\d+/) {
                                my $tax=$1;
                                my $seq=$2;
                                print "$tax\n";
                                push @namearray, $tax;
                                my $size=length($seq);
                                $length{$tax}=$size;
                                push @seqarray, $seq;
                                my @new= split(//, $seq);
                                for my $nuc (@new){
                                        push @{$bigarray[$row]}, $nuc;
                                }
                        $row++;
                        }

                }
                print "$bigarray[0][0]\t$bigarray[1][0]\n";
                ## calculate the number of pairwise comparisons the formula is ((N-1)N)/2
                my $numseq=scalar @bigarray;
                #$numseq=$numseq-1;
                print "number of sequences is $numseq\n";
                print "scalar bigarray $numseq\n";
                my $numcomp = (($numseq-1)*$numseq)/2;
                my $sequence1=0;
                my $sequence2=1;
                print "The number of comparisons is $numcomp\n";
                for (1..$numcomp) {
                        my $site=0;
                        my $sequence = $seqarray[$sequence1];
                        my $size = length$sequence;
                        my $numdiff=0;
                        print "size \t $size\n";
                        for (0..$size-1) {
                                my $nuc1 = $bigarray[$sequence1][$site];
                                my $nuc2 = $bigarray[$sequence2][$site];
                                #print "$nuc1\t$nuc2\n";
                                if ($nuc1 ne  $nuc2) {
                                        $numdiff++;
                                }
                                $site++;
                        }
                        my $distance=$numdiff/$size;
                        print OUT "$namearray[$sequence1]\t$namearray[$sequence2]\t$size\t$numdiff\t$distance\n";
                        print "$namearray[$sequence1]\t$namearray[$sequence2]\t$size\t$numdiff\t$distance\n";
                        #print "Sequence  $sequence1 \t Sequence $sequence2\n"; 
                        if ($sequence2 == ($numseq-1)) { $sequence1++; $sequence2 = $sequence1 + 1; }
                        elsif ( $sequence2 != $numseq) { $sequence2++; }
                }
        }
}

