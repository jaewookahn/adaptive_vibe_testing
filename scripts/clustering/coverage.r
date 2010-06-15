library(sqldf)

d<-read.table('temp.txt')
d2<-sqldf('select distinct V3 topicid, V1 sys, V4 cluster from d')
res <- sqldf('select topicid, sys, count(*) from d2 group by topicid, sys')
print(res)