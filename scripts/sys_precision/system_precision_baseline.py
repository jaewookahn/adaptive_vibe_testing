#!/usr/bin/python
import sys; sys.path.append("../common")
from tdt4rel import Judge
import MySQLdb, sys
import bsddb
from ndcg import get_ndcg

def get_precision(topicid, docs):
	j = Judge()
	rels = []
	for docno in docs:
		rel = j.check(topicid, docno)
		rels.append(rel)
	ndcg = get_ndcg(rels)
		
	return (sum(rels[:5]) / 5., sum(rels) /10., ndcg, rels)

def average(list):
	return sum(list) / float(len(list))

if len(sys.argv) != 2:
	print "%s subjectid[number,all]" % sys.argv[0]
	sys.exit(1)

subjectid = sys.argv[1]

umtime = bsddb.btopen('../misc/umtime.bsddb', 'r')

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

if subjectid == 'all':
	q = "select unix_timestamp(datetime), userid, info from history where userid like 'vsb-%%-%%' and action = 'response'"
else:
	q = "select unix_timestamp(datetime), userid, info from history where userid like 'vsb-%s-%%' and action = 'response'" % subjectid

cur.execute(q)

print "sys userno topicid top5 top10 ndcg inum"
for row in cur:
	datetime, userid, info = row

	system, userno, topicid = userid.split('-')

	temp = info.split()
	alpha = temp[0]
	ret_count = temp[1]
	docs = temp[2:]

	prec5, prec10, ndcg, rels = get_precision(topicid, docs)
	
	if umtime.has_key(userid):
		if datetime > int(umtime[userid]):
			inUm = 1
		else:
			inUm = 0
	else:
		inUm = 0
	
	print 'vsb', userno, topicid, prec5, prec10, ndcg, inUm
