#!/usr/bin/python

def get_clustering():
	f = open('clusterings.txt')

	cl = {}
	cli = {}

	for s in f:
		s = s.strip()
		topicid, clusterid, docs = s.split(' ', 2)
		docs = docs.split()
	
		key = "%s:%s" % (topicid, clusterid)
		cl[key] = docs

		for doc in docs:
			if not cli.has_key(doc):
				cli[doc] = key
			else:
				print "error"


	return (cl, cli)