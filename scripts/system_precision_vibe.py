#!/usr/bin/python

from tdt4rel import Judge
import MySQLdb, sys
from dbconfig import *

j = Judge()

def get_rel_top(docs, topicid):
	rels = []
	for doc in docs[:10]:
		docno, x, y = doc.split(",")
		rel = j.check(topicid, docno)	
		rels.append(rel)
		
	if len(rels) == 0:
		return 0
	return float(sum(rels)) / len(rels)

def get_rel_by_rmargin(width, docs, topicid):
	rels = []
	for doc in docs:
		docno, x, y = doc.split(",")
		if int(x) > width * 0.95:
			rel = j.check(topicid, docno)	
			rels.append(rel)
	print float(sum(rels)) / len(rels)

def get_rel_topr(docs, topicid):
	temp = []
	for doc in docs:
		docno, x, y = doc.split(",")
		temp.append((int(x), docno))
	temp.sort()
	temp.reverse()
	
	temp2 = []
	for x, docno in temp[:250]:
		temp2.append(j.check(topicid, docno))
	print float(sum(temp2))/len(temp2)

con = MySQLdb.connect(HOST, USER, PASS, DB)
cur = con.cursor()

cur.execute("select userid, info from history where action = 'reset_visualization'")

for row in cur:
	userid, info = row
	
	system, userno, topicid = userid.split("-")
	metadata, pois, docs = info.split("\t")

	vis_size, layout = metadata.split(":")[1].split(" ")
	docs = docs.split(":")[1].split()

	get_rel_topr(docs, topicid)

	# system, userno, topicid, get_rel_by_rmargin(int(vis_size[0]), docs, topicid)
	# print system, userno, topicid, get_rel_top(docs, topicid)
