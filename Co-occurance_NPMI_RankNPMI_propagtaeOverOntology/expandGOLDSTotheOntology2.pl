


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
open IN, "HP_phenotype_uniprot_modified2.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

#my $hp_enterz = $arr[0];
#my $uniprot = $arr[1];
#$pair1{$hp_enterz}=$uniprot;
}
close IN;

#for $key (keys(%pair1))
#{
#print $key."\t".$pair1{$key}."\n";
#}
open IN, "MP_phenotype_uniprot_modified2.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

#my $mp_MGI = $arr[0];
#my $uniprot = $arr[1];
#$pair1{$mp_MGI}=$uniprot;
}
close IN;

open IN, "Gold.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $sympthom_ID = $arr[1];
my $uniprot = $arr[0];
$pair1{$sympthom_ID}=$uniprot;
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
	#@arr=split('#', $key);
	#$gene=$arr[1];
	#$sympthom=$arr[0];
	#print "am a gene : ".$gene."\n";
	#print "am a sympthom : ".$sympthom."\n";

	if (exists $pair2{$key})
	{#print "parent: ".$key."\t children: ".$pair2{$sympthom}."\n";
	 	@arr2=split('##',$pair2{$key});#parents
		foreach my $n (@arr2){
			 $tmp=$n."#".$gene	
	 		$pair3{$key}=$n;
		
		}
	$pair3{$key}=$pair1{$key};
}

}
for $key (keys(%pair3))
{
	 #@arr3=split('#',$pair3{$key});
	 #@arr=split ('@',$pair4{$key});

	print $key."\t".$pair3{$key}."\n";
}
