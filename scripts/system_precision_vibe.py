#!/usr/bin/python

from tdt4rel import Judge
import MySQLdb, sys
from dbconfig import *

j = Judge()

def get_rel(width, docs, topicid):
	rels = []
	for doc in docs:
		docno, x, y = doc.split(",")
		if int(x) > width * 0.95:
			rel = j.check(topicid, docno)	
			rels.append(rel)
	print float(sum(rels)) / len(rels)

def get_rel_top(docs, topicid):
	rels = []
	for doc in docs[:10]:
		docno, x, y = doc.split(",")
		rel = j.check(topicid, docno)	
		rels.append(rel)
		
	if len(rels) == 0:
		return 0
	return float(sum(rels)) / len(rels)

con = MySQLdb.connect(HOST, USER, PASS, DB)
cur = con.cursor()

cur.execute("select userid, info from history where action = 'reset_visualization'")

for row in cur:
	userid, info = row
	
	system, userno, topicid = userid.split("-")
	metadata, pois, docs = info.split("\t")

	vis_size, layout = metadata.split(":")[1].split(" ")
	docs = docs.split(":")[1].split()

	# get_rel(int(vis_size[0]), docs, topicid)
	print system, userno, topicid, get_rel_top(docs, topicid)
