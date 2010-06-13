#!/usr/bin/python

import MySQLdb, bsddb

umtime = bsddb.btopen('umtime.bsddb', 'c')

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

cur.execute("select unix_timestamp(datetime), userid, action, object from history where userid like 'vs%' and  userid != 'vst' order by userid, datetime asc")

data = cur.fetchall()

um_on = 0
um_vis = 0

for i in range(len(data)):
	time, userid, action, docid = data[i]
	
	if action == 'login':
		um_on = 0
		um_vis = 0
		
	if action == 'save_note':
		um_on = 1
		
	if um_vis == 0 and um_on == 1 and (action in ['search', 'reset_visualization']):
		um_vis = 1
		print userid, time
		umtime[userid] = str(time)
		
umtime.close()