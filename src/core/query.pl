use strict;
use Data::Dumper;

# file.pl index.file top query queryNext ...

my $indexFile=`cat $ARGV[0]`;
my %index;
my %score;
my $counter=0;

sub getFormat{
	my $title='';
	my $url='';
	my $title='';
	my $bagian1='';

	if( $_[0] =~ /<url.*?>(.*?)<\/url>/){
        $url = $1;
	}
	if( $_[0] =~ /<title.*?>(.*?)<\/title>/){
        $title = $1;
	}
	if( $_[0] =~ /<bagian1.*?>(.*?)<\/bagian1>/){
        $bagian1 = $1;
	}

	return "{\"url\":\"$url\",\"score\":\"$_[1]\",\"title\":\"$title\",\"prew\":\"$bagian1\"},";
}


for my $lines(split "\n",$indexFile){
	my @line=split " ",$lines;
	my @list;
	for my $col (@line[1 .. $#line]){
		my @dataCol=split ':',$col;
		my %doc=(
			'doc'=> $dataCol[0],
			'score'=> $dataCol[1]
		);
		push @list,\%doc;
	}
	$index{$line[0]}=\@list;

}

foreach my $a(@ARGV[2.. $#ARGV]) {
	$a = lc($a);

  #print Dumper(\%index{$a});
	foreach my $data($index{$a}){
		#print "index : \n";
		#print Dumper $data;
		foreach my $line(@{$data}){

			if(exists $score{$$line{'doc'}}){
				$score{$$line{'doc'}}+=$$line{'score'}
			}else{
				$score{$$line{'doc'}}=$$line{'score'}
			}
			#print $$line{'doc'};
		}
		#print ${@{$data}[0]}{'score'}."\n";
		#print "end \n";
	}

	$counter++;
}

my $abs_f="../../data/clean/";
my $top = $ARGV[1];
print "[";

foreach my $key (sort { $score{$b} <=> $score{$a} } keys %score) {
  my $file = `cat $abs_f/$key`;
  chomp($file);
  print getFormat($file,$score{$key});
  if($top--==0){
	  last;
  }
}

print "{}]";
