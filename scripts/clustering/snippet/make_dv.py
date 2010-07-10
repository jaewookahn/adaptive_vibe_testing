#!/usr/bin/python

import os, bsddb, string, sys

if len(sys.argv) < 3:
	"Usage: command TOPICID MODE[db,gt,notes,all]"
	sys.exit(1)

TOPICID = int(sys.argv[1])
MODE = sys.argv[2]

if MODE == 'db':
	NEW_DV = True
else:
	NEW_DV = False
	
gt_count = {40009:534, 40021:1454, 40048:733}

#
# build dv db

fp = os.popen("dumpindex index-%d s" % TOPICID)
doccount = int(fp.readlines()[1].split(":")[1].strip())
fp.close()

if NEW_DV:
	dv = bsddb.btopen("dv-%d.bsddb" % TOPICID, 'c')

	for i in range(1, doccount + 1):
		sys.stdout.write("\r%d/%d" % (i, doccount))
		sys.stdout.flush()
		fp = os.popen("dumpindex index-%d dv %d" % (TOPICID, i))
		dopass = True
		for s in fp:
			if s.startswith("--- Terms ---"):
				dopass = False
				continue
			if dopass:
				continue

			v1, v2, term = s.strip().split()
			if term == '[OOV]':
				continue
			
			key = "%d:%s" % (i, term)
			if dv.has_key(key):
				dv[key] = str(int(dv[key]) + 1)
			else:
				dv[key] = "1"

	dv.close()
	sys.exit(0)
	
#
# read term id from the indri index
	
dv = bsddb.btopen('dv-%d.bsddb' % TOPICID, 'r')

fp = os.popen("dumpindex index-%d v" % TOPICID)
fp.readline()

terms = {}
for i, s in enumerate(fp):
	term, temp, temp = s.split()
	terms[term] = i
fp.close()

# all
if MODE == 'all':
	start = 1
	end = doccount + 1

# gt only
if MODE == 'gt':
	start = 1
	end = gt_count[TOPICID] + 1

# note only
if MODE == 'notes':
	start = gt_count[TOPICID] + 1
	end = doccount + 1

for i in range(start, end):
	line = []
	for term in terms.keys():
		key = "%d:%s" % (i, term)
		if dv.has_key(key):
			line.append("%d:%s" % (terms[term], dv[key]))

	if len(line) > 0:
		print len(line), string.join(line, ' ')