


use strict;
use warnings;

open (MYFILE1,'>>expandedRANK1_ocu2.txt');
open (MYFILE2,'>>expandedRANK2_ocu2.txt');
open (MYFILE3,'>>expandedRANK4_ocu2.txt');
open (MYFILE4,'>>expandedRANK6_ocu2.txt');
open (MYFILE5,'>>expandedRANK8_ocu2.txt');
open (MYFILE6,'>>expandedRANK10_ocu2.txt');
open (MYFILE7,'>>expandedRANK12_ocu2.txt');
open (MYFILE8,'>>expandedRANK14_ocu2.txt');





my ($line,@arr,@arr1,@arr2,$key,$sympthom,$gene);
our %pair1;
our %pair2;
our %pair3;
our %pair4;
our %pair5;
our %pair6;
our %pair7;
our %pair8;
our %pair;
our %pair11;
our %pair22;
our %pair33;
our %pair44;
our %pair55;
our %pair66;
our %pair77;
our %pair88;

%pair1=();
%pair2=();
%pair3=();
%pair4=();
%pair5=();
%pair6=();
%pair7=();
%pair8=();
%pair=();
%pair11=();
%pair22=();
%pair33=();
%pair44=();
%pair55=();
%pair66=();
%pair77=();
%pair88=();

open IN, "RANK1_ocu2.txt" or die "cannot open the ontology file";

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
$pair1{$gene_sympthom}=$gene_sympthom
}
close IN;


open IN, "RANK2_ocu2.txt" or die "cannot open the ontology file";

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
$pair2{$gene_sympthom}=$gene_sympthom
}
close IN;


open IN, "RANK4_ocu2.txt" or die "cannot open the ontology file";

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
$pair3{$gene_sympthom}=$gene_sympthom
}
close IN;



open IN, "RANK6_ocu2.txt" or die "cannot open the ontology file";

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
$pair4{$gene_sympthom}=$gene_sympthom
}
close IN;



open IN, "RANK8_ocu2.txt" or die "cannot open the ontology file";

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
$pair5{$gene_sympthom}=$gene_sympthom
}
close IN;



open IN, "RANK10_ocu2.txt" or die "cannot open the ontology file";

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
$pair6{$gene_sympthom}=$gene_sympthom
}
close IN;

open IN, "RANL12_ocu2.txt" or die "cannot open the ontology file";

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
$pair7{$gene_sympthom}=$gene_sympthom
}
close IN;

open IN, "RANK14_ocu2.txt" or die "cannot open the ontology file";

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
$pair8{$gene_sympthom}=$gene_sympthom
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

my $subclass=$arr[0];
my $parents=$arr[2];
$pair{$subclass}=$parents;
    
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

my $subclass =$arr[0];
my $parents=$arr[2];
$pair{$subclass}=$parents;

}
  close IN;


#for $key (keys(%pair))
#{
#print $key."\t".$pair{$key}."\n\n";
# }
my($n,$tmp,@arr3);
for $key (keys(%pair1))
{
	@arr=split('#', $key);
	$gene=$arr[0];
	$sympthom=$arr[1];
	if (exists $pair{$sympthom})
	{
	 	@arr2=split('##',$pair{$sympthom});#parents
		foreach my $n (@arr2){
			 $tmp=$gene."#".$n;	
	 		$pair11{$tmp}=$tmp;
		
		}
}
	$pair11{$key}=$key;
}


for $key (keys(%pair2))
{
        @arr=split('#', $key);
        $gene=$arr[0];
        $sympthom=$arr[1];
        if (exists $pair{$sympthom})
        {
                @arr2=split('##',$pair{$sympthom});#parents
                foreach my $n (@arr2){
                         $tmp=$gene."#".$n;
                        $pair22{$tmp}=$tmp;

                }
}
	$pair22{$key}=$key;
}


for $key (keys(%pair3))
{
        @arr=split('#', $key);
        $gene=$arr[0];
        $sympthom=$arr[1];
        if (exists $pair{$sympthom})
        {
                @arr2=split('##',$pair{$sympthom});#parents
                foreach my $n (@arr2){
                         $tmp=$gene."#".$n;
                        $pair33{$tmp}=$tmp;

                }
}
	$pair33{$key}=$key;
}


for $key (keys(%pair4))
{
        @arr=split('#', $key);
        $gene=$arr[0];
        $sympthom=$arr[1];
        if (exists $pair{$sympthom})
        {
                @arr2=split('##',$pair{$sympthom});#parents
                foreach my $n (@arr2){
                         $tmp=$gene."#".$n;
                        $pair44{$tmp}=$tmp;

                }
}
	$pair44{$key}=$key;	
}


for $key (keys(%pair5))
{
        @arr=split('#', $key);
        $gene=$arr[0];
        $sympthom=$arr[1];
        if (exists $pair{$sympthom})
        {
                @arr2=split('##',$pair{$sympthom});#parents
                foreach my $n (@arr2){
                         $tmp=$gene."#".$n;
                        $pair55{$tmp}=$tmp;

                }
}
	$pair55{$key}=$key;
}


for $key (keys(%pair6))
{
        @arr=split('#', $key);
        $gene=$arr[0];
        $sympthom=$arr[1];
        if (exists $pair{$sympthom})
        {
                @arr2=split('##',$pair{$sympthom});#parents
                foreach my $n (@arr2){
                         $tmp=$gene."#".$n;
                        $pair66{$tmp}=$tmp;

                }
}
	$pair66{$key}=$key;
}


for $key (keys(%pair7))
{
        @arr=split('#', $key);
        $gene=$arr[0];
        $sympthom=$arr[1];
        if (exists $pair{$sympthom})
        {
                @arr2=split('##',$pair{$sympthom});#parents
                foreach my $n (@arr2){
                         $tmp=$gene."#".$n;
                        $pair77{$tmp}=$tmp;

                }
}
	$pair77{$key}=$key;
}


for $key (keys(%pair8))
{
        @arr=split('#', $key);
        $gene=$arr[0];
        $sympthom=$arr[1];
        if (exists $pair{$sympthom})
        {
                @arr2=split('##',$pair{$sympthom});#parents
                foreach my $n (@arr2){
                         $tmp=$gene."#".$n;
                        $pair88{$tmp}=$tmp;

                }
}
	$pair88{$key}=$key;
}







for $key (keys(%pair11))
{
	 
	print MYFILE1 $key."\n";
}


for $key (keys(%pair22))
{

        print MYFILE2 $key."\n";
}


for $key (keys(%pair33))
{

        print MYFILE3 $key."\n";
}


for $key (keys(%pair44))
{

        print MYFILE4 $key."\n";
}


for $key (keys(%pair55))
{

        print MYFILE5 $key."\n";
}


for $key (keys(%pair66))
{

        print MYFILE6 $key."\n";
}


for $key (keys(%pair77))
{

        print MYFILE7 $key."\n";
}


for $key (keys(%pair88))
{

        print MYFILE8 $key."\n";
}









