#!/usr/bin/python

from dbconfig import *
from tdt4rel import Judge
import MySQLdb, sys

con = MySQLdb.connect(HOST, USER, PASS, DB)
cur = con.cursor()

cur.execute("select userid, action, info from history where action = 'reset_visualization'")

j = Judge()

recs = []
old_userid = ""

for row in cur:
	userid, action, info = row
	dim, pois, docs = info.split("\t")
	system, userno, topicid = userid.split("-")
	dimx, dimy = dim.split(":")[1].split(" ")[0].split(",")
	docs = docs.strip().split(":")[1].split(" ")

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
		print system, userno, topicid, recid, dimx, dimy, docno, docx, docy, rel
					
	recid += 1
	old_userid = userid
			
for rec in recs:
	print "#", rec
