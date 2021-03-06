#!/usr/bin/python

import sys; sys.path.append("./common")
from dbconfig import *
from tdt4rel import Judge
import MySQLdb, sys

con = MySQLdb.connect(HOST, USER, PASS, DB)
cur = con.cursor()

N = cur.execute("select userid, action, info from history where action = 'reset_visualization' and userid like 'vs%-%'")

j = Judge()

recs = []
old_userid = ""

for i, row in enumerate(cur):
	userid, action, info = row
	dim, pois, docs = info.split("\t")
	system, userno, topicid = userid.split("-")
	dimx, dimy = dim.split(":")[1].split(" ")[0].split(",")
	docs = docs.strip().split(":")[1].split(" ")

	isum = 0
	for poi in pois.split():
		try:
			label, value = poi.split(",")
			if int(value) > 0:
				isum = 1
				break
		except:
			pass
			
	if old_userid != userid:
		recid = 1

	recid_full = "%s %s %s %s" % (system, userno, topicid, recid)
	if recid_full not in recs:
		recs.append(recid_full)

	for doc in docs:
		try:
			docno, docx, docy = doc.split(",")
		except:
			if doc == "":
				continue
			print ">>> Error in ", doc
			sys.exit(1)
			
		rel = j.check(topicid, docno)
		# rel = 1
		print system, userno, topicid, recid, dimx, dimy, docno, docx, docy, rel, isum
					
	recid += 1
	old_userid = userid
	
	sys.stderr.write("\r%d/%d" % (i, N))
	sys.stderr.flush()
			
for rec in recs:
	print "#", rec
