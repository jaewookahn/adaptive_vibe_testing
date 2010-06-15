#!/usr/bin/python

import sys; sys.path.append("../common")
from tdt4rel import Judge
import MySQLdb, sys

j = Judge()

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

n = cur.execute("select * from history where userid like 'vs%' and action = 'open_doc'")

for row in cur:
	datetime, userid, obj, sessionid, action, info = row
	system, userno, topic = userid.split("-")
	print system, userno, topic, action, len(info.split("\t"))
