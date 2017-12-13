
use strict;
#binmode STDIN, ":utf8";
#binmode STDOUT, ":utf8";

my ($line, @arr, $i, $key, $key2);
our  %pairMap;
our %pair1;
our %pair2;
our %pair3;
%pair1=();
%pair2=();
%pair3=();

#if ($ARGV[0] eq "") {$ARGV[0]="/home/kafkass/Projects/Pathogen_Disease/Sample.extracts.txt";}
#open (IN, $ARGV[0]) || die "cannot open the input file";
while ($line=<STDIN>)
{
chop $line;
$line=~s/&amp;/&/g;
$line=~s/&quot;/\"/g;
$line=~s/&apos;/\'/g;
$line=~s/&lt;/</g;
$line=~s/&gt;/>/g;


@arr=split('\t', $line);

my $gene = $arr[2];
my $geneName =$arr[3];
my $sympthom = $arr[4];
my $sympthomName=$arr[5];


$pair1{$gene."#".$sympthom}++;
$pair3{$geneName."#".$sympthomName}++;

my $pmcid =$arr[0];
my $pmid=$arr[1];



#if (!exists ($pair2{$gene."#".$sympthom}))
#{ 
#	 if ( $pmid )
 #           {$pair2{$gene."#".$sympthom}="pmc:".$pmcid."#pm:".$pmid;}
  #         else { $pair2{$gene."#".$sympthom}="pmc:".$pmcid; } 
#}
#else {   
#	if ($pmid)  
# {$pair2{$gene."#".$sympthom}=$pair2{$gene."#".$sympthom}."##"."pmc:".$pmcid."#pm:".$pmid;}
#	else {$pair2{$gene."#".$sympthom}=$pair2{$gene."#".$sympthom}."##"."pmc:".$pmcid; }

#}


 if (! exists $pair2{$gene."#".$sympthom})
{	if ( $pmid )
	{$pair2{$gene."#".$sympthom}=$geneName."#".$sympthomName."\t pmc:".$pmcid."#pm:".$pmid;}
	else { $pair2{$gene."#".$sympthom}=$geneName."#".$sympthomName."\t pmc:".$pmcid; }
}
#else {$pair2{$gene."#".$sympthom}=$pair2{$gene."#".$sympthom}."##".$geneName."#".$sympthomName."\t pmc:".$pmcid."#pm:".$pmid;}

# if (! exists $pair3{$geneName."#".$sympthomName})
#{       if ( $pmid )
#        {$pair3{$geneName."#".$sympthomName}="pmc:".$pmcid."#pm:".$pmid;}
#       else { $pair3{$geneName."#".$sympthomName}="pmc:".$pmcid; }
#}
#else {$pair3{$geneName."#".$sympthomName}=$pair3{$geneName."#".$sympthomName}."##"."pmc:".$pmcid."#pm:".$pmid;}


#how to print with out repeat 
#for $key (keys(%pair2))
#{	for $key2 (keys(%pair3))
#	{ print $key."\t".$key2."\t".$pair2{$key}."\n";} 
#}


#for $key (keys(%pair2))
#{ print $key."\t".$pair2{$key}."\n";} 


}
close IN;


#print scalar (keys %pair2);
for $key (keys(%pair2))
{
print $key."\t".$pair2{$key}."\n";
}




sub extract_disease_taxon_pairs {
my $sent=shift; 
my @hdo=();
my @taxon=();
my @pairs=();
#my @taxons=();
#my @diseases=();
my @txt=();
my $g;
my $d;
my %h_taxon=();
my %h_hdo=();
my @tmp;

while ($sent =~ /<z:hp ids=\"(.*?)\" cat=\"(.*?)\">((.|\n)*?)<\/z:hp>/g) 
{ $h_hdo{$1}=$3; }

while ($sent =~ /<z:uniprot fb=\"(\d+)\" ids=\"(.*?)\" >((.|\n)*?)<\/z:uniprot>/g) {$h_taxon{$3}=$5; }

@taxon=keys(%h_taxon);
@hdo=keys(%h_hdo);

 
foreach $g(@taxon)
{ foreach $d(@hdo)
  { ###print $g."\t".$d."\n";  
   push (@pairs, $g."||".$d);
  }
}
 
foreach $g(@pairs)
  { 
@tmp=split('\|\|', $g);
push (@txt,$h_taxon{$tmp[0]}."||".$h_hdo{$tmp[1]});
  }

return (\@pairs, \@txt);

}


sub extract_disease {
my @hdo;
my $sent=shift;

while ($sent=~ /<z:doid ids=\"(.*?)\" cat=\"(.*?)\">(.*?)<\/z:doid>/g) {push (@hdo, $1."__".$3);}
@hdo=uniq(@hdo);

return (@hdo);
}


sub extract_taxon {
my @taxon;
my $sent=shift;

while ($sent=~ /<z:taxon fb=\"(\d+)\" ids=\"(.*?)\" type=\"(.*?)\" class=\"(.*?)\">(.*?)<\/z:taxon>/g) {push (@taxon, $2."__".$3."__".$5);}
@taxon=uniq(@taxon);
return (@taxon);
}


sub uniq
{
my @data=@_;
my @unique = do { my %seen; grep { !$seen{$_}++ } @data };

return @unique;
}




