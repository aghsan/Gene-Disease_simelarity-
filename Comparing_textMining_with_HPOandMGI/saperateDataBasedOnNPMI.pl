
use strict;
use warnings;
open (MYFILE1,'>>NPMI0.1.txt');
open (MYFILE2,'>>NPMI0.2.txt');
open (MYFILE3,'>>NPMI0.3.txt');
open (MYFILE4,'>>NPMI0.4.txt');
open (MYFILE5,'>>NPMI0.5.txt');
open (MYFILE6,'>>NPMI0.6.txt');
open (MYFILE7,'>>NPMI0.7.txt');
open (MYFILE8,'>>NPMI0.8.txt');


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
my $pmcid = $arr [4];
my $occurence=$arr[2];
my $occurence_perartical=$arr[3];
my $NPMI=$arr[5];


 if ($NPMI >= 0.1) {
$pair1{$gene_sympthom}=$gene_sympthom;
}

 if ($NPMI >= 0.2) {
$pair2{$gene_sympthom}=$gene_sympthom;
}

 if ($NPMI >= 0.3) {
$pair3{$gene_sympthom}=$gene_sympthom;
}

 if ($NPMI >= 0.4) {
$pair4{$gene_sympthom}=$gene_sympthom;
}

 if ($NPMI >= 0.5) {
$pair5{$gene_sympthom}=$gene_sympthom;
}

 if ($NPMI >= 0.6) {
$pair6{$gene_sympthom}=$gene_sympthom;
}

 if ($NPMI >= 0.7) {
$pair7{$gene_sympthom}=$gene_sympthom;
}

 if ($NPMI >= 0.8) {
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

