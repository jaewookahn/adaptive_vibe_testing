dpoi_temp <- read.table("../data/poi_action_count_mov_poi2.txt", header=T)

dpoi <- subset(dpoi_temp, action == 'move_poi' & sys != 'vsb')
dim(dpoi)

dop <- read.table("../data/open_precision2-2-time.txt", header=T)

dopp<-sqldf("select sys, userno, topic, sum(rel), count(rel) total, sum(rel)*1.0/count(rel) open_prec, time from dop where sys != 'vsb' group by sys, userno, topic")


# all
poi_per_corr <- sqldf("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and dpoi.topic = dopp.topic ")
cor(poi_per_corr$count, poi_per_corr$open_prec, method="pearson")
plot(poi_per_corr$count, poi_per_corr$open_prec);abline(lm(poi_per_corr$open_prec~poi_per_corr$count))
ggplot(poi_per_corr, aes(x=count, y=open_prec)) + geom_point(shape=1) + geom_smooth(method=loess, se=T) + xlab("POI manipulation count (per session)") + ylab("Mean open precision") + geom_smooth(method=lm, se=F, linetype=2)
summary(lm(poi_per_corr$open_prec~poi_per_corr$count))

getcor <- function(n) {
  poi_per_corr <- sqldf(paste("select * from dpoi, dopp where dpoi.sys = dopp.sys and dpoi.userno = dopp.userno and dpoi.topic = dopp.topic and count <= ", as.character(n)))
  cor(poi_per_corr$count, poi_per_corr$open_prec, method="pearson")  
}

corrs<-sapply(3:67, getcor)
corrs2<-data.frame(x=3:67,corrs)
plot(3:67, corrs)
ggplot(corrs2, aes(x=x, y=corrs)) + geom_line() + geom_point(shape=1) + geom_smooth() + xlab("Max POI manipulation count") + ylab("Correlation coefficient (Pearson)")
                                                          

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

