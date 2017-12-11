

use strict;


my ($line,@arr,@arr1,@arr2,$key,$sympthom,$gene,$key1);
our %pair;
our %pair1;
our %pair2;
our %pair3;
our %pair4;
our %pair5;
our %pair6;
our %pair7;
our %pair8;
our %pairNew;
our %pairNew2;
our %TP;
our %FP;
our %FN;
%pair=();
%pair1=();
%pair2=();
%pair3=();
%pair4=();
%pair5=();
%pair6=();
%pair7=();
%pair8=();
%TP=();
%FP=();
%FN=();
%pairNew2=();
open IN, "expandedNPMI0.1.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;

$pair1{$line}=$line;

}

open IN, "expandedNPMI0.2.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;

$pair2{$line}=$line;

}


open IN, "expandedNPMI0.3.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;

$pair3{$line}=$line;

}

open IN, "expandedNPMI0.4.txt" or die "cannot open the ontology file";

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

open IN, "expandedNPMI0.5.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;

$pair5{$line}=$line;

}

open IN, "expandedNPMI0.6.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;

$pair6{$line}=$line;

}

open IN, "expandedNPMI0.7.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;

$pair7{$line}=$line;

}

open IN, "expandedNPMI0.8.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;

$pair8{$line}=$line;

}

open IN, "expandGoldHP+MP_restricted2.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $sympthom_ID = $arr[0];
my $uniprot=$arr[1];

$pair{$sympthom_ID}=$uniprot;
}
close IN;


my($n,$tmp,@arr3,$phenotype);
for $key (keys(%pair))#goldStandard
{
	%pairNew=();
	@arr=split('#',$key);
	my $sympthom=$arr[0];
	@arr1=split('##',$pair{$key});
	foreach my $n (@arr1)
	{
		$tmp=$n.'#'.$sympthom;
		$pairNew{$tmp}=$tmp;
		$pairNew2{$tmp}=$tmp;
	}	
	 
		if ((exists $pairNew{$tmp}) and (exists $pair1{$tmp}))
		{#print "exsist in both : ".$tmp,"\n";
			$TP{$key}=$key;
		}	
		if ((exists $pairNew{$tmp}) and (!exists $pair1{$tmp}))
		{
			$FN{$key}=$key;		
		}
}
foreach $key1 (keys(%pair1))
{
     if ((exists $pair1{$key1}) and (!exists $pairNew2{$key1}))
     {
        $FP{$key1}=$key1;
     }
}
my $TP=scalar (keys(%TP));
my $FP=scalar (keys(%FP));
my $FN=scalar (keys(%FN));
print "TP1: ".$TP."\n";
print "FP1: ".$FP."\n";
print "FN1: ".$FN."\n";
my $P=$TP/($TP+$FP);
my $R=$TP/($TP+$FN);
my $Fscore=(2*$P*$R)/($P+$R);
print "P1 : ".$P."\n";
print "R1 : ".$R."\n";
print "Fscore1 : ".$Fscore."\n";
%pairNew2=();
%TP=();
%FP=();
%FN=();


for $key (keys(%pair))#goldStandard
{
        %pairNew=();
        @arr=split('#',$key);
        my $sympthom=$arr[0];
        @arr1=split('##',$pair{$key});
        foreach my $n (@arr1)
        {
                $tmp=$n.'#'.$sympthom;
                $pairNew{$tmp}=$tmp;
                $pairNew2{$tmp}=$tmp;
        }
                if ((exists $pairNew{$tmp}) and (exists $pair2{$tmp}))
                {#print "exsist in both : ".$tmp,"\n";
                        $TP{$key}=$key;
                }
                if ((exists $pairNew{$tmp}) and (!exists $pair2{$tmp}))
                {
                        $FN{$key}=$key;
                }
}
foreach $key1 (keys(%pair2))
{
     if ((exists $pair2{$key1}) and (!exists $pairNew2{$key1}))
     {
        $FP{$key1}=$key1;
     }
}

my $TP=scalar (keys(%TP));
my $FP=scalar (keys(%FP));
my $FN=scalar (keys(%FN));
print "TP2: ".$TP."\n";
print "FP2: ".$FP."\n";
print "FN2: ".$FN."\n";
my $P=$TP/($TP+$FP);
my $R=$TP/($TP+$FN);
my $Fscore=(2*$P*$R)/($P+$R);
print "P2 : ".$P."\n";
print "R2 : ".$R."\n";
print "Fscore2 : ".$Fscore."\n";
%pairNew2=();
%TP=();
%FP=();
%FN=();

for $key (keys(%pair))#goldStandard
{
        %pairNew=();
        @arr=split('#',$key);
        my $sympthom=$arr[0];
        @arr1=split('##',$pair{$key});
        foreach my $n (@arr1)
        {
                $tmp=$n.'#'.$sympthom;
                $pairNew{$tmp}=$tmp;
                $pairNew2{$tmp}=$tmp;
        }
                if ((exists $pairNew{$tmp}) and (exists $pair3{$tmp}))
                {#print "exsist in both : ".$tmp,"\n";
                        $TP{$key}=$key;
                }
                if ((exists $pairNew{$tmp}) and (!exists $pair3{$tmp}))
                {
                        $FN{$key}=$key;
                }
}
foreach $key1 (keys(%pair3))
{
     if ((exists $pair3{$key1}) and (!exists $pairNew2{$key1}))
     {
        $FP{$key1}=$key1;
     }
}

my $TP=scalar (keys(%TP));
my $FP=scalar (keys(%FP));
my $FN=scalar (keys(%FN));
print "TP3: ".$TP."\n";
print "FP3: ".$FP."\n";
print "FN3: ".$FN."\n";
my $P=$TP/($TP+$FP);
my $R=$TP/($TP+$FN);
my $Fscore=(2*$P*$R)/($P+$R);
print "P3 : ".$P."\n";
print "R3 : ".$R."\n";
print "Fscore3 : ".$Fscore."\n";
%pairNew2=();
%TP=();
%FP=();
%FN=();


for $key (keys(%pair))#goldStandard
{
        %pairNew=();
        @arr=split('#',$key);
        my $sympthom=$arr[0];
        @arr1=split('##',$pair{$key});
        foreach my $n (@arr1)
        {
                $tmp=$n.'#'.$sympthom;
                $pairNew{$tmp}=$tmp;
                $pairNew2{$tmp}=$tmp;
        }
                if ((exists $pairNew{$tmp}) and (exists $pair4{$tmp}))
                {#print "exsist in both : ".$tmp,"\n";
                        $TP{$key}=$key;
                }
                if ((exists $pairNew{$tmp}) and (!exists $pair4{$tmp}))
                {
                        $FN{$key}=$key;
                }
}
foreach $key1 (keys(%pair4))
{
     if ((exists $pair4{$key1}) and (!exists $pairNew2{$key1}))
     {
        $FP{$key1}=$key1;
     }
}

my $TP=scalar (keys(%TP));
my $FP=scalar (keys(%FP));
my $FN=scalar (keys(%FN));
print "TP4: ".$TP."\n";
print "FP4: ".$FP."\n";
print "FN4: ".$FN."\n";
my $P=$TP/($TP+$FP);
my $R=$TP/($TP+$FN);
my $Fscore=(2*$P*$R)/($P+$R);
print "P4 : ".$P."\n";
print "R4 : ".$R."\n";
print "Fscore4 : ".$Fscore."\n";
%pairNew2=();
%TP=();
%FP=();
%FN=();


for $key (keys(%pair))#goldStandard
{
        %pairNew=();
        @arr=split('#',$key);
        my $sympthom=$arr[0];
        @arr1=split('##',$pair{$key});
        foreach my $n (@arr1)
        {
                $tmp=$n.'#'.$sympthom;
                $pairNew{$tmp}=$tmp;
                $pairNew2{$tmp}=$tmp;
        }
                if ((exists $pairNew{$tmp}) and (exists $pair5{$tmp}))
                {#print "exsist in both : ".$tmp,"\n";
                        $TP{$key}=$key;
                }
                if ((exists $pairNew{$tmp}) and (!exists $pair5{$tmp}))
                {
                        $FN{$key}=$key;
                }
}
foreach $key1 (keys(%pair5))
{
     if ((exists $pair5{$key1}) and (!exists $pairNew2{$key1}))
     {
        $FP{$key1}=$key1;
     }
}

my $TP=scalar (keys(%TP));
my $FP=scalar (keys(%FP));
my $FN=scalar (keys(%FN));
print "TP5: ".$TP."\n";
print "FP5: ".$FP."\n";
print "FN5: ".$FN."\n";
my $P=$TP/($TP+$FP);
my $R=$TP/($TP+$FN);
my $Fscore=(2*$P*$R)/($P+$R);
print "P5 : ".$P."\n";
print "R5 : ".$R."\n";
print "Fscore5 : ".$Fscore."\n";
%pairNew2=();
%TP=();
%FP=();
%FN=();



for $key (keys(%pair))#goldStandard
{
        %pairNew=();
        @arr=split('#',$key);
        my $sympthom=$arr[0];
        @arr1=split('##',$pair{$key});
        foreach my $n (@arr1)
        {
                $tmp=$n.'#'.$sympthom;
                $pairNew{$tmp}=$tmp;
                $pairNew2{$tmp}=$tmp;
        }
                if ((exists $pairNew{$tmp}) and (exists $pair6{$tmp}))
                {#print "exsist in both : ".$tmp,"\n";
                        $TP{$key}=$key;
                }
                if ((exists $pairNew{$tmp}) and (!exists $pair6{$tmp}))
                {
                        $FN{$key}=$key;
                }
}
foreach $key1 (keys(%pair6))
{
     if ((exists $pair6{$key1}) and (!exists $pairNew2{$key1}))
     {
        $FP{$key1}=$key1;
     }
}

my $TP=scalar (keys(%TP));
my $FP=scalar (keys(%FP));
my $FN=scalar (keys(%FN));
print "TP6: ".$TP."\n";
print "FP6: ".$FP."\n";
print "FN6: ".$FN."\n";
my $P=$TP/($TP+$FP);
my $R=$TP/($TP+$FN);
my $Fscore=(2*$P*$R)/($P+$R);
print "P6 : ".$P."\n";
print "R6 : ".$R."\n";
print "Fscore6 : ".$Fscore."\n";
%pairNew2=();
%TP=();
%FP=();
%FN=();



for $key (keys(%pair))#goldStandard
{
        %pairNew=();
        @arr=split('#',$key);
        my $sympthom=$arr[0];
        @arr1=split('##',$pair{$key});
        foreach my $n (@arr1)
        {
                $tmp=$n.'#'.$sympthom;
                $pairNew{$tmp}=$tmp;
                $pairNew2{$tmp}=$tmp;
        }
                if ((exists $pairNew{$tmp}) and (exists $pair7{$tmp}))
                {#print "exsist in both : ".$tmp,"\n";
                        $TP{$key}=$key;
                }
                if ((exists $pairNew{$tmp}) and (!exists $pair7{$tmp}))
                {
                        $FN{$key}=$key;
                }
}
foreach $key1 (keys(%pair7))
{
     if ((exists $pair7{$key1}) and (!exists $pairNew2{$key1}))
     {
        $FP{$key1}=$key1;
     }
}

my $TP=scalar (keys(%TP));
my $FP=scalar (keys(%FP));
my $FN=scalar (keys(%FN));
print "TP7: ".$TP."\n";
print "FP7: ".$FP."\n";
print "FN7: ".$FN."\n";
my $P=$TP/($TP+$FP);
my $R=$TP/($TP+$FN);
my $Fscore=(2*$P*$R)/($P+$R);
print "P7 : ".$P."\n";
print "R7 : ".$R."\n";
print "Fscore7 : ".$Fscore."\n";
%pairNew2=();
%TP=();
%FP=();
%FN=();


for $key (keys(%pair))#goldStandard
{
        %pairNew=();
        @arr=split('#',$key);
        my $sympthom=$arr[0];
        @arr1=split('##',$pair{$key});
        foreach my $n (@arr1)
        {
                $tmp=$n.'#'.$sympthom;
                $pairNew{$tmp}=$tmp;
                $pairNew2{$tmp}=$tmp;
        }
                if ((exists $pairNew{$tmp}) and (exists $pair8{$tmp}))
                {#print "exsist in both : ".$tmp,"\n";
                        $TP{$key}=$key;
                }
                if ((exists $pairNew{$tmp}) and (!exists $pair8{$tmp}))
                {
                        $FN{$key}=$key;
                }
}
foreach $key1 (keys(%pair8))
{
     if ((exists $pair8{$key1}) and (!exists $pairNew2{$key1}))
     {
        $FP{$key1}=$key1;
     }
}

my $TP=scalar (keys(%TP));
my $FP=scalar (keys(%FP));
my $FN=scalar (keys(%FN));
print "TP8: ".$TP."\n";
print "FP8: ".$FP."\n";
print "FN8: ".$FN."\n";
my $P=$TP/($TP+$FP);
my $R=$TP/($TP+$FN);
my $Fscore=(2*$P*$R)/($P+$R);
print "P8 : ".$P."\n";
print "R8 : ".$R."\n";
print "Fscore8 : ".$Fscore."\n";
%pairNew2=();
%TP=();
%FP=();
%FN=();

