library(sqldf)

d<-read.table('../../data/coverage.txt')

d2<-sqldf("select distinct V3 topicid, V1 sys, V5 cluster from d where V4 ='open_doc'")
res <- sqldf('select topicid, sys, count(*) from d2 group by topicid, sys')
print(res)

d2<-sqldf("select distinct V3 topicid, V1 sys, V5 cluster from d where V4 ='save_note'")
res <- sqldf('select topicid, sys, count(*) from d2 group by topicid, sys')
print(res)
# 
