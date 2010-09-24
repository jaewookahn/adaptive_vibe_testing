library(reshape)
library(sqldf)

pqb <- read.table("../../data/pq_sysb.txt", header=T, sep="\t")
pqe <- read.table("../../data/pq_syse.txt", header=T, sep="\t")
pqn <- read.table("../../data/pq_sysn.txt", header=T, sep="\t")

# familiarity (Q1)

f <- rbind(pqb$familiar, pqe$familiar, pqn$familiar)
f<-matrix(f)
summary(f)
 #       V1       
 # Min.   :1.000  
 # 1st Qu.:1.000  
 # Median :1.000  
 # Mean   :1.404  
 # 3rd Qu.:1.000  
 # Max.   :5.000
sd(f)
# [1] 0.8196464

# diffuculty

df1<-sqldf("select topicid, familiar from pqb")
df2<-sqldf("select topicid, familiar from pqe")
df3<-sqldf("select topicid, familiar from pqn")

df <- rbind(df1, df2)
df <- rbind(df, df3)

aggregate(df$familiar, mean, by=list(df$topicid), na.rm=T)






# overall means

mean(pqb, na.rm=T)
mean(pqe, na.rm=T)
mean(pqn, na.rm=T)

# positivity

pos2 <- read.table("../../data/pq_positive.txt", sep="\t")
shapiro.test(pos2$V2) # normality test
kruskal.test(V2~V1, pos2)

# positivity2

df1<-sqldf("select userno, sys, positive from pqb")
df2<-sqldf("select userno, sys, positive from pqe")
df3<-sqldf("select userno, sys, positive from pqn")

df <- cbind(df1, epos=df2$positive)
df <- cbind(df, npos=df3$positive)

sqldf('select userno, epos-positive, npos-positive from df')

sqldf('select d1, count(*) from (select userno, epos-positive d1, npos-positive d2 from df) x group by d1')

sqldf('select d2, count(*) from (select userno, epos-positive d1, npos-positive d2 from df) x group by d2')

sqldf('select d3, count(*) from (select userno, epos-positive d1, npos-positive d2, npos-epos d3 from df) x group by d3')

# positivity by gender

df1<-sqldf("select userno, sys, positive from pqb")
df2<-sqldf("select userno, sys, positive from pqe")
df3<-sqldf("select userno, sys, positive from pqn")

df <- cbind(df1, epos=df2$positive)
df <- cbind(df, npos=df3$positive)

g<-read.table('../../data/pq_bio.txt', header=T, sep="\t")
df<-cbind(df,g)

aggregate(df$positive, mean, by=list(df$Gender))

#   Group.1        x
# 1       f 3.700000
# 2       m 3.782609

aggregate(df$epos, mean, by=list(df$Gender))

#   Group.1        x
# 1       f 2.900000
# 2       m 3.304348

aggregate(df$npos, mean, by=list(df$Gender))

#   Group.1        x
# 1       f 3.100000
# 2       m 3.521739

kruskal.test(positive~Gender, df)
kruskal.test(epos~Gender, df)
kruskal.test(npos~Gender, df)

# 	Kruskal-Wallis rank sum test
# 
# data:  positive by Gender 
# Kruskal-Wallis chi-squared = 0.131, df = 1, p-value = 0.7174
# 
# 	Kruskal-Wallis rank sum test
# 
# data:  epos by Gender 
# Kruskal-Wallis chi-squared = 0.7791, df = 1, p-value = 0.3774
# 
# 	Kruskal-Wallis rank sum test
# 
# data:  npos by Gender 
# Kruskal-Wallis chi-squared = 0.9532, df = 1, p-value = 0.3289

# diffuculty

df1<-sqldf("select topicid, difficulty from pqb")
df2<-sqldf("select topicid, difficulty from pqe")
df3<-sqldf("select topicid, difficulty from pqn")

df <- rbind(df1, df2)
df <- rbind(df, df3)

aggregate(df$difficulty, mean, by=list(df$topicid), na.rm=T)

shapiro.test(df$difficulty)
kruskal.test(difficulty~topicid, df)

# topic vs. familiarity to difficulty

df1<-sqldf("select topicid, familiar, difficulty from pqb")
df2<-sqldf("select topicid, familiar, difficulty from pqe")
df3<-sqldf("select topicid, familiar, difficulty from pqn")

df <- rbind(df1, df2)
df <- rbind(df, df3)

# passage quality (Q2)

df1<-sqldf("select sys, psg_q from pqb")
df2<-sqldf("select sys, psg_q from pqe")
df3<-sqldf("select sys, psg_q from pqn")

df <- rbind(df1, df2)
df <- rbind(df, df3)

aggregate(df$psg_q, mean, by=list(df$sys))
shapiro.test(df$psg_q)
kruskal.test(psg_q~sys, df)

# passage->opendoc (Q3)

df1<-sqldf("select sys, opendoc_psg from pqb")
df2<-sqldf("select sys, opendoc_psg from pqe")
df3<-sqldf("select sys, opendoc_psg from pqn")

df <- rbind(df1, df2)
df <- rbind(df, df3)

aggregate(df$opendoc_psg, mean, by=list(df$sys))
shapiro.test(df$opendoc_psg)
kruskal.test(opendoc_psg~sys, df)

# by features

me<-melt(pqe, id=c("userno", "sys"))
me1<-subset(me, me$variable == 'adv_helpful' or me$variable == 'poi_loc' or me$variable == 'rel_exp')
shapiro.test(me1$value)
kruskal.test(value~variable, me1)
pairwise.wilcox.test(me1$value, me1$variable)


mn<-melt(pqn, id=c("userno", "sys"))
mn1<-subset(mn, variable=="ne_useful" | variable=='ne_rel' | variable=='nevis_helpful')
shapiro.test(mn1$value)