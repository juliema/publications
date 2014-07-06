#!usr/bin/perl

use strict;
use warnings;

my @array=();
open OUT, ">BEAST.Random.300.tre";

open FH, "<BrueeliaCOI.10.3.2013MB.YBD.NOBURNIN.trees";
while (<FH>) {
    if (/^tree\s+STATE_(\d+)\s/) {
	my $gen=$1;
	push @array, $gen;
#	print "$gen\n";
    }
}


my %randomhash=();
for (1..300) {
    my $array_size = @array;
    my $index = int(rand($array_size));
    my $gen=$array[$index];
    $randomhash{$gen}=1;
#    push @randomarray, $gen;
    splice @array, $index, 1;
    print "$gen\n";
}


my $countree=0;
open FHx, "<BrueeliaCOI.10.3.2013MB.YBD.NOBURNIN.trees";
while (<FHx>) {
    if (/^tree\s+STATE_(\d+)/) {
	my $gen=$1;
	if (exists $randomhash{$gen}) {
	    print OUT;
	    $countree++;
	}
    }
    else {
	print OUT;
    }
}

print "there are $countree in the random file\n";
