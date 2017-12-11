sentenceExtarction2.pl
input : ( files in the output folder (160 annotated full text) saved in dragon shared folder)
output: result.txt (PMCID    PMID    uniprotID       geneName        symptomID       symptom         sentence )


uniqePairs.txt
contain ( uniprotID#phenotypeID  geneName#phnotypeName pmc#pm )



uniqPair2.pl
input : result.txt
output : uniqePair_frequancy.txt
