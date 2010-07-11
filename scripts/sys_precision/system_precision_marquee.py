#!/usr/bin/python

import sys; sys.path.append("../common")
import MySQLdb
from dbconfig import *
from tdt4rel import Judge

j = Judge()

def get_rel_top(docs, topicid):
	rels = []
	for doc in docs:
		docno, x, y = doc.split(",")
		rel = j.check(topicid, docno)	
		rels.append(rel)
		
	if len(rels) == 0:
		return 0
	return float(sum(rels)) / len(rels)

def get_rel_top_vibeselection(docs, topicid):
	rels = []
	for docno in docs:
		if ',' in docno:
			docno = docno.split(",")[0]
		rel = j.check(topicid, docno)	
		rels.append(rel)

	if len(rels) == 0:
		return 0
	return float(sum(rels)) / len(rels)

#con = MySQLdb.connect(HOST, USER, PASS, DB)
con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

# cur.execute("select userid, info from history where action = 'marquee_selection' and userid like 'vs%' and userid != 'vst'")

cur.execute("select userid, info from history where userid like 'vs%' and userid != 'vst' and (action = 'view_vibe_selection' or action = 'automarquee_selection') order by userid, datetime asc")

for row in cur:
	userid, info = row
	system, userno, topicid = userid.split("-")

	
	# doc_count, docs = info.split(" ", 1)
	# doc_count = doc_count.split(":")[1]
	# docs = docs.split(":")[1].split()

	if info.startswith('automarquee'):
		docs = info.split()[2].split(":")[1].split()
	else:
		docs = info.split(":")[1].split()

	
	# if doc_count == '0':
	# 	continue
		
	# print system, topicid, userno, doc_count, get_rel_top(docs, topicid)
	print system, topicid, userno, get_rel_top_vibeselection(docs, topicid)
