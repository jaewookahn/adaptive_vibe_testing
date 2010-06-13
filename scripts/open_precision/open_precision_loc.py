#!/usr/bin/python

from tdt4rel import Judge
import MySQLdb
import sys
j = Judge()

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

N=cur.execute("select datetime, userid, action, object, info from history where ((action like 'open_doc%' and info = 'from_VIBE') or action like 'reset_visualization%') and userid like 'vs%' and  userid != 'vst' order by datetime")

for row in cur:
	datetime, userid, action, docno, info = row

	system, user, topic = userid.split("-")
	
	if action.startswith('reset_visualization')	:
		
		vis = {}
		visx = []
		
		dim = info.split("\t")[0]
		docs = info.split("\t")[2]
		
		if len(docs) == 5:
			continue
		
		for doc in docs.split():
			temp = doc.split(",")
			docid = temp[0]
	
			locx = temp[1]
			locy = temp[2]
			
			vis[docid] = (locx, locy)
			visx.append(int(locx))
			
	if action.startswith('open_doc'):
		print userid, info, docno,

		print j.check(topic, docno),
		try:
			docx = int(vis[docno][0])
			vis_width = max(visx) - min(visx)
			docx_within = docx - min(visx)
			# print docx, vis_width , docx_within, float(docx_within) / vis_width, max(visx), min(visx)
			print docx, float(docx_within) / vis_width
		except:
			print -1, -1
			
			