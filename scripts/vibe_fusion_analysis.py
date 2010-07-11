#!/usr/bin/python

import math

f = open("../data/vis_history.txt")

datapoints = {}
centroids = {}

for s in f:
	if s[0] == "#":
		continue

	system, userno, topicid, sessno, screenw, screenh, docno, x, y, rel = s.split()
	x = int(x); y = int(y); rel = int(rel)
	
	if userno in ['01', '02', '10','29']:
		continue
		
	sessionid = "%s-%s-%s-%s" % (system, userno, topicid, sessno)
	
	if datapoints.has_key(sessionid):
		datapoints[sessionid].append((x, y, rel))		
	else:
		datapoints[sessionid] = []
		
# centroid

for sessionid in datapoints.keys():
	points = datapoints[sessionid]
	
	rcx = []; rcy = []
	ncx = []; ncy = []
	
	for px, py, prel in points:
		
		if prel == 1:
			rcx.append(px)
			rcy.append(py)
			
		if prel == 0:
			ncx.append(px)
			ncy.append(py)

	
	if len(rcx) != 0:
		rcxv = sum(rcx) / len(rcx)
		rcyv = sum(rcy) / len(rcy)
		ncxv = sum(ncx) / len(ncx)
		ncyv = sum(ncy) / len(ncy)
		centroids[sessionid] = (rcxv, rcyv, ncxv, ncyv)
	else:
		centroids[sessionid] = (-1, -1, -1, -1)
	
# DB

def euclid(x1, y1, x2, y2):
	return math.sqrt((x1-x2)**2 + (y1-y2)**2)

def get_DB(sid, d, c):
		
	rdist = []
	ndist = []
	
	for x, y, rel in d[sid]:
		rx, ry, nx, ny = c[sid]
		# print x, y, rel, rx, ry, nx, ny
		
		if rel == 1:
			rdist.append(euclid(x, y, rx, ry))
			
		if rel == 0:
			ndist.append(euclid(x, y, nx, ny))
	DB_compact = (sum(rdist)/len(rdist) + sum(ndist)/len(ndist)) / 2
	DB_distance = euclid(rx,ry,nx,ny)
	DB = DB_compact / DB_distance

	return DB, DB_compact, DB_distance, rx, ry, nx, ny

print "sys userno topicid db dbcompact dbdistance crx cry cnx cny"

for sessionid in datapoints.keys():
	if centroids[sessionid][0] == -1:
		continue
	
	db, dbc, dbd, rx, ry, nx, ny = get_DB(sessionid, datapoints, centroids)
	system, userno, topicid, sessno = sessionid.split("-")
	print system, userno, topicid, db, dbc, dbd, rx, ry, nx, ny
	