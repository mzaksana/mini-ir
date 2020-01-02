use strict;

# Argumen
my $path = $ARGV[0];
my $file = $ARGV[1];
if (! $file) {
  print "Cara jalankan: $0 <PathDocument> <FileOutput>\n";
  exit;
}

#ambil list dari file
my $dir = `ls -v $path | head -100`;
my @list_file = split /\n/, $dir;
my $length = @list_file; 

#deklarasi hash
my %df;
my %tf;
my %idf;


for (my $i=0; $i<$length; $i++) {
	print "indexing $i from $length\n";
    my $data = `cat $path/$list_file[$i]`;  #ambil isi file
    $data =~ s/\n//g;
    $data =~ s/\r//g;
    #$data =~ /<title>(.)<\\title>/;
	  #print($1);
	$data = lc($data);
    #list word to array
    my @list_word = split / /, $data;

    #perulangan untuk setiap kata
    foreach my $word (@list_word) {

        #tf per dokumen
        if ($tf{$word}[$i]) {
            $tf{$word}[$i] +=1;
        } else {
            $tf{$word}[$i] =1;
        }

        #df total frekuensi
        if($df{$word}) {
            $df{$word} += 1;
        } else {
            $df{$word} = 1;
        } 
    }
}

# Hitung nilai Idf
foreach my $x (keys %df) {
    $idf{$x} =1 + log10($length/$df{$x});
}


# Fungsi Kalkulator Log 10
sub log10 { 
    my $n = shift; 
    return log($n) / log(10); 
} 

# Buat Output
open OUT, "> $file" or die "Cannot Open File!!!";
foreach my $x (keys %df) {
    print OUT "$x ";
    for (my $i=0; $i<$length; $i++) {
        my $count = $i+1;
        my $weight = $tf{$x}[$i] * $idf{$x};  # hitung weight setiap kata pada dokumen
        if ($weight==0){
          next;
        }
        print OUT "$list_file[$i]:$weight ";
    }
    print OUT "\n";
}

