#Use this script to extract annotated terms and their frequencies from the OA files
#Developed by Senay Kafkas
# Sept, 2014


use strict;
our $doc; my $line; my $cnt;
my $file; my $key;

our %freq;

print "PMCID \t PMID \t uniprotID \t geneName \t symptomID \t symptom \t sentence \n";

opendir(DIR, "/scratch/dragon/intel/alahas0a/whatizit/FullTextAnnotationTool/scripts/Output/") or die "cannot open the input directory $!\n";
my @fileset = grep(/\.gz$/,readdir(DIR));
if ($#fileset<0) {die "There is no file having gz extension for the section tagging in the input directory $!\n";}

foreach $file (@fileset) 
{ 
open(IN, "gunzip -c /scratch/dragon/intel/alahas0a/whatizit/FullTextAnnotationTool/scripts/Output/$file |") || die "can't open the file $file";

while ($line=<IN>)
{ 

   if ($line =~ /<!DOCTYPE /)
   { 
     $cnt++;
     if ($doc ne "")
     {process(); $doc="";}
    
     }
 
  else { $doc=$doc.$line; }
   
}
 
process();
close IN;

}#for each file end here 



sub process {
my ($s); 
my (@Sentences)= &proc_sentences();

if ($#Sentences ne -1)
{ foreach $s(@Sentences)
  {

#print "PMCID: ".&proc_pmcid()."\t";

#.$s."\n";
my $sent=shift;
my @hp=();
my @uniprot=();
my @pairs=();
my @txt=();
my $g; my $key;
my $d; my $key1;
my %h_uniprot=();
my %h_sympthom=();
my @tmp;

while ($s =~ /<z:hp ids=\"(.*?)\" cat=\"(.*?)\">((.|\n)*?)<\/z:hp>/g)
{ $h_sympthom{$1}=$3;

 }

while ($s =~ /<z:mp ids=\"(.*?)\" cat=\"(.*?)\">((.|\n)*?)<\/z:mp>/g)
{ $h_sympthom{$1}=$3; 

}


while ($s=~ /<z:uniprot fb=\"(\d+)\" ids=\"(.*?)\">((.|\n)*?)<\/z:uniprot>/g) {$h_uniprot{$2}=$3;

 }
 

@uniprot=keys(%h_uniprot);
@hp=keys(%h_sympthom);

foreach $key (keys %h_uniprot)
{ foreach $key1 (keys %h_sympthom)
   { print &proc_pmcid()."\t".&proc_pmid()."\t".$key. "\t". $h_uniprot{$key}."\t".$key1. "\t". $h_sympthom{$key1}."\t".$s. "\n";
	 }



#print "uniprot ID : ".$key. "\t""gene : ". $h_uniprot{$key}."\t";
}


#foreach $key1 (keys %h_sympthom)
#{print $key1. "\t". $h_sympthom{$key1}."\t";}



#foreach $g(@uniprot)
#{ foreach $d(@hp)
# { print $g."\t".$d."\n";  
    ## push (@pairs, $g."||".$d);
 #      }
  #    }


#my ($ids, $protein)=&proc_tags($s);
 
#$freq{$_}++ for @$protein;

##for (my $i=0; $i<scalar(@$protein); $i++)
##{ ##print "PMCID".&proc_pmcid()."\t".$s."\t"."ID=".@$ids[$i]."\t"."GENE=".@$protein[$i]."\n";
   #print @$protein[$i]."\n";
##}

 }#foreach sentence

}

}#sub

 

sub proc_pmcid {
  if ($doc =~ /<article-id pub-id-type=\"pmcid\">(\S+)<\/article-id>/) { 

 return $1;
  }

  else {return "";}
}


sub proc_pmid {
  if ($doc =~ /<article-id pub-id-type=\"pmid\">(\S+)<\/article-id>/) {
 return $1;
  }

  else {return "";}
}



sub proc_sentences {
my $sent;
my @last;

while ($doc =~ /<plain>(.*?)<\/plain>/g) 
{$sent=$1;
   if ( (($sent=~/<z:hp /) or ($sent=~/<z:mp /)) and ($sent=~/<z:uniprot /)) { push (@last, $sent);} 
}

return (@last);
}







