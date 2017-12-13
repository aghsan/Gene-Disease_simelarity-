use strict;

my ($line, @arr, @patients, @pathogens, @results, $i, $j, $size, @tmp, @pathogens_disease, @patients_disease);


open IN, "/home/alahas0a/Documents/DRwork/semanticsemalarity/TM_gene_phenotype_rank2_new.txt" or die "cannot open pathogens file"; #FIRST FILE

while ($line=<IN>)

{
chop $line;
@arr=split('\t', $line);
@tmp=split('##', $arr[0]);
push (@pathogens, $tmp[0]);
push (@pathogens_disease, $tmp[1]);
}

close IN;


open IN, "/home/alahas0a/Documents/DRwork/semanticsemalarity/OMIM_desise_phenotype.txt" or die "cannot open patienet file"; #SECOND FILE
#11002__IPNV##DOID_26__Pancreas Disease

while ($line=<IN>)

{
chop $line;
@arr=split('\t', $line);
@tmp=split('##', $arr[0]);
push (@patients, $tmp[0]);
push (@patients_disease, $tmp[1]);
}
close IN;


open IN, "/home/alahas0a/Documents/DRwork/semanticsemalarity/output/semanticResult_rank2_new.txt" or die "cannot open groovy output file"; #sim_taxon_pathogen_pathogen.txt
while ($line=<IN>)
{chop $line; push (@results, $line);}

close IN;


$size = @pathogens;


for ($i=0; $i<=$#patients; $i++)
{

  for ($j=0; $j<=$#pathogens; $j++)
   {
    if ($patients[$i] ne $pathogens[$j] ) #this is for pathogen_pathogen similarity, remove this for patient-pathogen similarity.
        {print $pathogens[$j]."\t".$patients[$i]."\t". $results[($i*$size)+$j]."\n";
}

   }
 

}
