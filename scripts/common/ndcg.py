import math

# def get_ndcg(rels):
# 	
# 	if len(rels) == 0:
# 		return 0.0
# 	
# 	ndcg = rels[0]
# 	for i, r in enumerate(rels[1:]):
# 		temp = float(r) / math.log(i+2,2)
# 		ndcg += temp
# 	return ndcg
	
	
def get_ndcg(rels):
	if len(rels) == 0:
		return 0.0

	dcg = rels[0]
	for i, r in enumerate(rels[1:]):
		temp = float(r) / math.log(i+2,2)
		dcg += temp

	if dcg == 0:
		return 0.0

	irels = rels
	irels.sort()
	irels.reverse()
	idcg = irels[0]
	for i, r in enumerate(irels[1:]):
		temp = float(r) / math.log(i+2,2)
		idcg += temp

	return dcg/idcg	