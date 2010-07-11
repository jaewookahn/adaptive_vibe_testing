#!/usr/bin/python

import os, sys
from sets import Set

if len(sys.argv) < 2:
	"Usage: command TOPICID"
	sys.exit(1)

TOPICID = int(sys.argv[1])

gtvoc = []
gttemp = []
fp = open('gtvoc_%d.txt' % TOPICID)
for s in fp:
	s = s.strip()
	term, df, idf = s.split()
	gtvoc.append(term)
	
	gttemp.append([float(df), term])
fp.close()


nvoc = {'vsn':[], 'vse':[], 'vsb':[]}
fp = open('notevoc_%d.txt' % TOPICID)
for s in fp:
	s = s.strip()
	system, userno, term = s.split()
	if userno in ['01', '02', '10', '29']:
		continue

	nvoc[system].append(term)
fp.close()

setg = Set(gtvoc)
setb = Set(nvoc['vsb'])
sete = Set(nvoc['vse'])
setn = Set(nvoc['vsn'])

glen = float(len(setg))
print len(setg-setb) / glen
print len(setg-sete) / glen
print len(setg-setn) / glen

gttemp.sort()
gttemp.reverse()
gtdf = []
for i in range(50):
	gtdf.append(gttemp[i][1])
	
setgdf = Set(gtdf)
print len(setgdf-setb)
print len(setgdf-sete)
print len(setgdf-setn)
