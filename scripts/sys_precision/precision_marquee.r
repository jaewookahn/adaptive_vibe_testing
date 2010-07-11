d<- read.table('../../data/precision_marquee.txt')
ds <- subset(d, d$V3 >2 & d$V3 != 10 & d$V3 != 29)
aggregate(ds$V4, mean, by=list(ds$V1))

//////////////////

db<-read.table('system_precision_baseline.txt', header=T)
dbs<-subset(db, userno > 2 & userno != 10 & userno != 29)

dv<-read.table('precision_marquee.txt')
dvs<-subset(dv, dv$V3 >2 & dv$V3 != 10 & dv$V3 != 29)

pbase <- dbs$top10
pne <- subset(dvs, dvs$V1 == 'vsn')$V4
pvibe <- subset(dvs, dvs$V1 == 'vse')$V4

wilcox.test(pbase, pvibe)
wilcox.test(pbase, pne)

///////////////////

dbv <- data.frame(sys=dbs$sys, userno=dbs$userno, p=dbs$top10)
dvv <- data.frame(sys=dvs$V1, userno=dvs$V3, p=dvs$V4)

dall <- rbind(dbv, dvv)
res<-kruskal.test(p~sys, dall); print(res)
res<-pairwise.wilcox.test(dall$p, dall$sys); print(res)

///////////////////
// split exp phase 1 and 2

dall1 <- subset(dall, userno <= 27)
dall2 <- subset(dall, userno >27)

aggregate(dall1$p, mean, by=list(dall1$sys))
aggregate(dall2$p, mean, by=list(dall2$sys))
