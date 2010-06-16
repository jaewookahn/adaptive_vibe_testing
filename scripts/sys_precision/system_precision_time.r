library(car)
library(gplots)

ds <- read.table("../../data/system_precision_vistop_with_time.txt", header=T)
d <- subset(ds, ds$userno != 1 & ds$userno != 2 & ds$userno != 29)


d <- subset(d, d$inum == 1)


# d1 <- subset(d, d$time < 300)
# d2 <- subset(d, d$time >= 300 & d$time < 600)
# d3 <- subset(d, d$time >= 600 & d$time < 900)
# d4 <- subset(d, d$time >= 900)
# 
# 
# res <- mean(d1$ratiox); print(res)
# res <- mean(d2$ratiox); print(res)
# res <- mean(d3$ratiox); print(res)
# res <- mean(d4$ratiox); print(res)
# 
# 
# 
# res <- aggregate(d1$ratiox, mean, by=list(d1$topicid)); print(res)
# res <- aggregate(d2$ratiox, mean, by=list(d2$topicid)); print(res)
# res <- aggregate(d3$ratiox, mean, by=list(d3$topicid)); print(res)
# res <- aggregate(d4$ratiox, mean, by=list(d4$topicid)); print(res)
# 
# 
# res <- aggregate(d1$ratiox, mean, by=list(d1$sys)); print(res)
# res <- aggregate(d2$ratiox, mean, by=list(d2$sys)); print(res)
# res <- aggregate(d3$ratiox, mean, by=list(d3$sys)); print(res)
# res <- aggregate(d4$ratiox, mean, by=list(d4$sys)); print(res)

dbin <- cbind(d, timeslot=paste("T", pmin(floor(d$time / 300) + 1, 4), sep=''))

cat("*** Overall\n")
res <- aggregate(dbin$ratiox, mean, by=list(dbin$timeslot)); print(res)

cat("*** By topic\n")
res <- aggregate(dbin$ratiox, mean, by=list(dbin$timeslot, dbin$topicid)); print(res)

cat("*** By system\n")
res <- aggregate(dbin$ratiox, mean, by=list(dbin$timeslot, dbin$sys)); print(res)

cat("*** ANOVA\n")
fit <- aov(ratiox~timeslot, dbin)
res <- summary(fit); print(res)
res <- TukeyHSD(fit); print(res)

levene.test(ratiox~timeslot, data=dbin)
shapiro.test(dbin$ratiox)

interaction.plot(dbin$timeslot, dbin$sys, dbin$ratiox, type="b", col=c(1:3), leg.bty="o", leg.bg="beige", lwd=2, pch=c(18,24,22), xlab='Time', ylab='Relative Location', main='System Precision')
readline()
interaction.plot(dbin$timeslot, dbin$topicid, dbin$ratiox, type="b", col=c(1:3), leg.bty="o", leg.bg="beige", lwd=2, pch=c(18,24,22), xlab='Time', ylab='Relative Location', main='System Precision')
readline()
plotmeans(dbin$ratiox~dbin$timeslot, xlab='System', ylab='Precision@10', label='System Precision')
