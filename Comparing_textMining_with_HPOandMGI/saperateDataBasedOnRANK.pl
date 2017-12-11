
use strict;
use warnings;
open (MYFILE1,'>>RANK1_ocu2.txt');
open (MYFILE2,'>>RANK2_ocu2.txt');
open (MYFILE3,'>>RANK4_ocu2.txt');
open (MYFILE4,'>>RANK6_ocu2.txt');
open (MYFILE5,'>>RANK8_ocu2.txt');
open (MYFILE6,'>>RANK10_ocu2.txt');
open (MYFILE7,'>>RANL12_ocu2.txt');
open (MYFILE8,'>>RANK14_ocu2.txt');


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


open IN, "uniqePair_ontologyBaseFrequancy+NPMI_rounded_restrictedToGS_sorted_Ranked.txt" or die "cannot open the ontology file";

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


 if( ($RANK >= 1) and ($occurence >= 2) ){
$pair1{$gene_sympthom}=$gene_sympthom;
}

 if( ($RANK >= 2) and ($occurence >= 2) ){
$pair2{$gene_sympthom}=$gene_sympthom;
}

 if( ($RANK >= 4) and ($occurence >= 2) ){
$pair3{$gene_sympthom}=$gene_sympthom;
}


 if( ($RANK >= 6) and ($occurence >= 2) ){
$pair4{$gene_sympthom}=$gene_sympthom;
}

 if( ($RANK >= 8) and ($occurence >= 2) ){
$pair5{$gene_sympthom}=$gene_sympthom;
}

 if( ($RANK >= 10) and ($occurence >= 2) ){
$pair6{$gene_sympthom}=$gene_sympthom;
}

 if( ($RANK >= 12) and ($occurence >= 2) ){
$pair7{$gene_sympthom}=$gene_sympthom;
}

 if( ($RANK >= 14) and ($occurence >= 2) ){
$pair8{$gene_sympthom}=$gene_sympthom;
}



}
close IN;



for $key (keys(%pair1))
{
print MYFILE1 $key."\n";
}

for $key (keys(%pair2))
{
print MYFILE2 $key."\n";
}


for $key (keys(%pair3))
{
print MYFILE3 $key."\n";
}

for $key (keys(%pair4))
{
print MYFILE4 $key."\n";
}

for $key (keys(%pair5))
{
print MYFILE5 $key."\n";
}

for $key (keys(%pair6))
{
print MYFILE6 $key."\n";
}

for $key (keys(%pair7))
{
print MYFILE7 $key."\n";
}

for $key (keys(%pair8))
{
print MYFILE8 $key."\n";
}

