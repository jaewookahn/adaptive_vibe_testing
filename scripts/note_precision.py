#!/usr/bin/python

from tdt4rel import Judge
import MySQLdb, sys

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

f = open("master_notes.txt", "a")

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

n = cur.execute("select nid, userid, docid, note from notes where userid like '%s-%s%%' and userid != 'vst' order by nid desc" % (systemid, subjectid)) 

counter = 1
res = []
for row in cur:
	nid, userid, docid, note = row

	system, user, topic = userid.split("-")
	
	note = note.replace("\r\n", " ")
	note = note.lower()
	
	precision = j.check_annotation(topic, docid, note)
	try:
		sys.stdout.write("%s %s %s %s %s %s\n" % (nid, system, user, topic, docid, precision[1])) #, note
	except:
		sys.stdout.write("%s %s %s %s %s error\n" % (nid, system, user, topic, docid))
	
#	sys.stderr.write("\r%d/%d" % (counter, n))
#	sys.stderr.flush()
	counter += 1

	res.append(float(precision[1]))

print sum(res)/len(res)
