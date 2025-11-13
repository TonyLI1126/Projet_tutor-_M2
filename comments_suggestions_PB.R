library(ape)
library(phylolm)

## Simulate data (non phylogenetic)
n <- 20
x <- runif(n, -2, 2)
eps <- rnorm(n, 0, 1)
Y <- 1.2 + 0.3 * x + eps

## classical lm fit
summary(lm(Y ~ x))

## Say I have a tree
tree <- rphylo(n, 0.1, 0.01)
plot(tree)

## phylogenetic fit
names(Y) <- names(x) <- tree$tip.label
fit_phylo <- phylolm(Y ~ x, phy = tree)
summary(fit_phylo)
confint(fit_phylo)
## remark : phylolm fits poorly compared to lm, this is not surprising, as the data was simulated without the tree.
## Question : what happens if I simulate using the tree ?

## Question : implement formulas naively
X <- ...
C <- vcv(tree)
hat_beta <- ... # formula
hat_sigma2 <- ...
# how to find confidence intervals ?
# Question : which way is fastest ?
library(microbenchmark)
?microbenchmark
microbenchmark(lm(Y ~ x), phylolm(Y ~ x, phy = tree))


## Simulate with the tree ?
?phylolm
?rTrait
## Question : how do we simulate data with a BM on a given tree ?


## Roadmap
# 1. Check that your formulas are correct
# 2. How to compute confidence intervals on beta / sigma2 in phylolm ?
# 3. How to simulate data with a BM on a tree ?
# 4. Simulation study :
#    a- Simulate 100 datasets without tree or with the tree
#    b- fit each dataset with lm or phylolm
#    c- compare which estimator is best ? 
#        - compare the mean of the estimators 
#        - check the "empirical coverage" of the confidence interval

