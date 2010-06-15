#!/usr/bin/python

import MySQLdb, gdbm

db = gdbm.open('/home/jahn/prj/yournews-tdt4/fileid2docno.gdbm', 'r')
# try db too?

TOPICID = '40021'
q = """
select distinct docid from news.highlights where groupid = 2 and topicid = '%s'
""" % TOPICID

con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'yournews-tdt4')
cur = con.cursor()
cur.execute(q)

docnos = []

for row in cur:
	docid, = row
	temp = docid.split("/")[2].split(".")[0]
	fileid = '%s %s' % (temp[:26], temp[27:])
	docno = db[fileid]
	docnos.append(docno)

terms = []
dv = {}

for docno in docnos:
	cur.execute("select * from dv where docid = '%s' and term not regexp '[0-9]+'" % docno)
	for row in cur:
		docno, term, tf, tfidf = row
		if term not in terms:
			terms.append(term)
		key = "%s:%s" % (docno, term)
		dv[key] = tf

# for docno in docnos:
# 	for term in terms:
# 		key = "%s:%s" % (docno, term)
# 		if not dv.has_key(key):
# 			print 0,
# 		else:
# 			print "%.3f" % dv[key],
# 	print

fdat = open('%s.dat' % TOPICID, 'w')
fterm = open('%s_voc.dat' % TOPICID, 'w')
fdocs = open("%s_doc.dat" % TOPICID, 'w')

for docno in docnos:
	tempstr = ""
	for termid, term in enumerate(terms):
		key = "%s:%s" % (docno, term)
		if dv.has_key(key):
			tempstr += "%d:%d " % (termid, dv[key])
	fdat.write("%d " % len(tempstr.strip().split()))
	fdat.write(tempstr)
	fdat.write("\n")
fdat.close()

for term in terms:
	fterm.write("%s\n" % term)
fterm.close()

for docno in docnos:
	fdocs.write(docno + "\n")
fdocs.close()