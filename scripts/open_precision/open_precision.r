d <- read.table("open_precision2.txt")

# filter out:
# open and do nothing ($V6, mistake)
# user model is built ($V9)
# evident outlier & error subject (1 and 2)
ds <- subset(d, d$V6 > 0 & d$V9 == 1 & d$V2 != 1 & d$V2 != 2)

res <- aggregate(ds$V5, mean, by=list(ds$V1))
print(res)

res <- aggregate(ds$V5, mean, by=list(ds$V1, ds$V3))
print(res)

dsb <- subset(ds, ds$V3 == 40021 & ds$V1 == 'vsb')
dse <- subset(ds, ds$V3 == 40021 & ds$V1 == 'vse')
dsn <- subset(ds, ds$V3 == 40021 & ds$V1 == 'vsn')

# dsb <- subset(ds, ds$V1 == 'vsb')
# dse <- subset(ds, ds$V1 == 'vse')
# dsn <- subset(ds, ds$V1 == 'vsn')


res <- t.test(dsb$V5, dse$V5)
print(res)

res <- t.test(dsb$V5, dsn$V5)
print(res)

res <- wilcox.test(dsb$V5, dse$V5)
print(res)

res <- wilcox.test(dsb$V5, dsn$V5)
print(res)

cat("------ one-sided -------")

res <- t.test(dsb$V5, dse$V5, alternative='less')
print(res)

res <- t.test(dsb$V5, dsn$V5, alternative='less')
print(res)

res <- wilcox.test(dsb$V5, dse$V5, alternative='less')
print(res)

res <- wilcox.test(dsb$V5, dsn$V5, alternative='less')
print(res)