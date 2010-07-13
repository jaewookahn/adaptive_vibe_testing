library(reshape)
library(sqldf)

d <- read.table('../../data/note_precision_noerr.txt', header=T)
n <- subset(d, userno > 2 & userno != 29 & userno != 10)
# n <- subset(n, sysorder == 3)

res <- aggregate(n$p, mean, by=list(n$sys)); print(res)

user_notep <- function(data, sysstr) {
	res <- subset(data, data$sys == sysstr)
	res <- aggregate(res$p, mean, by=list(res$userno));
	res <- rename(res, c(Group.1="userno", x="p"));
	return(res);
}

user_notel <- function(data, sysstr) {
	res <- subset(data, data$sys == sysstr & data$p == 1)
	res <- aggregate(res$p, length, by=list(res$userno));
	res <- rename(res, c(Group.1="userno", x="p"));
	return(res);
}

##
## repeated

cat("############### Repeated ##############\n")

nb <- user_notep(n, 'vsb')
ne <- user_notep(n, 'vse')
nn <- user_notep(n, 'vsn')

nlb <- user_notel(n, 'vsb')
nle <- user_notel(n, 'vse')
nln <- user_notel(n, 'vsn')

cat("#### Comparison of precision\n")

nm <- sqldf('select nb.userno,nb.p as NB, ne.p as NE, nn.p as NN from nb,ne,nn where nb.userno = ne.userno and ne.userno=nn.userno')

res <- wilcox.exact(nm$NB, nm$NE, paired=T, alternative='less'); print(res)
res <- wilcox.exact(nm$NB, nm$NN, paired=T, alternative='less'); print(res)

cat("#### Comparison of count\n")

nlm <- sqldf('select nb.userno,nb.p as NB, ne.p as NE, nn.p as NN from nlb nb,nle ne,nln nn where nb.userno = ne.userno and ne.userno=nn.userno')

res <- wilcox.exact(nlm$NB, nlm$NE, paired=T, alternative='less'); print(res)
res <- wilcox.exact(nlm$NB, nlm$NN, paired=T, alternative='less'); print(res)

readline("End of Repeated Analysis")

cat("############### Non-repeated ##############\n")

##
## non-repeated

res <- kruskal.test(p~sys, n); print(res)
res <- pairwise.wilcox.test(n$p, n$sys); print(res)

# by topic
res <- aggregate(n$p, mean, by=list(n$sys,n$topicid)); print(res)

n09<-subset(n, topicid==40009)
n21<-subset(n, topicid==40021)
n48<-subset(n, topicid==40048)


cat("########################## TOPIC 40009 ###\n")
res <- kruskal.test(p~sys, n09); print(res)
res <- pairwise.wilcox.test(n09$p, n09$sys); print(res)

cat("########################## TOPIC 40048 ###\n")
res <- kruskal.test(p~sys, n48); print(res)
res <- pairwise.wilcox.test(n48$p, n48$sys); print(res)

cat("########################## TOPIC 40021 ###\n")
res <- kruskal.test(p~sys, n21); print(res)
res <- pairwise.wilcox.test(n21$p, n21$sys); print(res)


##
## TaskSieve style analysis
## Precision + Count

cat("############### TaskSieve Style ##############\n")

nb <- subset(n$p, n$sys == 'vsb')
ne <- subset(n$p, n$sys == 'vse')
nn <- subset(n$p, n$sys == 'vsn')

nbs <- sort(nb, decreasing=T)
nes <- sort(ne, decreasing=T)
nns <- sort(nn, decreasing=T)

nes2 <- nes[1:451]
res <- wilcox.test(nbs,nes2,alternative='less'); print(res)

plot(nbs, type='l', lty=2, xlab="Top N Annotations", ylab="Precision", main="Average precision of top N Annotations", legend=T); lines(nes, type='l', pch=1, lty=1); legend(0, 0.95, c('TaskSieve', 'VIBE'), lty=2:1)


#

nbs2 <- nbs[1:423]
res <- wilcox.test(nbs2, nns); print(res)

nes3 <- nes[1:423]
res <- wilcox.test(nns,nes3); print(res)
