#!/usr/bin/python

import MySQLdb

con = MySQLdb.connect('localhost', 'jahn', 'fkffk123', 'jahn')
cur = con.cursor()

cur.execute("delete from note_precision")

oldkey = ""
count = 0

f = open("../data/note_precision_um.txt")
for s in f:
	s = s.strip()
	noteid, system, userid, topicid, docno, prec, um = s.split()

	key = "%s %s %s" % (system, userid, topicid)
	
	if oldkey != key:
		count = 1

	# print noteid, system, userid, topicid, docno, prec, um, count
	q = "insert into note_precision values ('%s','%s','%s','%s','%s','%s','%s','%s')" % (noteid, system, userid, topicid, docno, prec, um, count)
	
	cur.execute(q)
	cur.execute("commit")
	
	count += 1
	oldkey = key