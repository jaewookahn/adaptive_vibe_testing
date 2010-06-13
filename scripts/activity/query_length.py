#!/usr/bin/python

import MySQLdb

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

cur.execute("select userid, info from history where action = 'search' and userid like 'vs%' and userid != 'vst'")

for row in cur:
	userid, info = row
	system, userno, topic = userid.split("-")
	query = info.split(":")[1]
	len_query = len(query.split())
	
	print system, userno, topic, len_query