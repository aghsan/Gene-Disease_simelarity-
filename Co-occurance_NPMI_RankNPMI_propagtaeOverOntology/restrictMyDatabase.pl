


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
open IN, "GoldStandaredPairs.txt " or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $gene = $arr[0];
my $sympthom =$arr[1];
$pair2{$gene}=$gene;
$pair1{$sympthom}=$sympthom;

}
close IN;

#for $key (keys(%pair1))
#{
#print $key."\t".$pair1{$key}."\n";
#}


print scalar (keys(%pair2))."\n";


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
my $occurencePerArticle=$arr[3];
my $pmcid=$arr[4];
my $occurence = $arr[2];
my $NPMI=$arr[5];

@arr=split('#', $gene_sympthom);
my $gene1=$arr[0];
my $sympthom1=$arr[1];

if (exists $pair2{$gene1} and exists $pair1{$sympthom1})
{
	$pair3{$gene_sympthom}=$gene_sympthom_name."@".$occurence."@".$occurencePerArticle."@".$pmcid."@".$NPMI;

}


}
close IN;


for $key (keys(%pair3))
{
	@arr=split('@',$pair3{$key});
	#print $key."\t".$arr[0]."\t".$arr[1]."\t".$arr[2]."\t".$arr[3]."\t".$arr[4]."\t".$arr[5]."\n";


}
















