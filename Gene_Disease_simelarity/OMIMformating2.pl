
use strict;
use warnings;

#open (MYFILE2,'>>NPMI0.2_occ5_valedated.txt');



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

open IN, "phenomenet.4validation2.txt" or die "cannot open the ontology file";

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


open IN, "OMIM_phenotype_annotation.tab" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);
my $s ="OMIM";
my $de = $arr[0];
my $id = $arr[1];
my $phenotype = $arr[4];
my $de_id=$de."_".$id;
if($de eq $s)
{
if (exists $pair4{$phenotype})
{
	if (! exists $pair1{$de_id})
        { $pair1{$de_id}=$de_id."\t".$phenotype; }
        else
        { $pair1{$de_id}=$pair1{$de_id}."\t".$phenotype; }

}

}
}

close IN;

#for $key (keys(%pair1)){
#print $key."\t".$pair1{$key}."\n";
#}

for $key (keys(%pair1))
{
print $pair1{$key}."\n";
#print MYFILE2 $pair2{$key}."\n";
}

