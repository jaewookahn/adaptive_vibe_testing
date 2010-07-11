#!/usr/bin/python

import os, bsddb, string, sys

def getdocno(i, TOPICID):
	fp = os.popen("dumpindex index-%d dt %d" % (TOPICID, i))
	for s in fp:
		s = s.strip()
		if s[:7] == '<DOCNO>':
			return s[7:-8]
	
if len(sys.argv) < 2:
	"Usage: command TOPICID"
	sys.exit(1)

TOPICID = int(sys.argv[1])

gt_count = {40009:534, 40021:1454, 40048:733}
fp = os.popen("dumpindex index-%d s" % TOPICID)
doccount = int(fp.readlines()[1].split(":")[1].strip())
fp.close()

#	
dv = bsddb.btopen('dv-%d.bsddb' % TOPICID, 'r')

fp = os.popen("dumpindex index-%d v" % TOPICID)
fp.readline()

terms = []
for s in fp:
	s = s.strip()
	term, temp, temp = s.split()
	terms.append(term)
fp.close()

# note only
start = gt_count[TOPICID] + 1
end = doccount + 1

uterms = []
for i in range(start, end):
	docno = getdocno(i, TOPICID)
	temp, system, userno, temp = docno.split('-')
	for term in terms:
		key = "%d:%s" % (i, term)
		if dv.has_key(key):
			print system, userno, term
