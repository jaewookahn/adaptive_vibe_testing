library(gplots)

d<-read.table('../../data/open_depth.txt')
dd<-subset(d, d$V6 != -1)

#

do <- subset(dd, dd$V2 == 'open_doc')

res <- aggregate(do$V6, mean, by=list(do$V1)); print(res)
dor<-subset(do, do$V5 == 1)
res <- aggregate(dor$V6, mean, by=list(dor$V1)); print(res)
plotmeans(dor$V6~dor$V1)
realine()

#

ds <- subset(dd, dd$V2 == 'save_note')

res <- aggregate(ds$V6, mean, by=list(ds$V1)); print(res)
dsr<-subset(ds, ds$V5 == 1)
res <- aggregate(dsr$V6, mean, by=list(dsr$V1)); print(res)
plotmeans(dsr$V6~dsr$V1)
readline()