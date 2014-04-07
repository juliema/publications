library(ape)
library(geiger)
library(phangorn)
library(phylobase)


#######################################################################
## This creates a function to do randomizations of a character on a tree  and calculate a p value
## This code is modified from  https://stat.ethz.ch/pipermail/r-sig-phylo/2011-March/001037.html 
#######################################################################



'phylo.signal.disc' <-
function(trait,phy,rep = 999,cost=NULL)
{
lev <- attributes(factor(trait))$levels
    if (length(lev) == length(trait))
        stop("Are you sure this variable is categorical?")
    if(is.null(cost)){
        cost1 <- 1-diag(length(lev))
                            }
    else {
    if (length(lev) != dim(cost)[1])
        stop("Dimensions of the character state transition matrix do not agree with the number of levels")
         cost1<- t(cost)
        }
dimnames(cost1) <- list(lev,lev)
trait <- as.numeric(trait)
attributes(trait)$names <- phy$tip
NULL.MODEL <- matrix(NA,rep,1)
obs <- t(data.frame(trait))
obs <- phyDat(t(obs),type="USER",levels=attributes(factor(obs))$levels)
OBS <- parsimony(phy,obs,method="sankoff",cost=cost1)
for (i in 1:rep){
    null <- sample(as.numeric(trait))
    attributes(null)$names <- attributes(trait)$names
    null <- t(data.frame(null))
    null <- phyDat(t(null),type="USER",levels=attributes(factor(null))$levels)
    NULL.MODEL[i,]<-parsimony(phy,null,method="sankoff",cost=cost1)
    P.value <- sum(OBS >= NULL.MODEL)/(rep + 1)
    }
par(mfrow=c(1,2))
hist(NULL.MODEL,xlab="Transitions.in.Randomizations",xlim=c(min(c(min(NULL.MODEL,OBS-1))),max(NULL.MODEL)+1))
arrows(OBS,rep/10,OBS,0,angle=20,col="red",lwd=4)
phy$tip.label <- rep(".",length(trait))
plot(phy,tip.col=trait+10,cex=250/length(trait),font=1)
title("Character states")
par(mfrow=c(1,1))

OUTPUT1 <- t(data.frame(Number.of.Levels = length(attributes(factor(trait))$levels), Evolutionary.Transitions.Observed=OBS,Evolutionary.Transitions.Randomization.Median=median(NULL.MODEL),Evolutionary.Transitions.Randomization.Min=min(NULL.MODEL),Evolutionary.Transitions.Randomization.Max=max(NULL.MODEL),P.value))

    if(is.null(cost)){
        list(.Randomization.Results=OUTPUT1,.Levels= lev,.Costs.of.character.state.transition.UNORDERED.PARSIMONY = t(cost1))
                            }
    else {
        list(.Randomization.Results=OUTPUT1,.Levels= lev,.Costs.of.character.state.transition.FROM.ROW.TO.COL = t(cost1))        }
}




tree <-read.nexus(file="BrueeliaCOI.EF1.10.3.2013BINoPart.nex.con.tre")
List.dat <-(read.csv(file="100_fam.csv", header=TRUE))
tmpTr <- drop.tip(tree, tree$tip.label[! tree$tip.label %in% List.dat[, 1]])
tr4 <- phylo4d(tmpTr, List.dat, label.type="column")
pruned <- as(extractTree(tr4), "phylo")
ldata <- tdata(tr4, "tip")
ldata <- ldata[pruned$tip.label, 1]
names(ldata) <- pruned$tip.label
phylo.signal.disc(ldata, pruned) ->result
write(result$.Randomization.Results, file="100_fam.MS.out")


