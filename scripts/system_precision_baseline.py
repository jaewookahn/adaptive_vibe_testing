#!/usr/bin/python

from tdt4rel import Judge
import MySQLdb, sys

def get_precision(topicid, docs):
	j = Judge()
	rels = []
	for docno in docs:
		rel = j.check(topicid, docno)
		rels.append(rel)
	return (sum(rels[:5]) / 5., sum(rels) /10., rels)

def average(list):
	return sum(list) / float(len(list))

if len(sys.argv) != 2:
	print "%s subjectid[number,all]" % sys.argv[0]
	sys.exit(1)

subjectid = sys.argv[1]

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

if subjectid == 'all':
	q = "select datetime, userid, info from history where userid like 'vsb-%%-%%' and action = 'response'"
else:
	q = "select datetime, userid, info from history where userid like 'vsb-%s-%%' and action = 'response'" % subjectid

cur.execute(q)

for row in cur:
	datetime, userid, info = row

	system, userno, topicid = userid.split('-')

	temp = info.split()
	alpha = temp[0]
	ret_count = temp[1]
	docs = temp[2:]

	prec5, prec10, rels = get_precision(topicid, docs)
	
	print userno, topicid, prec5, prec10
