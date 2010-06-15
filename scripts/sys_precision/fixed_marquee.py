#!/usr/bin/python

import sys; sys.path.append("../common")
from tdt4rel import Judge
import MySQLdb, sys

def get_minmax(docs):
	xs = []
	for doc in docs:
		docno, x, y = doc.split(",")
		xs.append(int(x))
		
	if len(xs) == 0:
		return -1, -1
		
	return min(xs), max(xs)
j = Judge()

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

n = cur.execute("select datetime, userid, action, info from history where action in ('reset_visualization', 'automarquee_selection') and userid like 'vs%-%'")

for row in cur:
	datetime, userid, action, info = row
	system, userno, topic = userid.split("-")

	if userno < 28:
		continue

	if action == 'reset_visualization':
		metadata, pois, docs = info.split("\t")
		docs = docs.split(":")[1].split()
		minx, maxx = get_minmax(docs)


	if action == "automarquee_selection":
		loc, count, docs = info.split(" ", 2)
		loc = loc.split(":")[1]
		x, y, size = map(int, loc.split(","))
		count = count.split(":")[1]
		docs = docs.split(":")[1].strip().split()

		if minx != -1 and maxx != -1:
			viswidth = maxx - minx
			ratiox = float(x - minx) / viswidth
			if ratiox >= 0:
				print minx, maxx, x, ratiox