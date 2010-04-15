#!/usr/bin/python

from tdt4rel import Judge
import MySQLdb

def get_next_action(data, i):
	step = 1
	while 1:
		action = data[i + step][2]
		if action not in ['focus_doc', 'select_doc']:
			return (data[i + step][0], action)
		
		step += 1

j = Judge()

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()

cur.execute("select unix_timestamp(datetime), userid, action, object from history where userid like 'vs%' and  userid != 'vst' order by userid, datetime asc")

data = cur.fetchall()

um_on = 0
um_vis = 0

for i in range(len(data)):
	time, userid, action, docid = data[i]
	
	if action == 'open_doc':
		system, user, topic = userid.split("-")
		
		next_time, next_action = get_next_action(data, i)
		
		# print "%s %s %s %s %d time_span:%d action:%s um_on:%d um_vis:%d" % (system, user, topic, docid, j.check(topic, docid), next_time - time, next_action, um_on, um_vis)
		print "%s %s %s %s %d %d %s %d %d" % (system, user, topic, docid, j.check(topic, docid), next_time - time, next_action, um_on, um_vis)

	if action == 'login':
		um_on = 0
		um_vis = 0
		
	if action == 'save_note':
		um_on = 1
		
	if um_on == 1 and (action in ['search', 'reset_visualization']):
		um_vis = 1