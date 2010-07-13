library(sqldf)

d<-read.table('../../data/coverage_20.txt')

d<-subset(d, d$V2 != 10)

# d2<-sqldf("select distinct V3 topicid, V1 sys, V5 cluster from d where V4 ='open_doc'")
# res <- sqldf('select topicid, sys, count(*) from d2 group by topicid, sys')
# print(res)
# 
# d2<-sqldf("select distinct V3 topicid, V1 sys, V5 cluster from d where V4 ='save_note'")
# res <- sqldf('select topicid, sys, count(*) from d2 group by topicid, sys')
# print(res)
# 

res <- sqldf("select V3, V1, count(distinct V5) from d where V4 = 'open_doc' group by V3, V1"); print(res)

res <- sqldf("select V3, V1, count(distinct V5) from d where V4 = 'save_note' group by V3, V1"); print(res)