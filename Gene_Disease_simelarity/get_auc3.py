import pdb
import numpy as np
from sklearn.metrics import auc
import matplotlib.pyplot as plt
from sklearn.metrics import roc_curve, auc



def negcum(rank_vec):
	rank_vec_cum = []
	prev = 0
	for x in rank_vec:
		if x == 0:
			x = x+1
			prev = prev + x
			rank_vec_cum.append(prev)
		else:
			rank_vec_cum.append(prev)
	rank_vec_cum = np.array(rank_vec_cum)
	return rank_vec_cum



sim_scores = np.loadtxt('/home/alahas0a/Documents/DRwork/semanticsemalarity/output/semanticResult_rank2.txt', dtype = 'float32')
pathogens = np.genfromtxt('Disease3.txt', dtype = 'str')
proteins = np.genfromtxt('unioprotID_rank2_uniqe.txt', dtype = 'str')


pathogens_proteins = {}
with open('restrectedMapped_uniprotOMIM_uniqe_lastone.txt') as f:
	for line in f:
		items = line.strip().split()
		prot = items[0]
		pathogen = items[1]

		if pathogen in pathogens_proteins:
		   	pathogens_proteins[pathogen].append(prot)
		else:
			pathogens_proteins[pathogen] = [prot]

disease_genes4bin = {}


# reshape sim scores into nxm where n are genes and m are diseases
sim_mat = sim_scores.reshape((len(proteins),len(pathogens)))
sim_mat = sim_mat.T 


sim_dict = dict()
for i,dis in enumerate(pathogens):
	sim_dict[dis] = sim_mat[i]



label_mat = dict()
for dis in sim_dict:
	if dis in pathogens_proteins:
		assoc_genes = pathogens_proteins[dis]
		s1 = list(set(assoc_genes))
		s1 = filter(None, s1)
		s2 = set(proteins)

		if set(s1).intersection(s2):
			phenomNet_sim = sim_dict[dis]
			sort_similarity_arg = np.argsort(phenomNet_sim)[::-1]
			sort_gene = [proteins[arg] for arg in sort_similarity_arg]
			label_vec = [0]*len(sort_gene)
			for gene in s1:
				if gene in sort_gene:
					label_vec[sort_gene.index(gene)] = 1
					# print 'pathogen: '+dis + ' protein '+gene+' ranked at:' + str(sort_gene.index(gene))
			label_mat[dis] = label_vec
			disease_genes4bin[dis] = list(s1)

array_tp = np.zeros((len(label_mat), len(proteins)),dtype='float32')
array_fp = np.zeros((len(label_mat), len(proteins)), dtype = 'float32')

for i,row in enumerate(label_mat.values()):
	elem = np.asarray(row, dtype='float32')
	tpcum = np.cumsum(elem)
	fpcum = negcum(elem)  	
	array_tp[i] = tpcum
	array_fp[i] = fpcum	


#compute fpr and tpr Rob's way 
tpsum = np.sum(array_tp, axis = 0)
fpsum = np.sum(array_fp, axis = 0)
tpr_r = tpsum/max(tpsum)
fpr_r = fpsum/max(fpsum)
auc_data2 = np.c_[fpr_r, tpr_r]
print('Number of disease: {}'.format(len(label_mat)))
print('Number of genes: {}'.format(len(proteins)))
print('auc all associations {}'.format(auc(fpr_r, tpr_r)))

plt.plot(fpr_r,tpr_r ,label = '(AUC={0:.3})'.format(auc(fpr_r,tpr_r)))

plt.legend(loc = 'lower right')

plt.ylim(0,1)
plt.plot([0,1],[0,1],'r--')
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')
plt.title('Disease-Gene-Association')
plt.savefig('auc_rank2.png')

