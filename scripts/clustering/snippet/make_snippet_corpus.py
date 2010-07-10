#!/usr/bin/python

import MySQLdb, gdbm

TOPICID = 40021

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

db = gdbm.open('/home/jahn/prj/yournews-tdt4/fileid2docno.gdbm', 'r')
# fg = open('corpus-%d/gt.txt' % TOPICID, 'w')
# fn = open('corpus-%d/notes.txt' % TOPICID, 'w')

fa = open('corpus-%d/data.txt' % TOPICID, 'w')

counter = 1
q = """
select docid, selected_text from news.highlights where groupid = 2 and topicid = '%s'
""" % TOPICID	
N = cur.execute(q)

for row in cur:
	docid, selected_text = row
		
	temp = docid.split("/")[2].split(".")[0]
	fileid = '%s %s' % (temp[:26], temp[27:])
	docno = db[fileid]
	
	fa.write("""
<DOC>
<DOCNO>GT-%d</DOCNO>
<TEXT>
%s
</TEXT>
</DOC>
"""% (counter, selected_text))

	counter += 1
		
f = open("../../../data/user_notes_annotated.txt")
f.readline()
for s in f:
	sys, userno, topicid, qno, noteno, noteid, docno, p = s.strip().split()
	if int(topicid) == TOPICID and float(p) >= 1.0:
		cur.execute("select note from notes where nid = '%s'" % noteid)
		note, = cur.fetchone()
		fa.write("""
<DOC>
<DOCNO>NOTE-%s-%s-%d</DOCNO>
<TEXT>
%s
</TEXT>
</DOC>
""" % (sys, userno, counter, note))
		counter += 1
			
# fg.close()
# fn.close()
fa.close()