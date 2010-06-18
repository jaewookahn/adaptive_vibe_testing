library(moments)

dx <- read.table('../../data/system_precision_vistop_with_agvx.txt', header=T, sep=' ')
dx <- subset(dx, userno > 2 & userno != 29)


##
## overall
##

dxc <- subset(dx, dx$ratiox >=0)

# left & right each
dxr <- subset(dxc, ratiox >= 0.5)
dxl <- subset(dxc, ratiox < 0.5)

cat(length(dxl$ratiox), length(dxr$ratiox), '\n')
hist(dxc$ratiox, breaks=50)
readline()

##
## in um
##

dxc1 <- subset(dxc, inum == 1)
dxc1r <- subset(dxc1, ratiox >= 0.5)
dxc1l <- subset(dxc1, ratiox < 0.5)

cat(length(dxc1l$ratiox), length(dxc1r$ratiox), '\n')
hist(dxc1$ratiox, breaks=50)
readline()

##
## relevant ones
##

print(kurtosis(dxc$ratiox))
readline()

dxcr <- subset(dxc, dxc$top10 > 0.9)
hist(dxcr$ratiox, breaks=50)
print(kurtosis(dxcr$ratiox))
