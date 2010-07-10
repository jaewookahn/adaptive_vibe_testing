# read output from snippet_clustering.py

d<-read.table('../../../data/snippet_clustering.txt')
sqldf("select V1,V2,V3,count(distinct V6) from d group by V1,V2,V3")
