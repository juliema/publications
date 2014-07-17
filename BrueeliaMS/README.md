Unpublished Manuscript


1.  get post burnin trees from BEAST run removeburnin.pl
2.  randomly select 100  getrandomtrees.pl
3.  run bGMYC on a single tree then mulit-trees bGMYC.R - make sure all 100 random trees work
4.  get OTUs from the output.
5.  Maddison and Slatkin test 
          select 100 OTU trees from the Mr. Bayes run
                remove burnin in Mr. Bayes - select 100 post burnin trees
          run MS Test with those trees in R.
