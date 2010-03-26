#!/usr/bin/python

import MySQLdb

con = MySQLdb.connect('localhost', 'jahn', 'rksekfvm', 'jahn')
cur = con.cursor()

### history table ###

cur.execute("drop table if exists history")
cur.execute('create table history select * from `yournews-tdt4`.history')
cur.execute('commit')

cur.execute("delete from history where userid = 'vst'")

cur.execute("delete from history where userid not like 'vs%'")

cur.execute("delete from history where userid not like '%-40009' and userid not like '%-40048' and userid not like '%-40021';")

cur.execute("commit")

### notes table ###

cur.execute("drop table if exists notes")
cur.execute('create table notes select * from `yournews-tdt4`.notes')
cur.execute('commit')

cur.execute("delete from notes where userid = 'vst'")
cur.execute("commit")

cur.execute("delete from notes where userid not like 'vs%'")

cur.execute("delete from notes where userid not like '%-40009' and userid not like '%-40048' and userid not like '%-40021';")

cur.execute("commit")
