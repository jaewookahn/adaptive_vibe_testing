#!/usr/bin/python

import MySQLdb, sys
from tdt4rel import Judge

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

def get_note(system, userno, topicid, note_no):
	cur.execute("select nid, docid, note from notes where userid = '%s-%s-%s' order by nid asc" % (system, userno, topicid))
	nid, docid, note = cur.fetchall()[int(note_no) - 1]
	return (nid, docid, note)

j = Judge()

f = open("user_notes_cleaned.txt")

for s in f:
	s = s.strip()
	system, userno, topicid, q, note_no = s.split()
	
	## remove qustion mark
	if note_no[-1] == '?' or note_no[-1] == '!':
		note_no = note_no[:-1]
	
	if note_no == '':
		continue
		
	print system, userno, topicid, q, note_no, 
	nid, docid, note = get_note(system, userno, topicid, note_no)
	
	note = note.replace("\r\n", " ")
	note = note.lower()
	
	prec = j.check_annotation(topicid, docid, note)	
	
	print nid, docid, prec[1]