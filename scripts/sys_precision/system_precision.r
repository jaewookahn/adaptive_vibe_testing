library(car)
library(gplots)

db<-read.table('../../data/system_precision_baseline.txt', sep=' ', header=T)
dv<-read.table('../../data/system_precision_vistop.txt', sep=' ', header=T)
dall <- rbind(db, dv)

dclean <- subset(dall, dall$userno != 1 & dall$userno != 2 & dall$userno != 29)
# dclean <- subset(dall, dall$userno != 1 & dall$userno != 2 & dall$userno < 28 & dall$userno != 10)
# dclean <- subset(dall, dall$userno < 28 & dall$userno > 2)

#######################################
# OVERALL
#######################################

cat("== ANOVA ============================================================\n")

d <- dclean
db <- subset(d, sys == 'vsb')
de <- subset(d, sys == 'vse')
dn <- subset(d, sys == 'vsn')

levene.test(top10~sys, data=d)
shapiro.test(db$top10)
shapiro.test(de$top10)
shapiro.test(dn$top10)

interaction.plot(d$topicid, d$sys, d$top10, type="b", col=c(1:3), leg.bty="o", leg.bg="beige", lwd=2, pch=c(18,24,22), xlab='Topicid', ylab='Precision@10', main='System Precision', trace.label='System')
readline()
plotmeans(d$top10~d$sys, xlab='System', ylab='Precision@10', label='System Precision')
readline()

fit <- aov(top10~sys, d)
print(summary(fit))
print(TukeyHSD(fit))

cat("== Non-parametric ===================================================\n")

res <- kruskal.test(top10~sys, data=d); print(res)
res <- pairwise.wilcox.test(d$top10, d$sys); print(res)

# cat("== two-side =========================================================\n")
# 
res <- wilcox.test(db$top10, de$top10); print(res)
res <- wilcox.test(db$top10, dn$top10); print(res)
# 
# cat("== one-side =========================================================\n")
# 
# res <- wilcox.test(db$top10, de$top10, alternative='less'); print(res)
# res <- wilcox.test(db$top10, dn$top10, alternative='less'); print(res)
# 
# cat("== by topic =========================================================\n")
# 
# db09 <- subset(db, db$topicid == '40009')
# db48 <- subset(db, db$topicid == '40048')
# db21 <- subset(db, db$topicid == '40021')
# de09 <- subset(de, de$topicid == '40009')
# de48 <- subset(de, de$topicid == '40048')
# de21 <- subset(de, de$topicid == '40021')
# dn09 <- subset(dn, dn$topicid == '40009')
# dn48 <- subset(dn, dn$topicid == '40048')
# dn21 <- subset(dn, dn$topicid == '40021')
# 
# res <- wilcox.test(db09$top10, de09$top10, alternative='less'); print(res)
# res <- wilcox.test(db09$top10, dn09$top10, alternative='less'); print(res)
# res <- wilcox.test(db48$top10, de48$top10, alternative='less'); print(res)
# res <- wilcox.test(db48$top10, dn48$top10, alternative='less'); print(res)
# res <- wilcox.test(db21$top10, de21$top10, alternative='less'); print(res)
# res <- wilcox.test(db21$top10, dn21$top10, alternative='less'); print(res)

#######################################
# In UM
#######################################

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

cat("== Non-parametric (in um) ===========================================\n")

res <- kruskal.test(dinum$top10, dinum$sys); print(res)
res <- pairwise.wilcox.test(dinum$top10, dinum$sys); print(res)

# cat("== two-side =========================================================\n")
# 
# res <- wilcox.test(db$top10, de$top10); print(res)
# res <- wilcox.test(db$top10, dn$top10); print(res)
# 
# cat("== one-side =========================================================\n")
# 
# res <- wilcox.test(db$top10, de$top10, alternative='less'); print(res)
# res <- wilcox.test(db$top10, dn$top10, alternative='less'); print(res)
# 
# cat("== by topic =========================================================\n")
# 
# db09 <- subset(db, db$topicid == '40009')
# db48 <- subset(db, db$topicid == '40048')
# db21 <- subset(db, db$topicid == '40021')
# de09 <- subset(de, de$topicid == '40009')
# de48 <- subset(de, de$topicid == '40048')
# de21 <- subset(de, de$topicid == '40021')
# dn09 <- subset(dn, dn$topicid == '40009')
# dn48 <- subset(dn, dn$topicid == '40048')
# dn21 <- subset(dn, dn$topicid == '40021')
# 
# res <- wilcox.test(db09$top10, de09$top10, alternative='less'); print(res)
# res <- wilcox.test(db09$top10, dn09$top10, alternative='less'); print(res)
# res <- wilcox.test(db48$top10, de48$top10, alternative='less'); print(res)
# res <- wilcox.test(db48$top10, dn48$top10, alternative='less'); print(res)
# res <- wilcox.test(db21$top10, de21$top10, alternative='less'); print(res)
# res <- wilcox.test(db21$top10, dn21$top10, alternative='less'); print(res)
