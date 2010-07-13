#!/usr/bin/python

import sys; sys.path.append("../common")
from sysorder import get_order

f = open("../../data/note_precision_noerr.txt")
print f.readline().strip(), '"sysorder"'
for s in f:
	s = s.strip()
	temp = s.split()
	system = temp[1]
	userno = temp[2]

	print s,
	order = get_order(system[1:-1], int(userno))
	print order