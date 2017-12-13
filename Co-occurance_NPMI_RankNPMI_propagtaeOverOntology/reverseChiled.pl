
use strict;
use warnings;

my ($line,@arr,@ids,$d,%onto,$key,%names);


open IN, "chiledOfParents.txt" or die "cannot open the ontology file";
#CLO_0050043    RCB0174 cell            CLO_0000493##CLO_0000219##CLO_0000019##
while ($line=<IN>)
{ #print $arr[3]."\n";
chop $line; @arr=split('\t', $line);
$names {$arr[0]}=$arr[1];
@ids=split('##', $arr[$#arr]);

foreach $d (@ids)

 {
	  if (exists $onto{$d})
       {$onto{$d}=$onto{$d}."##".$arr[0];}
          else { $onto{$d}=$arr[0];}  
}


           }
close IN;


foreach $key (keys %onto)
{
	print $key."\t".$onto{$key}."\n\n";
}

