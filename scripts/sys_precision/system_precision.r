library(car)
library(gplots)

db<-read.table('system_precision_baseline.txt', sep=' ', header=T)
dv<-read.table('system_precision_vistop.txt', sep=' ', header=T)
dall <- rbind(db, dv)

dclean <- subset(dall, dall$userno != '1' & dall$userno != '2' & dall$userno != '29')


cat("== ANOVA ============================================================\n")

d <- dclean
db <- subset(d, sys == 'vsb')
de <- subset(d, sys == 'vse')
dn <- subset(d, sys == 'vsn')

levene.test(top10~sys, data=d)
shapiro.test(db$top10)
shapiro.test(de$top10)
shapiro.test(dn$top10)

interaction.plot(d$topicid, d$sys, d$top10, type="b", col=c(1:3), leg.bty="o", leg.bg="beige", lwd=2, pch=c(18,24,22), xlab='Topicid', ylab='Precision@10', main='System Precision')
readline()
plotmeans(d$top10~d$sys, xlab='System', ylab='Precision@10', label='System Precision')
readline()

fit <- aov(top10~sys, d)
print(summary(fit))
print(TukeyHSD(fit))

wilcox.test(db$top10, de$top10)
wilcox.test(db$top10, dn$top10)


cat("== ANOVA (in um) ====================================================\n")

dinum <- subset(dclean, dclean$inum == 1)
db <- subset(dinum, sys == 'vsb')
de <- subset(dinum, sys == 'vse')
dn <- subset(dinum, sys == 'vsn')

levene.test(top10~sys, data=dinum)
shapiro.test(db$top10)
shapiro.test(de$top10)
shapiro.test(dn$top10)

interaction.plot(dinum$topicid, dinum$sys, dinum$top10, type="b", col=c(1:3), leg.bty="o", leg.bg="beige", lwd=2, pch=c(18,24,22), xlab='Topicid', ylab='Precision@10', main='System Precision')
readline()
plotmeans(dinum$top10~dinum$sys, xlab='System', ylab='Precision@10', label='System Precision')
readline()

fit <- aov(top10~sys, dinum)
print(summary(fit))
print(TukeyHSD(fit))

wilcox.test(db$top10, de$top10)
wilcox.test(db$top10, dn$top10)


# db <- subset(dbclean, dbclean$topicid == '40009')
# de <- subset(dvclean, dvclean$sys == 'vse' & dvclean$topicid == '40009')
# dn <- subset(dvclean, dvclean$sys == 'vsn' & dvclean$topicid == '40009')
# 
# print(wilcox.test(db$top10, de$prec))



# dbs <- subset(dbclean, dbclean$topicid == '40009')
# des <- subset(dvclean, dvclean$sys == 'vse' & dvclean$topicid == '40009')
# dns <- subset(dvclean, dvclean$sys == 'vsn' & dvclean$topicid == '40009')


# cat("=================== 40009 ===============\n")
# 
# des <- subset(dvclean, dvclean$V3 == '40009' & dvclean$V1 == 'vse')
# dns <- subset(dvclean, dvclean$V3 == '40009' & dvclean$V1 == 'vsn')
# dbs <- subset(dbclean, dbclean$V2 == '40009')
# 
# print(mean(dbs$V3))
# print(mean(dbs$V4))
# print(mean(des$V4))
# print(mean(dns$V4))
# 
# res <- wilcox.test(dbs$V3, des$V4, alternative='less'); print(res)
# res <- wilcox.test(dbs$V4, des$V4, alternative='less'); print(res)
# 
# res <- wilcox.test(dbs$V3, dns$V4, alternative='less'); print(res)
# res <- wilcox.test(dbs$V4, dns$V4, alternative='less'); print(res)

# cat("=================== 40048 ===============\n")
# 
# des <- subset(dvclean, dvclean$V3 == '40048' & dvclean$V1 == 'vse')
# dns <- subset(dvclean, dvclean$V3 == '40048' & dvclean$V1 == 'vsn')
# dbs <- subset(dbclean, dbclean$V2 == '40048')
# 
# print(mean(dbs$V3))
# print(mean(dbs$V4))
# print(mean(des$V4))
# print(mean(dns$V4))
# 
# res <- wilcox.test(dbs$V3, des$V4, alternative='less'); print(res)
# res <- wilcox.test(dbs$V4, des$V4, alternative='less'); print(res)
# 
# res <- wilcox.test(dbs$V3, dns$V4, alternative='less'); print(res)
# res <- wilcox.test(dbs$V4, dns$V4, alternative='less'); print(res)
# 
# cat("=================== 40021 ===============\n")
# 
# des <- subset(dvclean, dvclean$V3 == '40021' & dvclean$V1 == 'vse')
# dns <- subset(dvclean, dvclean$V3 == '40021' & dvclean$V1 == 'vsn')
# dbs <- subset(dbclean, dbclean$V2 == '40021')
# 
# print(mean(dbs$V3))
# print(mean(dbs$V4))
# print(mean(des$V4))
# print(mean(dns$V4))
# 
# res <- wilcox.test(dbs$V3, des$V4, alternative='less'); print(res)
# res <- wilcox.test(dbs$V4, des$V4, alternative='less'); print(res)
# 
# res <- wilcox.test(dbs$V3, dns$V4, alternative='less'); print(res)
# res <- wilcox.test(dbs$V4, dns$V4, alternative='less'); print(res)