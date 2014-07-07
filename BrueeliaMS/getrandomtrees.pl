#!usr/bin/perl

use strict;
use warnings;

my $random = shift;
# the number of trees you want randomly selected.
my $inputfile = shift;
#  THIS IS YOUR INPUT TREE FILE WIHTOUT THE BURNIN
my $outputfile = shift;
## name a new file called FILESOMETHING.random.tre 

my @array=();
open OUT, ">$outputfile";
open FH, "<$inputfile";
while (<FH>) {
    if (/^tree\s+STATE_(\d+)\s/) {
	my $gen=$1;
	push @array, $gen;
    }
}


my %randomhash=();
for (1..$random) {
    my $array_size = @array;
    my $index = int(rand($array_size));
    my $gen=$array[$index];
    $randomhash{$gen}=1;
#    push @randomarray, $gen;
    splice(@array, $index, 1);
    print "$gen\n";
}


my $countree=0;
open FHx, "<$inputfile";
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
