#!/usr/bin/python

import sys; sys.path.append('../common')
from tdt4rel import Judge
import MySQLdb, sys, bsddb

if len(sys.argv) != 3:
	print "%s system[vsb,vse,vsn,all] subjectid[number,all]" % sys.argv[0]
	sys.exit(1)

systemid = sys.argv[1]
subjectid = sys.argv[2]

if systemid == 'all':
	systemid = "vs_"

if subjectid == 'all':
	subjectid = '%'

j = Judge()

umtime = bsddb.btopen('../misc/umtime.bsddb', 'r')

f = open("master_notes.txt", "a")

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

n = cur.execute("select unix_timestamp(timestamp), nid, userid, docid, note from notes where userid like '%s-%s%%' and userid != 'vst' order by nid desc" % (systemid, subjectid)) 

counter = 1
res = []
for row in cur:
	time, nid, userid, docid, note = row

	system, user, topic = userid.split("-")
	
	note = note.replace("\r\n", " ")
	note = note.lower()
	
	precision = j.check_annotation(topic, docid, note)
	
	if umtime.has_key(userid):
		if time > int(umtime[userid]):
			um_vis = 1
		else:
			um_vis = 0
	else:
		um_vis = 0
	
	try:
		sys.stdout.write("%s %s %s %s %s %s %d\n" % (nid, system, user, topic, docid, precision[1], um_vis)) #, note
	except:
		sys.stdout.write("%s %s %s %s %s error %d\n" % (nid, system, user, topic, docid, um_vis))
	
#	sys.stderr.write("\r%d/%d" % (counter, n))
#	sys.stderr.flush()
	counter += 1

	res.append(float(precision[1]))

print sum(res)/len(res)


umtime.close()
