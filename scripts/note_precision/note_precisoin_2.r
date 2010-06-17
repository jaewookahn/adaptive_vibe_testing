library(reshape)
library(sqldf)

n <- read.table('../../data/note_precision_noerr.txt', header=T)
n <- subset(d, userno > 2 & userno != 29)

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

nb <- user_notep(n, 'vsb')
ne <- user_notep(n, 'vse')
nn <- user_notep(n, 'vsn')

nlb <- user_notel(n, 'vsb')
nle <- user_notel(n, 'vse')
nln <- user_notel(n, 'vsn')


nm <- sqldf('select nb.userno,nb.p as NB, ne.p as NE, nn.p as NN from nb,ne,nn where nb.userno = ne.userno and ne.userno=nn.userno')

res <- wilcox.exact(nm$NB, nm$NE, paired=T, alternative='less'); print(res)
res <- wilcox.exact(nm$NB, nm$NE, paired=T, alternative='less'); print(res)

nlm <- sqldf('select nb.userno,nb.p as NB, ne.p as NE, nn.p as NN from nlb nb,nle ne,nln nn where nb.userno = ne.userno and ne.userno=nn.userno')

res <- wilcox.exact(nlm$NB, nlm$NE, paired=T, alternative='less'); print(res)
res <- wilcox.exact(nlm$NB, nlm$NN, paired=T, alternative='less'); print(res)


# dbs <- subset(d, sys == 'vsb')
# des <- subset(d, sys == 'vse')
# dns <- subset(d, sys == 'vsn')
# 
# ##
# ## calculate per-user scores
# ##
# 
# user_ndcg <- function(data) {
# 	res <- aggregate(data$ndcg, mean, by=list(data$userno));
# 	res <- rename(res, c(Group.1="userno", x="ndcg"));
# 	return(res);
# }
# 
# user_p10 <- function(data) {
# 	res <- aggregate(data$top10, mean, by=list(data$userno));
# 	res <- rename(res, c(Group.1="userno", x="top10"));
# 	return(res);
# }
# 
# 
# db <- user_ndcg(dbs)
# de <- user_ndcg(des)
# dn <- user_ndcg(dns)
# 
# pb <- user_p10(dbs)
# pe <- user_p10(des)
# pn <- user_p10(dns)
# 
# 
# ##
# ## to compare with vsn where user=10 is missing
# ##
# 
# cat("## NDCG ###########################################################")
# 
# db2 <- subset(db, userno != 10)
# de2 <- subset(de, userno != 10)
# 
# pb2 <- subset(pb, userno != 10)
# pe2 <- subset(pe, userno != 10)
# 
# res <- wilcox.exact(db$ndcg, de$ndcg, paired=T); print(res)
# res <- wilcox.exact(db$ndcg, de$ndcg, paired=T, alternative='less'); print(res)
# res <- wilcox.exact(db2$ndcg, dn$ndcg, paired=T); print(res)
# res <- wilcox.exact(db2$ndcg, dn$ndcg, paired=T, alternative='less'); print(res)
# 
# cat("## P@10 ############################################################")
# 
# res <- wilcox.exact(pb$top10, pe$top10, paired=T); print(res)
# res <- wilcox.exact(pb$top10, pe$top10, paired=T, alternative='less'); print(res)
# 
# res <- wilcox.exact(pb2$top10, pn$top10, paired=T); print(res)
# res <- wilcox.exact(pb2$top10, pn$top10, paired=T, alternative='less'); print(res)
