


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
open IN, "uniqePair_ontologyBaseFrequancy+NPMI_rounded_restrictedToGS.txt" or die "cannot open the ontology file";

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
my $occurencePerArticle=$arr[3];
my $pmcid=$arr[4];
my $occurence = $arr[2];
my $NPMI=$arr[5];
$pair3{$gene_sympthom}=$gene_sympthom_name."@".$occurence."@".$occurencePerArticle."@".$pmcid."@".$NPMI;
#$pair1{$gene_sympthom}=$gene_sympthom;
}
close IN;

#for $key (keys(%pair1))
#{
#print $key."\t".$pair1{$key}."\n";
#}


open IN, "HP_supclass_name_parents.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $subclass = $arr[0];
my $parents=$arr[2];
$pair2{$subclass}=$parents;
    
}
close IN;



open IN, "MP_supclass_name_parents.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $subclass = $arr[0];
my $parents=$arr[2];
$pair2{$subclass}=$parents;

}
  close IN;


#for $key (keys(%pair2))
#{
#print $key."\t".$pair2{$key}."\n\n";
# }
my($n,$tmp,@arr3);
for $key (keys(%pair1))
{
	@arr=split('#', $key);
	$gene=$arr[0];
	$sympthom=$arr[1];
	#print "am a gene : ".$gene."\n";
	#print "am a sympthom : ".$sympthom."\n";

	if (exists $pair2{$sympthom})
	{#print "parent: ".$key."\t children: ".$pair2{$sympthom}."\n";
	 	@arr2=split('##',$pair2{$sympthom});#parents
		foreach my $n (@arr2){
			 $tmp=$gene."#".$n;	
	 		$pair3{$tmp}=$pair1{$key};
		
		}
}

}
for $key (keys(%pair3))
{
	 @arr=split('@',$pair3{$key});

	print $key."\t".$arr[0]."\t".$arr[1]."\t".$arr[2]."\t".$arr[3]."\t".$arr[4]."\t".$arr[5]."\n";

}
