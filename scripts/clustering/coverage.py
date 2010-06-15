#!/usr/bin/python

from clustering import get_clustering
# from tdt4rel import Judge
import MySQLdb

cl, cli = get_clustering()

# j = Judge()

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()


q = """
select userid, action, object, info from history where action in ('open_doc') and userid like 'vs%' and userid != 'vst' and userid not like '%-01-%' and userid not like '%-02-%' and userid not like '%-20-%' order by datetime asc
"""

cur.execute(q)
for row in cur:
	userid, action, docno, info = row
	
	if cli.has_key(docno):
		rc = cli[docno]
		system, docno, topicid = userid.split("-")
		print system, docno, topicid, rc.split(":")[1]