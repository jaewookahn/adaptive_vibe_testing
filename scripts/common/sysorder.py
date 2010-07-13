#!/usr/bin/python

d="""1	ben
2	enb
3	nbe
4	ben
5	enb
6	nbe
7	ben
8	enb
9	nbe
10	ben
11	enb
12	nbe
13	ben
14	enb
15	nbe
16	ben
17	enb
18	nbe
19	ben
20	enb
21	nbe
22	ben
23	enb
24	nbe
25	ben
26	enb
27	nbe
28	ben
29	enb
30	nbe
31	ben
32	enb
33	nbe
34	ben
35	enb
36	nbe
37	ben
38	enb"""

dd = {}
for s in d.split("\n"):
	userno, ls = s.split()
	dd[userno] = ls
	
def get_order(system, userno):
	ls = dd["%s" % userno]
	return ls.index(system[-1]) + 1
	
if __name__ == '__main__':
	print get_order('vsb', 12)
