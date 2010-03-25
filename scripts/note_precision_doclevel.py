#!/usr/bin/python

from tdt4rel import Judge
import MySQLdb

j = Judge()

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

cur.execute("select userid, docid from notes where userid like 'vs%' and userid != 'vst'")

for row in cur:
	userid, docid = row
	system, user, topic = userid.split("-")
	print system,  user, topic, docid, j.check(topic, docid)
