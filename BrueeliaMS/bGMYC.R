setwd("/Users/juliema/Documents/BEAST/bGMYC")

library(bGMYC)

phy <-read.nexus(file="BEAST.Random.100.ed.tre")

## Read in 100 random trees from BEAST
phy <-read.nexus(file="BEAST.Random.tested.3.28.14.tre")

## Root the Trees
trees.root = NULL
for (i in 1:length(phy)) {
		trees.root[[i]] =  root(phy[[i]], c("Ausub.1.27.1999.12","Dgcar.9.8.1999.7"))
}

## Remove the outgroups
trees.noout = NULL
for (i in 1:length(trees.root)) {
		trees.noout[[i]] =  drop.tip(trees.root[[i]], c("Pasp.Arast.2.10.1999.7", "Pclau.11.22.2001.13","Tssp.Psbre.10.16.2002.6","Ffpal.11.22.2001.14","Qkeos.5.16.2002.5","Nylon.2.6.1999.6","Racol.1.27.1999.2","Raful.2.6.1999.11","Alsp.Hamal.1.16.2001.11","Veber.10.17.2000.7","Qupun.2.3.1999.2","Salar.4.7.1999.12","Afdup.3.16.2001.10","Oscur.10.5.1999.2","Wiabs.10.5.1999.1","Cabid.6.29.1998.2","Phcub.9.29.1998.7","Gosp.Phcol.11.10.2001.2","Sgorb.11.10.2001.10","Brsp.Psmin.2.1.2000.9","Pezum.1.12.1999.10","Ppsp.Sppus.11.10.2001.11","Ausub.1.27.1999.12","Dgcar.9.8.1999.7","Embra.2.4.2002.11","Chsp.Orcan.11.10.2001.9","Oxchi.1.27.1999.6","Nseos.11.22.2001.15","Foana.1.27.1999.7","Fosp.Thdol.4.7.1999.10"))
}

### Run bgmyc
bgmyc.multiphylo(trees.noout, mcmc=20000, burnin=10000, thinning=10, t1=2, t2=300)->result.multi
plot(result.multi)
bgmyc.spec(result.multi)->result.spec
spec.probmat(result.multi)->result.probmat 
plot(result.probmat,trees.noout[[1]])
