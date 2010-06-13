library(moments)

dx <- read.table('system_precision_vistop_with_agvx.txt', header=T, sep=' ')
dxc <- subset(dx, dx$ratiox >=0)

hist(dxc$ratiox, breaks=50)
print(kurtosis(dxcr$ratiox))
readline()

dxcr <- subset(dxc, dxc$top10 > 0.9)
hist(dxcr$ratiox, breaks=50)
print(kurtosis(dxc$ratiox))
