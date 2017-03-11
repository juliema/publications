Please Cite: 
Bush, S. E., Weckstein, J. D., Gustafsson, D. R., Allen, J., DiBlasi, E., Shreve, S. M., ... Johnson, K. P. (2016). Unlocking the black box of feather louse diversity: A molecular phylogeny of the hyper-diverse genus Brueelia. Molecular Phylogenetics and Evolution, 94, 737-751. DOI: 10.1016/j.ympev.2015.09.015


1.  get post burnin trees from BEAST run removeburnin.pl
2.  randomly select 100  getrandomtrees.pl
3.  run bGMYC on a single tree then mulit-trees bGMYC.R - make sure all 100 random trees work
4.  get OTUs from the output.
5.  Maddison and Slatkin test 
          select 100 OTU trees from the Mr. Bayes run
                remove burnin in Mr. Bayes - select 100 post burnin trees
          run MS Test with those trees in R.
