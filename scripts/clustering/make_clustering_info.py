#!/usr/bin/python

import string

TOPIC = 40021

def get_max(s):
	temp = s.split()
	max = 0
	for id, p in enumerate(temp):
		if max < p:
			max = p
			maxid = id
	return maxid

f = open('%s_doc.dat' % TOPIC)

docnos = []
for s in f:
	docnos.append(s.strip())

f.close()

f = open("inf-%s-gamma.dat" % TOPIC)

cl = {}
for i, s in enumerate(f):
	s = s.strip()
	clid = get_max(s)
	docno = docnos[i]
	
	if cl.has_key(clid):
		cl[clid].append(docno)
	else:
		cl[clid] = [docno]

f.close()

kk = cl.keys()
kk.sort()

for clid in kk:
	print TOPIC, clid, string.join(cl[clid], ' ')
