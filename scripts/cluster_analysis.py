#!/usr/bin/python

import math

f = open("../data/vis_history.txt")

data = []
centroids = {}

oldvis = ""
rsumx = 0; rsumy = 0; nsumx = 0; nsumy = 0; rcount = 0; ncount = 0

for s in f:
	
	if s[0] == '#':
		break
	s = s.strip()
	
	system, userno, topicid, recid, dimx, dimy, docno, x, y, rel = s.split()
	data.append((system, userno, topicid, recid, dimx, dimy, docno, x, y, rel))

	viskey = "%s %s %s %s" % (system, userno, topicid, recid)

	if viskey != oldvis and oldvis != "":
		
		if rcount == 0:
			rcount = 0.000001
		
		if ncount == 0:
			ncount = 0.000001
		
		# print viskey, rsumx / rcount, rsumy / rcount, nsumx / ncount, nsumy / ncount
		centroids[viskey] = (rsumx / rcount, rsumy / rcount, nsumx / ncount, nsumy / ncount, rcount, ncount)

		rsumx = 0
		rsumy = 0
		nsumx = 0
		nsumy = 0
		rcount = 0
		ncount = 0
		

	if rel == '1':
		rsumx += int(x)
		rsumy += int(y)
		rcount += 1

	if rel == '0':
		nsumx += int(x)
		nsumy += int(y)
		ncount += 1

	oldvis = viskey
	
f.close()

def dist(x1, y1, x2, y2):
	return math.sqrt((int(x1)-int(x2))** 2 + (int(y1)-int(y2))**2)

for r in data:
	system, userno, topicid, recid, dimx, dimy, docno, x, y, rel = r
	viskey = "%s %s %s %s" % (system, userno, topicid, recid)
	
	try:
		centroid = centroids[viskey]
	except:
		continue
		
	if rel == 1:
		cent_dist = dist(x, y, centroid[0], centroid[1])
	else:
		cent_dist = dist(x, y, centroid[2], centroid[3])
		
		
	print system, userno, topicid, recid, dimx, dimy, docno, x, y, rel, cent_dist