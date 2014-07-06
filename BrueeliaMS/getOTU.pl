#!usr/bin/perl

use warnings;
use strict;

my $OTU = 0.895;

open OUT, ">Pairwise.90.txt";
my $lines=0;
my @names=();
my $count=0;
my %specieshash=();

open FH, "<Result.bGMYC.csv";
while (<FH>) {
    $lines++;
    if ($lines == 1 ) {
	my $row=$_;
	@names = split(/,/, $row);
	print;
    }
    else {
	if (/^(\S+?),(\S+)$/) {
	    my $sp=$1;
	    my $data=$2;
	    my @array = split(/,/, $data);
	    my $namespos=0;
	    $specieshash{$sp}=0;
	    for my $num(@array) {
		if ($num >= $OTU) {		    
		    if ($names[$namespos] ne $sp) {
		    print OUT "$sp\t$names[$namespos]\n";
		    print "$sp\t$names[$namespos]\n";
		    $specieshash{$sp}++;
		    }
		}
		$namespos++;
	    }
	    $count++;
	}
    }
}

open OUTx, ">Species.Number.90.txt";
for my $tax (@names) {
    print OUTx "$tax\t$specieshash{$tax}\n";
}
	


print "The number of species is $count $lines\n";

close OUT;
close FH;
