import MySQLdb
import gdbm

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

		nrow = self.cur.execute(q)

		if nrow > 0:
			rel = 1	
		else:
			rel = 0
			
		return rel


