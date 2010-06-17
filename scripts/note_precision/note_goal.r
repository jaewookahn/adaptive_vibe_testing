# select 40009, system, userno, count(distinct qno)/7 from note_precision_noerr
# where topicid = 40009
# and prec > 0.9
# group by system, userno
# 
# union
# 
# select 40021, system, userno, count(distinct qno)/12 from note_precision_noerr
# where topicid = 40021
# and prec > 0.9
# group by system, userno
# 
# union
# 
# select 40048, system, userno, count(distinct qno)/8 from note_precision_noerr
# where topicid = 40048
# and prec > 0.9
# group by system, userno;

nc <- read.table(pipe('pbpaste'))
ncb <- subset(nc, nc$V2 == 'vsb')
nce <- subset(nc, nc$V2 == 'vse')
ncn <- subset(nc, nc$V2 == 'vsn')

nall <- sqldf('select ncb.V3, ncb.V4 b, nce.V4 e, ncn.V4 n from ncb, nce, ncn where ncb.V3 = nce.V3 and nce.V3 = ncn.V3')

wilcox.test(nall$b, nall$e, paired=T, alternative='less')
wilcox.test(nall$b, nall$n, paired=T, alternative='less')