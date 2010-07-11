#!/usr/bin/python

import os, bsddb, string, sys
import MySQLdb

if len(sys.argv) < 2:
	"Usage: command TOPICID"
	sys.exit(1)
	
con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

TOPICID = int(sys.argv[1])

gt_count = {40009:534, 40021:1454, 40048:733}

#
# read term id from the indri index
	
dv = bsddb.btopen('dv-%d.bsddb' % TOPICID, 'r')

fp = os.popen("dumpindex index-%d v" % TOPICID)
fp.readline()

terms = []
for s in fp:
	s = s.strip()
	term, temp, temp = s.split()
	terms.append(term)
fp.close()

start = 1
end = gt_count[TOPICID] + 1

uterms = []

for i in range(start, end):
	for term in terms:
		key = "%d:%s" % (i, term)
		if dv.has_key(key):
			if term not in uterms:
				uterms.append(term)
				
for term in uterms:
	N = cur.execute("select df, idf from df where term = '%s'" % term)
	if N > 0:
		df, idf = cur.fetchone()
		print term, df, idf
