library(reshape)
library(sqldf)

db <- read.table('../../data/system_precision_baseline_ndcg.txt', header=T)
dv <- read.table('../../data/system_precision_vistop_ndcg.txt', header=T)

dv <- subset(dv, select=sys:inum)
d <- rbind(db, dv)
d <- subset(d, userno > 3 & userno != 29)

res <- aggregate(d$ndcg, mean, by=list(d$sys)); print(res)

dbs <- subset(d, sys == 'vsb')
des <- subset(d, sys == 'vse')
dns <- subset(d, sys == 'vsn')

##
## calculate per-user scores
##

user_ndcg <- function(data) {
	res <- aggregate(data$ndcg, mean, by=list(data$userno));
	res <- rename(res, c(Group.1="userno", x="ndcg"));
	return(res);
}

user_p10 <- function(data) {
	res <- aggregate(data$top10, mean, by=list(data$userno));
	res <- rename(res, c(Group.1="userno", x="top10"));
	return(res);
}


db <- user_ndcg(dbs)
de <- user_ndcg(des)
dn <- user_ndcg(dns)

pb <- user_p10(dbs)
pe <- user_p10(des)
pn <- user_p10(dns)


##
## to compare with vsn where user=10 is missing
##

cat("## NDCG ###########################################################")

db2 <- subset(db, userno != 10)
de2 <- subset(de, userno != 10)

pb2 <- subset(pb, userno != 10)
pe2 <- subset(pe, userno != 10)

res <- wilcox.exact(db$ndcg, de$ndcg, paired=T); print(res)
res <- wilcox.exact(db$ndcg, de$ndcg, paired=T, alternative='less'); print(res)
res <- wilcox.exact(db2$ndcg, dn$ndcg, paired=T); print(res)
res <- wilcox.exact(db2$ndcg, dn$ndcg, paired=T, alternative='less'); print(res)

cat("## P@10 ############################################################")

res <- wilcox.exact(pb$top10, pe$top10, paired=T); print(res)
res <- wilcox.exact(pb$top10, pe$top10, paired=T, alternative='less'); print(res)

res <- wilcox.exact(pb2$top10, pn$top10, paired=T); print(res)
res <- wilcox.exact(pb2$top10, pn$top10, paired=T, alternative='less'); print(res)
