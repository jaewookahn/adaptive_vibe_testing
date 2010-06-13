#!/usr/bin/python

import MySQLdb

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

cur.execute("select unix_timestamp(datetime), userid, info from history where action = 'reset_visualization' and userid like 'vs%' and userid != 'vst'")

for row in cur:
	
	datetime, userid, info = row
	print datetime, userid, info