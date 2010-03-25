#!/usr/bin/python

f = open("user_notes.txt")

qcount = {"40009":7, "40048":8, "40021":12}

for s in f:
	s = s.strip()
	temp = s.split("\t")
	userid = temp[0]
	answers = temp[1:]
	
	temp2 = userid.split("-")
	if len(temp2) == 3:
		userno, topicid, system = temp2
	else:
		userno, topicid = temp2
		system = ''
	
	# print userno, topicid, system, answers

	for i in range(min(len(answers), qcount[topicid])):
		
		if answers[i] == '':
			continue

		for answer in answers[i].split(" "):
			print userno, topicid, i + 1, answer
