#!/usr/bin/python

import sys; sys.path.append("../common")
from tdt4rel import Judge
import MySQLdb, sys
from dbconfig import *
import bsddb
from ndcg import get_ndcg

j = Judge()

def get_rel_top(docs, topicid):

	allx = []
	for doc in docs:
		docno, x, y = doc.split(",")
		allx.append(int(x))

	if len(allx) > 0:
		minx = min(allx)
		maxx = max(allx)
	else:
		minx = 0
		maxx = 0

	rels = []
	xs = []

	for doc in docs[:10]:
		docno, x, y = doc.split(",")
		rel = j.check(topicid, docno)	
		
		rels.append(rel)
		xs.append(int(x))
		
	if len(xs) == 0:
		avg_x = -1
		ratio_x = -1
	else:
		avg_x = float(sum(xs)) / len(xs)
		
		if maxx - minx == 0 :
			ratio_x = -1
		else:
			ratio_x = float(avg_x - minx) / (maxx - minx)
		
	ndcg = get_ndcg(rels)
		
	if len(rels) == 0:
		return 0, ndcg, avg_x, ratio_x
		
	return (float(sum(rels)) / len(rels), ndcg, avg_x, ratio_x)

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

umtime = bsddb.btopen('../misc/umtime.bsddb', 'r')

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

cur.execute("select unix_timestamp(datetime), userid from history where action = 'login' and (userid like 'vse%' or userid like 'vsn%') and userid != 'vst' order by datetime asc")

ltime = {}
for row in cur:
	datetime, userid = row
	if not ltime.has_key(userid):
		ltime[userid] = datetime

cur.execute("select unix_timestamp(datetime), userid, info from history where action = 'reset_visualization' and (userid like 'vse%' or userid like 'vsn%') and userid != 'vst'")

print "sys userno topicid top5 top10 ndcg inum avgx ratiox time"

for row in cur:
	datetime, userid, info = row

	system, userno, topicid = userid.split("-")
	metadata, pois, docs = info.split("\t")

	vis_size, layout = metadata.split(":")[1].split(" ")
	docs = docs.split(":")[1].split()

	if umtime.has_key(userid):
		if datetime > int(umtime[userid]):
			inUm = 1
		else:
			inUm = 0
	else:
		inUm = 0

	# get_rel_topr(docs, topicid)

	# system, userno, topicid, get_rel_by_rmargin(int(vis_size[0]), docs, topicid)
	
	rel, ndcg, avg_x, ratio_x = get_rel_top(docs, topicid)
	print system, userno, topicid, "-1", rel, ndcg, inUm, avg_x, ratio_x, datetime - ltime[userid]
