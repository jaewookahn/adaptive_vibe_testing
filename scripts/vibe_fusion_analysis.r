du <- read.table('../data/vibe_fusion_withum.txt', header=T)
duu <- subset(du, du$isum == 1 & (sys != 'vsb' | userno != 33))

res <- aggregate(duu$db, mean, by=list(duu$sys)); print(res)
res <- kruskal.test(db~sys, duu); print(res)
res <- pairwise.wilcox.test(duu$db, duu$sys); print(res)

res <- aggregate(duu$db, mean, by=list(duu$sys, duu$topicid)); print(res)

res <- mean(duu); print(res)

wilcox.test(duu$crx, duu$cnx); print(res)


duu09 <- subset(duu, duu$topicid == 40009)
res<-kruskal.test(db~sys, duu09); print(res)

duu21 <- subset(duu, duu$topicid == 40021)
res<-kruskal.test(db~sys, duu21); print(res)


duu48 <- subset(duu, duu$topicid == 40048)
res<-kruskal.test(db~sys, duu48); print(res)

