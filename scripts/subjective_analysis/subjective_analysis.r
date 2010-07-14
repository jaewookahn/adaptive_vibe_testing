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

shapiro.test(pos2$V2) # normality test

pos2 <- read.table("../../pq.positive.txt", sep="\t")
kruskal.test(V2~V1, pos2)

# diffuculty

df1<-sqldf("select topicid, difficulty from pqb")
df2<-sqldf("select topicid, difficulty from pqe")
df3<-sqldf("select topicid, difficulty from pqn")

df <- rbind(df1, df2)
df <- rbind(df, df3)

aggregate(df$difficulty, mean, by=list(df$topicid), na.rm=T)

shapiro.test(df$difficulty)
kruskal.test(difficulty~topicid, df)

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