


use strict;


my ($n,$line,@arr,@arr1,@arr2,$key,$sympthom,$gene);
our %pair1;
our %pair2;
our %pair3;
our %pair4;
%pair1=();
%pair2=();
%pair3=();
%pair4=();


open IN, "uniqePair_ontologyBaseFrequancy+NPMI_rounded_restrictedToGS_sorted.txt" or die "cannot open the ontology file";

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

$pair1{$gene_sympthom}=$gene_sympthom_name."@".$occurence."@".$occurencePerArticle."@".$pmcid."@".$NPMI;

}
close IN;


my (@arr3,$key1, $key2);
my $count=1;
for $key (keys(%pair1))
{
	@arr=split('#',$key);
	$gene=$arr[0];
	if (! exists $pair4{$gene})
	{ $pair4{$gene}=$gene;
	#print "am gene ".$gene."\n";
	for $key1 (keys(%pair1)){
	@arr2=split('#',$key1);
        $n=$arr2[0];
        #print "am arr2[0] : ".$arr2[0]."\n";
	if ($n eq $gene)
	{	
		@arr1=split('@',$pair1{$key1});
		#$count++;
		my $data=$key1."@".$arr1[0]."@".$arr1[1]."@".$arr1[2]."@".$arr1[3]."@".$arr1[4];
		$pair2{$data}=$arr1[4];
		#print $key1."\t".$arr1[0]."\t".$arr1[1]."\t".$arr1[2]."\t".$arr1[3]."\t".$arr1[4]."\t".$arr1[5]."\t".$count."\n";
	}
	}
	my %pair3 = map {$count++ => $_} sort{$pair2{$b} <=> $pair2{$a}} keys %pair2;
	for $key2 (keys(%pair3)){
	@arr3=split('@',$pair3{$key2});
	print $arr3[0]."\t".$arr3[1]."\t".$arr3[2]."\t".$arr3[3]."\t".$arr3[4]."\t".$arr3[5]."\t".$key2."\n";

	 #print $key2."\t".$pair3{$key2}."\n";

	}
	}
	%pair2=();
	%pair3=();
	$count=1;
}











