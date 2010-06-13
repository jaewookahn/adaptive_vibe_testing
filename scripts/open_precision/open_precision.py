#!/usr/bin/python
import sys; sys.path.append("../common")
from tdt4rel import Judge
import MySQLdb

j = Judge()

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

cur.execute("select userid, object from history where action like 'open_doc%' and userid like 'vs%' and  userid != 'vst'")

for row in cur:
	userid, docid = row
	system, user, topic = userid.split("-")
	print system,  user, topic, docid, j.check(topic, docid)
