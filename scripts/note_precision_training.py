#!/usr/bin/python

from tdt4rel import Judge
import MySQLdb, sys

system = 'training'
user = 'training'
topic = '40004'
j = Judge()

f = open("master_notes.txt", "a")

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

n = cur.execute("select nid, userid, docid, note from notes where userid = 'vst' order by nid desc" ) 

counter = 1
res = []
for row in cur:
	nid, userid, docid, note = row

	note = note.replace("\r\n", " ")
	note = note.lower()
	
	precision = j.check_annotation('40004', docid, note)
	try:
		sys.stdout.write("%s %s %s %s %s %s\n" % (nid, system, user, topic, docid, precision[1])) #, note
	except:
		sys.stdout.write("%s %s %s %s %s error\n" % (nid, system, user, topic, docid))
	
#	sys.stderr.write("\r%d/%d" % (counter, n))
#	sys.stderr.flush()
	counter += 1

	res.append(float(precision[1]))

print sum(res)/len(res)
