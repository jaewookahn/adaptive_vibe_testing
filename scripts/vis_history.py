#!/usr/bin/python

from dbconfig import *
from tdt4rel import Judge
import MySQLdb, sys

con = MySQLdb.connect(HOST, USER, PASS, DB)
cur = con.cursor()

cur.execute("select userid, action, info from history where action = 'reset_visualization'")

j = Judge()

for row in cur:
	userid, action, info = row
	dim, pois, docs = info.split("\t")
	system, userno, topicid = userid.split("-")
	dimx, dimy = dim.split(":")[1].split(" ")[0].split(",")
	docs = docs.strip().split(":")[1].split(" ")

	for doc in docs:
		try:
			docno, docx, docy = doc.split(",")
		except:
			if doc == "":
				continue
			print ">>> Error in ", doc
			sys.exit(1)
			
		rel = j.check(topicid, docno)
		print system, userno, topicid, dimx, dimy, docno, docx, docy, rel