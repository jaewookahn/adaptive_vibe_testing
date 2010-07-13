#!/usr/bin/python

from sets import Set

f = open("../../data/note_precision_noerr.txt")
f.readline()


docnos = {'vsb':[], 'vse':[], 'vsn':[]}

for s in f:
	s = s.strip()
	temp, system, userno, topicid, qno, noteno, noteid, docno, p = s.split()
	docno = docno[1:-1]
	system = system[1:-1]
	p = float(p)
	
	if p<0.5:
		continue
	
	# print system, topicid, docno, p
	
	if docno not in docnos[system]:
		docnos[system].append(docno)
		
b = Set(docnos['vsb'])
e = Set(docnos['vse'])
n = Set(docnos['vsn'])

print len(b-e)
print len(e-b)
print len(b-n)
print len(n-b)
print
print len(b&e)
print len(b&n)