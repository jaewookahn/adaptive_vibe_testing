# analysis of note precision "before" subjects cleaned them
	
du <- read.table('../../data/note_precision_um_clean_noerr.txt')
dus <- subset(du, du$V3 > 2 & du$V3 != 10 & du$V3 != 29)

res <- aggregate(dus$V6, mean, by=list(dus$V2)); print(res)
res <- aggregate(dus$V6, mean, by=list(dus$V2,dus$V4)); print(res)
res <- kruskal.test(V6~V2, dus); print(res)
res <- pairwise.wilcox.test(dus$V6,dus$V2); print(res)

# analysis of user note count / sum or precision

res <- aggregate(dus$V6, length, by=list(dus$V2)); print(res)
res <- aggregate(dus$V6, length, by=list(dus$V2, dus$V4)); print(res)

res <- aggregate(dus$V6, sum, by=list(dus$V2)); print(res)
res <- aggregate(dus$V6, sum, by=list(dus$V2, dus$V4)); print(res)

# comparison of note sum

dsum <- aggregate(dus$V6, sum, by=list(userno=dus$V3,sys=dus$V2))
res <- kruskal.test(x~sys, dsum); print(res)

#

dusa <- aggregate(dus$V6, mean,by=list(dus$V3, dus$V2))

