use strict;
use warnings;
use lib '/home/alahas0a/Downloads/OWL-Simple-0.51/lib';
use OWL::Simple::Parser;

my (%name, %synonyms, %definition, @tmp, $key, $item);
our (%parents, @parentlist);

my $parser = OWL::Simple::Parser->new(owlfile => 'MP.owl');
#parse file
$parser->parse();


 # iterate through all the classes
for my $id (keys %{ $parser->class }){
         my $OWLClass = $parser->class->{$id};
	 #print $id . ' ' . $OWLClass->label . "\n";
         $id=~s/http:\/\/(.*?)\/(.*?)\/(.*?)/$3/;
         # $id=~s/http:\/\/purl.obolibrary.org\/obo\///g;
         # $id=~s/http:\/\/www.ebi.ac.uk\/efo\///g;
         if ($id=~/MP_/) {$name{$id}=$OWLClass->label;}
               	
	# list synonyms
 	# for my $syn (@{ $OWLClass->synonyms }){
         #	print "\tsynonym - $syn\n";
          #      push (@tmp, $syn);
          #}
  	 #$synonyms{$id}=join('##', @tmp); @tmp=();
               
	# list definitions
         #for my $def (@{ $OWLClass->definitions }){
                 # print "\tdef - $def\n";
       	#	 push (@tmp, $def);
        # }
	#$definition{$id}=join('##', @tmp); @tmp=();
               
	# list parents
	for my $parent (@{ $OWLClass->subClassOf }){
        	# print "\tsubClassOf - $parent\n";
                #$parent=~s/http:\/\/purl.obolibrary.org\/obo\///g;
                #$parent=~s/http:\/\/www.ebi.ac.uk\/efo\///g;
                $parent=~s/http:\/\/(.*?)\/(.*?)\/(.*?)/$3/;
                push(@tmp, $parent);
         }
         $parents{$id}=join('##', @tmp); @tmp=();
                                                                                                                                    
}



foreach $key (keys %name)
   { ##print $key."\t".$name{$key}."\t".$synonyms{$key}."\t".$definition{$key}."\t".$parents{$key}."\n";}
       
	
	my @tmp=split('##', $parents{$key});
	foreach $item (@tmp)
		{#print $item."\n";
		my $var=recurse($item); #print "final=". $var->[0];    
		} 	  

	my $str= join("##",@parentlist); @parentlist=();
	#print $str."\n";
	#print $key."\t".$name{$key}."\t".$synonyms{$key}."\t".$definition{$key}."\t".$str."\n"; #if ($str=~/MI:0001/) {}
	if ($str)
	{print $key."\t".$name{$key}."\t".$str."\n"."\n";}
	else
	{print $key."\t".$name{$key}."\t".$str." "."\n"."\n";}
 
}#for each ID


sub recurse
{
	my $ID=shift;
	my $item;
	my @tmp;

	@tmp=split('##', $parents{$ID});
	push (@parentlist, $ID);

	foreach $item (@tmp)
	   {
	     if ($item=~/^0$/ ) {return $item; }
     	      else {return recurse($item);}
   
   	}
}

                                                                                                 
