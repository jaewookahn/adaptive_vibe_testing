dpoi <- read.table("../data/poi_action_count_mov_poi.txt", header=T)
dop <- read.table("../data/open_precision2-2.txt")
dopp<-sqldf("select V1 sys, V2 userno, sum(V5) rel, count(V5) total, sum(V5)*1.0/count(V5) open_prec from dop where V1 != 'vsb' group by V1, V2")

# all
poi_per_corr <- sqldf("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and count<15"); cor(poi_per_corr$count, poi_per_corr$open_prec); plot(poi_per_corr$count, poi_per_corr$open_prec); abline(lm(poi_per_corr$open_prec~poi_per_corr$count))
summary(lm(poi_per_corr$open_prec~poi_per_corr$count))

# vse
poi_per_corr <- sqldf("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and dpoi.sys == 'vse'"); cor(poi_per_corr$count, poi_per_corr$open_prec); plot(poi_per_corr$count, poi_per_corr$open_prec); abline(lm(poi_per_corr$open_prec~poi_per_corr$count))

# vsn
poi_per_corr <- sqldf("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and dpoi.sys == 'vsn'"); cor(poi_per_corr$count, poi_per_corr$open_prec); plot(poi_per_corr$count, poi_per_corr$open_prec); abline(lm(poi_per_corr$open_prec~poi_per_corr$count))

# vse + condition
poi_per_corr <- sqldf("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and dpoi.sys == 'vse' and count>40"); cor(poi_per_corr$count, poi_per_corr$open_prec); plot(poi_per_corr$count, poi_per_corr$open_prec); abline(lm(poi_per_corr$open_prec~poi_per_corr$count))

# vsn + condition
poi_per_corr <- sqldf("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and dpoi.sys == 'vsn' and count>70"); cor(poi_per_corr$count, poi_per_corr$open_prec); plot(poi_per_corr$count, poi_per_corr$open_prec); abline(lm(poi_per_corr$open_prec~poi_per_corr$count))

# vse -> coun
poi_per_corr <- sqldf("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and dpoi.sys == 'vse'"); cor(poi_per_corr$count, poi_per_corr$rel); plot(poi_per_corr$count, poi_per_corr$open_prec); abline(lm(poi_per_corr$open_prec~poi_per_corr$count))

poi_per_corr <- sqldf("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and dpoi.sys == 'vsn'"); cor(poi_per_corr$count, poi_per_corr$rel); plot(poi_per_corr$count, poi_per_corr$open_prec); abline(lm(poi_per_corr$open_prec~poi_per_corr$count))

#####

