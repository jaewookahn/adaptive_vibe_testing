#!/usr/bin/python

import sys; sys.path.append("../common")
from sysorder import get_order

f = open("../../data/open_precision2-2.txt")

for s in f:
	s = s.strip()
	temp = s.split()
	system = temp[0]
	userno = temp[1]

	print s,
	order = get_order(system, int(userno))
	print order