## This script will  calculate uncorrected p-distances from a 
##  phylip file of n sequences


#!usr/bin/perl


system "ls -l *listofgenes.phy >filenames";
open OUT, ">P-Distance.Calculations.txt";
open FHf, "<filenames";
while (<FHf>)
{
    @namearray=();
    %length=();
    @seqarray=();
    @bigarray=();
    if (/(\S+).phy/)
    {
      $file=$1;
	    open FH, "<$file.phy";
      $row=0;
      while (<FH>)
	    {
	      if (/(\S+)\s+(\S+)/ && ! /\d+/)
	      {
		      $tax=$1;
		      $seq=$2;
		      push @namearray, $tax;
		      $size=length($seq);
      		$length{$name}=$size;
		      push @seqarray, $seq;
		      @new= split(//, $seq);
		      for $nuc (@new)
		      {
		          push @{$bigarray[$row]}, $nuc;
		      }
	      }
	      $row++;
	    }
        ## calculate the number of pairwise comparisons the formula is ((N-1)N)/2
	    $numseq=scalar @bigarray;
	    $numcomp = (($numseq-1)*$numseq)/2;
    	$site=0;
	    $sequence1=0;
	    $sequence2=1;
	    for (1..$numcomp)
    	{
	      $sequence = $seqarray[$sequence1];
	      $size = length$sequence;
  	    $numdiff=0;
	      for (0..$size-1)
	      {
		      $nuc1 = $bigarray[$sequence1][$site];
		      $nuc2 = $bigarray[$sequence2][$site];
		      if ($nuc1 ne  $nuc2)
		      {
		          $numdiff++;
	      	}
	      	$site++;
	      }
	      $distance=$numdiff/$size;
	      print OUT "$namearray[$sequence1]\t$namearray[$sequence2]\t$size\t$numdiff\t$distance\n";
	      $sequence1++;
	      $sequence2++;
	    }    
    }
}

