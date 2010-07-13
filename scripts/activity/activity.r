# poi movement

d<-read.table("action_movepoi.txt", header=T)

aggregate(d$poitype, length, by=list(d$sys))
aggregate(d$poitype, length, by=list(d$poitype,d$sys))

dt <- aggregate(d$poitype, length, by=list(d$userno))
summary(dt)

hist(dt$x, main="Frequency of POI Movement by User", xlab="POI Movement", ylab="User Count", col="gray", breaks=10, xlim=c(0,150), ylim=c(0,10))


## stat test

dq <- subset(d, d$poitype == 0)
du <- subset(d, d$poitype > 0)

dqt <- aggregate(dq$action, length, by=list(userno=dq$userno))
dut <- aggregate(du$action, length, by=list(userno=du$userno))

dtall<-merge(dqt, dut, by="userno", all=T)
wilcox.exact(dtall$x.x, dtall$x.y, paired=T)

# open doc

d<-read.table("action_vis_opendoc.txt")
aggregate(d$V5, length, by=list(d$V5))

d1<-subset(d, V2 <= 27)
d2<-subset(d, V2 > 27)

aggregate(d1$V5, length, by=list(d1$V5))
aggregate(d2$V5, length, by=list(d2$V5))

#  reset visualization

d<-read.table("action_resetvis.txt")
aggregate(d$V4, length, by=list(d$V1))
dt<-aggregate(d$V4, length, by=list(d$V2))
summary(dt)

hist(dt$x, main="Frequency of Visualization Update", xlab="Visualization Update", ylab="User Count", col="gray", breaks=10, xlim=c(0,80), ylim=c(0,10))

# slider

d<-read.table("action_slider.txt", header=F)

dt<-aggregate(d$V4, length, by=list(d$V2))

aggregate(d$V4, length, by=list(d$V1))
aggregate(d$V4, length, by=list(d$V3))

# marquee

d<-read.table("action_marquee.txt", header=T)
length(d$sys) # frequency
dt<-aggregate(d$docs, length, by=list(d$userno))
length(dt$x) # number of users who used the feature
aggregate(d$docs, length, by=list(d$sys))
aggregate(d$docs, length, by=list(d$topicid))
summary(dt)

# auto marquee

d<-read.table("action_automarquee.txt",header=T)

aggregate(d$docs, length, by=list(d$sys))
aggregate(d$docs, length, by=list(d$topicid))

dt<-aggregate(d$docs, length, by=list(d$userno))

summary(dt)