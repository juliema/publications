#!usr/bin/perl

use strict;
use warnings;

my $burnin=shift;  ## generation number not total number of samples to remove
my $treefile=shift;
my $outfile=shift;



my $countree=0;
my $postnumber=0;

open FH, "<$treefile";
open OUT, ">$outfile";
while (<FH>) { 
    if (/^tree\s+STATE_(\d+)/) {
	my $gen=$1;
	$countree++;
	if ($gen > $burnin) {
	    print OUT;
	    $postnumber++;
	}
    }
    else {
	print OUT;
    }
}

print "There were $countree trees in the file and we kept $postnumber\n";

