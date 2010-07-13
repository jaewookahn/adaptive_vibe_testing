#!/usr/bin/python

options(echo=TRUE)

d <- read.table("../../data/query_length.txt")
ds <- subset(d, d$V2 > 2 & d$V2 != 10 & d$V2 != 29)
names(ds) <- c("sys", "userno", "topicid", "ql")

res <- aggregate(ds$ql, mean, by=list(ds$sys)); print(res)
res <- kruskal.test(ql~sys, ds); print(res)

res <- aggregate(ds$ql, mean, by=list(ds$topicid)); print(res)
res <- kruskal.test(ql~topicid, ds); print(res)
res <- pairwise.wilcox.test(ds$ql, ds$topicid); print(res)