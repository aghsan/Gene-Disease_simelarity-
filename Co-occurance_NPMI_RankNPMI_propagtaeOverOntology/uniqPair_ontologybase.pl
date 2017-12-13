


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
open IN, "uniqePair_frequancy.txt" or die "cannot open the ontology file";

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


#print $gene_sympthom."\t". $occurence."\n";
$pair1{$gene_sympthom}=$occurence."#".$occurence_perartical;
$pair4{$gene_sympthom}=$gene_sympthom_name."@".$pmcid;
}
close IN;

#for $key (keys(%pair1))
#{
#print $key."\t".$pair1{$key}."\n";
#}





open IN, "HP_Parent_subclasses.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $parent = $arr[0];
my $subclass=$arr[1];
$pair2{$parent}=$subclass;
    
}
close IN;



open IN, "MP_Parent_subclasses.txt" or die "cannot open the ontology file";

while ($line=<IN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $parent = $arr[0];
my $subclass=$arr[1];
$pair2{$parent}=$subclass;
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
	our $count=0;
	our $count1=0;
	if (exists $pair2{$sympthom})
	{#print "parent: ".$key."\t children: ".$pair2{$sympthom}."\n";
	 	@arr2=split('##',$pair2{$sympthom});#subclasses
		foreach my $n (@arr2){
			 $tmp=$gene."#".$n;	
	 		##print $tmp."\n";
	 
			if (exists $pair1{$tmp})
			{	#print $pair1{$tmp}."    .... am here number of occurence ....  "."\n";
				@arr3=split('#',$pair1{$tmp});
				$count = $count+$arr3[0];
				$count1=$count1+$arr3[1];
				##print $tmp."\n count1 : ".$count."\n"; 
			}
		
		}
		#@arr3=split('#',$pair1{$key});
                #$count = $count+$arr3[0];
                #$count1=$count1+$arr3[1];
		#print "count2 : ".$count."#".$count1."\n";
		# $pair3{$key}=$count."#".$count1;
		

		}

		@arr3=split('#',$pair1{$key});
                $count = $count+$arr3[0];
                $count1=$count1+$arr3[1];
                #print "count2 : ".$count."#".$count1."\n";
                $pair3{$key}=$count."#".$count1;
                

		#print $key."count2 : ".$count."\n";
		#$pair3{$key}=$count;
		 ##print $count." this is for all genes \n";
		 #@array=();


}


for $key (keys(%pair3))
{
	 @arr3=split('#',$pair3{$key});
	 @arr=split ('@',$pair4{$key});

	print $key."\t".$arr[0]."\t".$arr3[0]."\t".$arr3[1]."\t".$arr[1]."\n";
}
