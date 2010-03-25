#!/usr/bin/python

import MySQLdb, gdbm, os

class Judge(object):
	"""docstring for Judge"""
	def __init__(self):
		self.db = gdbm.open("/home/jahn/prj/ynfiltering_analysis/tkn_mttkn2/docno2fileid.gdbm", 'r')
		self.con = MySQLdb.connect('localhost', 'root', '!!berkeley', 'news')
		self.cur = self.con.cursor()
		
	def check(self, topic, docno):
		temp = self.db[docno].split()
		fileid_part = temp[0] + '_' + temp[1]
		q = "select * from news.highlights where groupid = 2 and topicid = '%s' and docid like '%%%s%%'" % (topic, fileid_part)
		q = "select * from `yournews-tdt4`.highlights1 where groupid = 2 and topicid = '%s' and docid like '%%%s%%RECID=%s'" % (topic, temp[0], temp[1])

		nrow = self.cur.execute(q)

		if nrow > 0:
			rel = 1	
		else:
			rel = 0
			
		return rel

	def check_annotation(self, topic, docno, text):
		judge_location = "/home/jahn/prj/annotation_precision/"
		source_location = "/tmp/annotation_precision_temp.txt"
		
		fp = open(source_location, 'w')
		fp.write("1 %s %s %s\n" % (topic, docno, text))
		fp.close()
		
		command = "java -jar %s/evaluatation.jar %s %s//groundtruth/ %s//tkn/ %s/mttkn2/ %s/mttkn2_tkn.txt" % (judge_location, source_location, judge_location, judge_location, judge_location, judge_location)
		p = os.popen(command)
		result = p.readlines()
		p.close()
		return result[3].split()
			
			
# j = Judge()
# print j.check_annotation('40001', 'APW20010120.2106.0705', 'Ten members of the U.S. Coast Guard\'s pollution response National Strike Force headed to the easternmost island Saturday equipped with specialized oil spill equipment such as high-capacity pumps and inflatable oil containment barges, the Coast Guard said. A coordinator from the National Oceanic and Atmospheric Administration was traveling with the team.')
