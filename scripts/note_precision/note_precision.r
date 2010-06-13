d<-read.table('../../data/user_notes_annotated.txt', header=T)

dclean <- subset(d, d$userno != '01' & d$userno != '02' & d$userno != '29' & d$userno != '10')
d09 <- subset(dclean, dclean$topicid == '40009')
d48 <- subset(dclean, dclean$topicid == '40048')
d21 <- subset(dclean, dclean$topicid == '40021')

cat("*** 40009 ***\n")

res <- aggregate(d09$prec, mean, by=list(d09$sys))
print(res)

d09b <- subset(d09, d09$sys == 'vsb')
d09e <- subset(d09, d09$sys == 'vse')
d09n <- subset(d09, d09$sys == 'vsn')

res <- wilcox.test(d09b$prec, d09e$prec); print(res)
res <- wilcox.test(d09b$prec, d09e$prec, alternative='less'); print(res)

res <- wilcox.test(d09b$prec, d09n$prec); print(res)
res <- wilcox.test(d09b$prec, d09n$prec, alternative='less'); print(res)


cat("*** 40048 ***\n")

res <- aggregate(d48$prec, mean, by=list(d48$sys))
print(res)

d48b <- subset(d48, d48$sys == 'vsb')
d48e <- subset(d48, d48$sys == 'vse')
d48n <- subset(d48, d48$sys == 'vsn')

res <- wilcox.test(d48b$prec, d48e$prec); print(res)
res <- wilcox.test(d48b$prec, d48e$prec, alternative='less'); print(res)

res <- wilcox.test(d48b$prec, d48n$prec); print(res)
res <- wilcox.test(d48b$prec, d48n$prec, alternative='less'); print(res)


cat("*** 40021 ***\n")

res <- aggregate(d21$prec, mean, by=list(d21$sys))
print(res)

d21b <- subset(d21, d21$sys == 'vsb')
d21e <- subset(d21, d21$sys == 'vse')
d21n <- subset(d21, d21$sys == 'vsn')

res <- wilcox.test(d21b$prec, d21e$prec); print(res)
res <- wilcox.test(d21b$prec, d21e$prec, alternative='less'); print(res)

res <- wilcox.test(d21b$prec, d21n$prec); print(res)
res <- wilcox.test(d21b$prec, d21n$prec, alternative='less'); print(res)

