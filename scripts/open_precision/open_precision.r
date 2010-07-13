library(exactRankTests)

d <- read.table("../../data/open_precision2-2.txt")

# filter out:
# open and do nothing ($V6, mistake)
# user model is built ($V9)
# evident outlier & error subject (1 and 2)
ds <- subset(d, V6 > 0 & V9 == 1 & V2 > 2 & V2 != 29 & V2 != 10)

##
## repeated

cat("## Repeated comparisions ############################################\n")

dsb <- subset(ds, V1 == 'vsb')
dse <- subset(ds, V1 == 'vse')
dsn <- subset(ds, V1 == 'vsn')

dsbp <- aggregate(dsb$V5, mean, by=list(dsb$V2)); colnames(dsbp) <- c('userno', 'pb')
dsep <- aggregate(dse$V5, mean, by=list(dse$V2)); colnames(dsep) <- c('userno', 'pe')
dsnp <- aggregate(dsn$V5, mean, by=list(dsn$V2)); colnames(dsnp) <- c('userno', 'pn')

dspall <- sqldf('select b.userno, pb, pe, pn from dsbp b, dsep e, dsnp n where b.userno = e.userno and e.userno = n.userno')

res <- mean(dspall); print(res)

res <- wilcox.exact(dspall$pb, dspall$pe, paired=T); print(res)
res <- wilcox.exact(dspall$pb, dspall$pn, paired=T); print(res)

res <- wilcox.exact(dspall$pb, dspall$pe, paired=T, alternative='greater'); print(res)
res <- wilcox.exact(dspall$pb, dspall$pn, paired=T, alternative='greater'); print(res)


dsbc <- aggregate(dsb$V5, sum, by=list(dsb$V2)); colnames(dsbc) <- c('userno', 'cb')
dsec <- aggregate(dse$V5, sum, by=list(dse$V2)); colnames(dsec) <- c('userno', 'ce')
dsnc <- aggregate(dsn$V5, sum, by=list(dsn$V2)); colnames(dsnc) <- c('userno', 'cn')

dscall <- sqldf('select b.userno, cb, ce, cn from dsbc b, dsec e, dsnc n where b.userno = e.userno and e.userno = n.userno')

res <- wilcox.exact(dscall$cb, dscall$ce, paired=T, alternative='less'); print(res)
res <- wilcox.exact(dscall$cb, dscall$cn, paired=T, alternative='less'); print(res)

readline()
cat("## Non-repeated comparisions ########################################\n")

###
### non-repeated

# res <- aggregate(ds$V5, mean, by=list(ds$V1))
# print(res)
# 
# res <- aggregate(ds$V5, mean, by=list(ds$V1, ds$V3))
# print(res)
# 
# dsb <- subset(ds, ds$V3 == 40021 & ds$V1 == 'vsb')
# dse <- subset(ds, ds$V3 == 40021 & ds$V1 == 'vse')
# dsn <- subset(ds, ds$V3 == 40021 & ds$V1 == 'vsn')
# 
# # dsb <- subset(ds, ds$V1 == 'vsb')
# # dse <- subset(ds, ds$V1 == 'vse')
# # dsn <- subset(ds, ds$V1 == 'vsn')
# 
# 
# res <- t.test(dsb$V5, dse$V5)
# print(res)
# 
# res <- t.test(dsb$V5, dsn$V5)
# print(res)
# 
# res <- wilcox.test(dsb$V5, dse$V5)
# print(res)
# 
# res <- wilcox.test(dsb$V5, dsn$V5)
# print(res)
# 
# cat("------ one-sided -------")
# 
# res <- t.test(dsb$V5, dse$V5, alternative='less')
# print(res)
# 
# res <- t.test(dsb$V5, dsn$V5, alternative='less')
# print(res)
# 
# res <- wilcox.test(dsb$V5, dse$V5, alternative='less')
# print(res)
# 
# res <- wilcox.test(dsb$V5, dsn$V5, alternative='less')
# print(res)



res <- aggregate(ds$V5, mean, by=list(ds$V1, ds$V3)); print(res)

dsb <- subset(ds, ds$V3 == 40009 & ds$V1 == 'vsb')
dse <- subset(ds, ds$V3 == 40009 & ds$V1 == 'vse')
dsn <- subset(ds, ds$V3 == 40009 & ds$V1 == 'vsn')

cat("## rel doc discovery ################################################\n")

ddb <- sqldf("select userno, count(*) bcount from (select distinct V2 userno, V4 docno from ds where V1 = 'vsb' and V5 = 1) x group by userno")
dde <- sqldf("select userno, count(*) ecount from (select distinct V2 userno, V4 docno from ds where V1 = 'vse' and V5 = 1) x group by userno")
ddn <- sqldf("select userno, count(*) ncount from (select distinct V2 userno, V4 docno from ds where V1 = 'vsn' and V5 = 1) x group by userno")



####




