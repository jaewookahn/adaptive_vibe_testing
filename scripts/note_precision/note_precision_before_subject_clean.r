# analysis of note precision "before" subjects cleaned them
	
du <- read.table('../../data/note_precision_um_clean.txt')
dus <- subset(du, du$V3 > 2 & du$V3 != 10 & du$V3 != 29)

res <- aggregate(dus$V7, mean, by=list(dus$V2)); print(res)
res <- aggregate(dus$V7, mean, by=list(dus$V2,dus$V4)); print(res)
res <- kruskal.test(V7~V2, dus); print(res)
res <- pairwise.wilcox.test(dus$V7,dus$V2); print(res)

# analysis of user note count / sum or precision

res <- aggregate(dus$V7, length, by=list(dus$V2)); print(res)
res <- aggregate(dus$V7, length, by=list(dus$V2, dus$V4)); print(res)

res <- aggregate(dus$V7, sum, by=list(dus$V2)); print(res)
res <- aggregate(dus$V7, sum, by=list(dus$V2, dus$V4)); print(res)
