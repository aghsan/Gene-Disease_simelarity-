
use strict;
use warnings;

open (MYFILE2,'>>rank78_occ4_new2.txt');



my ($line,@arr,@arr1,@arr2,$key,$sympthom,$gene);
our %pair1;
our %pair2;
our %pair3;
our %pair4;
our %pair5;
our %pair6;
our %pair7;
our %pair8;


%pair1=();
%pair2=();
%pair3=();
%pair4=();
%pair5=();
%pair6=();
%pair7=();
%pair8=();


open IN, "uniqePair_ontologyBaseFrequancy+NPMI_rounded_restrictedToGS_sorted_Ranked2.txt" or die "cannot open the ontology file";

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
my $RANK=$arr[6];

 if (($RANK <= 78 ) and ($occurence >= 4)) {

$pair1{$gene_sympthom}=$gene_sympthom_name;
}




}
close IN;



open IN, "phenomenet.4validation.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;



$pair4{$line}=$line;


}
close IN;

for $key (keys(%pair1))
{
	@arr=split('#',$key);
	my $gene = $arr[0];
	my $sympthom = $arr[1];
	if (exists $pair4{$sympthom})
	{

	if (! exists $pair2{$gene})
	{ $pair2{$gene}=$gene."\t".$sympthom; }
	else
	{ $pair2{$gene}=$pair2{$gene}."\t".$sympthom; }
	}


}

for $key (keys(%pair2))
{
print MYFILE2 $pair2{$key}."\n";
}

