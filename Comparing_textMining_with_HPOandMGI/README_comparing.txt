
saperateMyDataBasedOnNPMI.pl
take my big file as input 
and produce 8 different output NPMI0.#_occ#.txt

expandmYdatabaseTotheOntology 
take the 8 files from previous
and expand each file with the HP and MP ontologys

compare_databases3.pl
take expandGoldS_twocolumns.txt 
and the 8 files produce Fscores
output : TP , FP , FN and Fscore


rankingNPMI.pl
take input 
 uniqePair_ontologyBaseFrequancy+NPMI_rounded_restrictedToGS_sorted.txt
output

uniqePair_ontologyBaseFrequancy+NPMI_rounded_restrictedToGS_sorted_Ranked.txt

saperateMyDataBasedOnRANK.pl
take my big file as input 
and produce 8 different output RANK0.#_occ#.txt

compare_databases3_RANK.pl
expandGoldHP+MP_restricted2.txt 
and the 8 files produce Fscores
output : TP , FP , FN and Fscore
