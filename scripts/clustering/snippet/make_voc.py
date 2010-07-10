#!/usr/bin/python

import os

TOPICID = 40021

#
# read term id from the indri index
	
fp = os.popen("dumpindex index-%d v" % TOPICID)
fp.readline()

terms = {}
for i, s in enumerate(fp):
	term, temp, temp = s.split()
	print term

fp.close()

