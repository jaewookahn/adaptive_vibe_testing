#!/usr/bin/python

import MySQLdb

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

cur.execute("""
select * from history where userid like 'vs%-%'
and userid not like '%-01-%'
and userid not like '%-02-%'
and userid not like '%-10-%'
and userid not like '%-20-%'
and action = 'move_poi'
""")

for row in cur:
	datetime, userid, obj, sessid, action, info = row
	system, userno, topicid = userid.split("-")
	poi_type = info[-1]
	
	print system, userno, "move_poi", poi_type