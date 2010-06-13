#!/usr/bin/python

import sys; sys.path.append("../common")
from tdt4rel import Judge
import MySQLdb

j = Judge()

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()


q = """
select userid, action, object, info from history where action in ('open_doc', 'reset_visualization', 'response', 'save_note') and userid like 'vs%' and  userid != 'vst' order by datetime asc
"""

cur.execute(q)
page = 1
for row in cur:
	userid, action, obj, info = row
	system, userno, topicid = userid.split("-")
	
	if action == 'nav_page':
		page = int(info.split("=")[1])
		
	if action == 'search': # reset page <= check again
		page = 1
	
	if system == 'vsb' and action == 'response':
		docinfo = {}
		docs = info.split()[2:]
		for rank, docno in enumerate(docs):
			docinfo[docno] = 10 * (page - 1) + rank + 1
		
	if (system == 'vse' or system == 'vsn') and action == 'reset_visualization':
		docinfo = {}
		docs = info.split('\t')[2].split(":")[1].split(" ")
		for rank, docno in enumerate(docs):
			docinfo[docno.split(",")[0]] = rank + 1
			
	if action == 'open_doc':
		print system, "open_doc", userno, obj,
		print j.check(topicid, obj),
		if docinfo.has_key(obj):
			print docinfo[obj]
		else:
			print "-1"
			
	if action == 'save_note':
		save_docno = info.split()[0].split("=")[1]
		print system, "save_note", userno, save_docno,
		print j.check(topicid, save_docno),
		print docinfo[save_docno]