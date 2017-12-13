


use strict;


my ($line,@arr,@arr1,@arr2,$key,$sympthom,$gene);
our %pair1;
our %pair2;
our %pair3;
our %pair4;
%pair1=();
%pair2=();
%pair3=();
%pair4=();
open IN, "uniqePair_ontologyBaseFrequancy+NPMI_rounded.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $gene_sympthom = $arr[0];
my $gene_sympthom_name = $arr[1];
my $pmcid = $arr [4];
my $occurence=$arr[2];
my $occurence_perartical=$arr[3];
my $NPMI=$arr[5];
#if ($NPMI >= 0.80 && $NPMI < 0.90 ){
#print $gene_sympthom."\t". $occurence."\n";
$pair1{$gene_sympthom}=$occurence."#".$occurence_perartical;
#$pair4{$gene_sympthom}=$gene_sympthom_name."@".$pmcid;
#}
}
close IN;

#for $key (keys(%pair1))
#{
#print $key."\t".$pair1{$key}."\n";
#}





open IN, "HP_phenotype_uniprot2.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $phenotype = $arr[0];
my $uniprot=$arr[1];
$pair2{$phenotype}=$uniprot;
    
}
close IN;



open IN, "MP_phenotype_uniprot2.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);


my $phenotype = $arr[0];
my $uniprot=$arr[1];
$pair2{$phenotype}=$uniprot;

}
  close IN;

#print scalar(keys(%pair2))."\n";
#for $key (keys(%pair2))
#{
#print $key."\t".$pair2{$key}."\n";
#@arr=split('##', $pair2{$key});
#        foreach my $n (@arr){
#           print $key."\t".$n."\n"
 #}
#}
my($n,$tmp,@arr3,$phenotype);
my $TP=0;
my $FN=0;
for $key (keys(%pair1))
{
	@arr=split('#', $key);
	$gene=$arr[0];
	$phenotype=$arr[1];
	#print "am a gene : ".$gene."\n";
	#print "am a sympthom : ".$phenotype."\n";

	if (exists $pair2{$phenotype})
	{#print "gene: ".$key."\t uniprot: ".$pair2{$phenotype}."\n";
	 	@arr2=split('##',$pair2{$phenotype});#subclasses
		foreach my $n (@arr2){
			 if ($n eq $gene)
			{	
				if (!exists $pair3{$phenotype})
				{$pair3{$phenotype}=$gene;}
				else
				{$pair3{$phenotype}=$pair3{$phenotype}."##".$gene;}	
				$TP=$TP+1;
				#print $gene."\t".$n."\n";
				# print "matching pair  : ".$gene."#".$phenotype."\n";
			}
		}

	}


}

for $key (keys(%pair2))
{
	@arr=split('##',$pair2{$key});
	foreach my $n (@arr)
	{	my $tmp=$n."#".$key;
		if (! exists $pair1{$tmp})
		{ 
		   $FN=$FN+1;}
	}


}
print scalar (keys(%pair3))."\n";

print $TP."\t".$FN."\n";
#for $key (keys(%pair3))
#{
#	print $key."\t".$pair3{$key}."\n";

#}
