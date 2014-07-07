#!usr/bin/perl

use strict;
use warnings;

my $burnin=shift;
my $treefile=shift;
my $outfile=shift;

[my $burnin = 20000000;]

my $countree=0;
[open OUT, ">BrueeliaCOI.10.3.2013MB.YBD.NOBURNIN.trees";]
[open FH, "<BrueeliaCOI.10.3.2013MB.YBD.trees";]

open FH, "<$treefile";
open OUt, ">$outfile";
while (<FH>) { 
    if (/^tree\s+STATE_(\d+)/) {
	my $gen=$1;
	if ($gen > $burnin) {
	    print OUT;
	    $countree++;
	}
    }
    else {
	print OUT;
    }
}

print "There were $countree trees in the file\n";
	
