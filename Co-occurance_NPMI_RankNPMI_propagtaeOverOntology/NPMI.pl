
use strict;
#binmode STDIN, ":utf8";
#binmode STDOUT, ":utf8";

my ($line, @arr,@arr1, @tmp, $i, $key, $key2,$k);
our  %pairMap;
our %pair1;
our %pair2;
our %pair3;
our %pair4;

%pair1=();
%pair2=();
%pair3=();
%pair4=();
my $total=0;
my $count=0;
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

my $gene_sympthom = $arr[0];
my $gene_sympthom_name = $arr[1];
my $occurencePerArticle=$arr[3];
my $pmcid=$arr[4];
my $occurence = $arr[2];
@arr1=split('#',$gene_sympthom);
my $gene=$arr1[0];
my $sympthom=$arr1[1];

if (! exists $pair1{$gene})
{
	$pair1{$gene}=$occurence;
}
else
{
	$count=$pair1{$gene}+$occurence;
        $pair1{$gene}=$count;
        $count=0;

}



if (! exists $pair2{$sympthom})
{
        $pair2{$sympthom}=$occurence;
}
else
{
        $count=$pair2{$sympthom}+$occurence;
        $pair2{$sympthom}=$count;
        $count=0;

}

$pair3{$gene_sympthom}=$occurence;

$total=$total+$occurence;

$pair4{$gene_sympthom}=$gene_sympthom_name."@".$occurencePerArticle."@".$pmcid;




}
close IN;

for $key (keys(%pair3))
{	
	@arr1=split('@',$pair4{$key});
	@arr=split('#',$key);
	my $gene_occ=$pair1{$arr[0]};
	my $sympthom_occ=$pair2{$arr[1]};
	my $result=(log($pair3{$key}/($gene_occ*$sympthom_occ/$total)))/-log($pair3{$key}/$total);
	my $result2= sprintf("%.2f",$result);
	print $key."\t".$arr1[0]."\t".$pair3{$key}."\t".$arr1[1]."\t".$arr1[2]."\t".$result2."\n";
}

#print $total."\n";
#@arr1=keys(%pair2);
#@arr2=values(%pair2);

#foreach $k (@arr) {
#print $k."#####\n";
#}


#print scalar (keys %pair2);
#for $key (keys(%pair2))
#{@tmp=split('##', $pair4{$key});
#@tmp=uniq(@tmp);
#
#print $key."\t".$pair2{$key}."\t".$pair1{$key}."\t".scalar(@tmp)."\t".join('##',@tmp)."\n";

#}


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



#sub finduniq
#{
#my @terms=@_;
#my $k;
#my @newterms=();

#foreach $k (@terms)
#{
# if (  (!(grep {$_ eq $k} @newterms)) ) {push (@newterms, $k);}  
#}

#return @newterms;


#}
