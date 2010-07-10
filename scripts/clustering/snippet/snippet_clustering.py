#!/usr/bin/python

TOPICID = 40009
CLUSTERCOUNT = 20

def get_max(s):
	temp = map(float, s.split())
	max = 0
	for id, p in enumerate(temp):
		if max < p:
			max = p
			maxid = id
	return maxid
	
for CLUSTERCOUNT in [10,15,20]:
	for TOPICID in [40009,40048,40021]:
	
	
		f = open("corpus-%d/data.txt" % TOPICID)
		noteinfo = []
		for s in f:
			if s.startswith("<DOCNO>NOTE"):
				s = s.strip()
				noteinfo.append(s[12:-8])
		f.close()

		f = open("lda/inf/inf-%d-%d-gamma.dat" % (CLUSTERCOUNT, TOPICID))

		for i, s in enumerate(f):
			system, userno, noteno = noteinfo[i].split('-')
			print CLUSTERCOUNT, TOPICID, system, userno, noteno, get_max(s)
		f.close()