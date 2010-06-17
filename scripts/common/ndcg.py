import math

def get_ndcg(rels):
	
	if len(rels) == 0:
		return 0.0
	
	ndcg = rels[0]
	for i, r in enumerate(rels[1:]):
		temp = float(r) / math.log(i+2,2)
		ndcg += temp
	return ndcg