# Author: Muammar Zikri Aksana
# http://cs.unsyiah.ac.id/~mksana/
# Department of Informatics
# College of Science, Syiah Kuala Univ
# 
# Date: Jan 2019


use POSIX qw(strftime);
use feature 'state';
# Fungsi untuk generate date
# %d/%m/%y or %Y-%m-%d , etc.
# return string
sub genDate{
	#time-split
	return my $date=strftime "$_[0]", localtime time()-(@_[1]*24*60*60);
}

sub inc{
    state $count=0;
    state $val=0;

    if(!$count++==0){
        $val+=$_[1];
    }
    return $val;
}


# sub : extractcontent.pl
# Author: Taufik Fuadi Abidin
# Department of Informatics
# College of Science, Syiah Kuala Univ
# 
# Date: Mei 2011
# http://www.informatika.unsyiah.ac.id/tfa
# 
# sub clean_str berfungsi untuk menghapus karakter yang tidak dibutuhkan dalam sebuah string
# @return string
sub clean_str{
    my $str = @_[0];
    # $dot= quotemeta '.';
    $str =~ s/>/ /g;
    $str =~ s/&(.*?)/ /g;
    $str =~ s/[\s,\n,'']&(.*?);/ /g;
    $str =~ s/[\:\]\|\[\@\#\$\%\*\&\,\/\\\(\)\;"]+/ /g;
    # $str =~ s/[\]\|\[\@\#\$\%\*\&\\\(\)\"]+//g;
    $str =~ s/-/ /g;
    $str =~ s/[^,.!?\w+]/ /g;
    $str =~ s/\n+/ /g;
    $str =~ s/^\s+/ /g;
    $str =~ s/\s+$/ /g;
    $str =~ s/^$/ /g;
    $str =~ s/!+/!/g;
    $str =~ s/\s+/ /g;

    # $str =~ s/[\s,\n,'']&(.*?);//g;
    # $str =~ s/[,!.]//g;

    # regex beberapa karakter yang tidak bisa secara explicit ditulis
    # $quetion = quotemeta '?';
    # $quetionMeta = '?';
    # $str =~ s/$quetion+/$quetionMeta/g;



    return $str;
}

# Fungsi untuk membersihkan simbol tanda baca
# dibuat terpisah karena pembagian kontent masih memerlukan simbol sebelumnya
# TODO
sub clear_div_str{
    my $str = @_[0];
    $str =~ s/\W+/ /g;
    return $str;
}
# Fungsi untuk mendapatkan path file dari dengan kedalaman tertentu
# return string
sub filePathFolder{
    my @paths=split("/",$_[1]);
    my $pathFiles='';
    for (my $i=0;$i<$_[0];$i++){
        $pathFiles="/".pop(@paths).$pathFiles;
    } 
    return substr($pathFiles,1);
}

# Fungsi untuk case-soal dimana content dipecah kedalam beberapa bagian
# return string
sub fragmentContent{
    my @kalimat=split /(?<=[\.!?])\s+/,$_[0];
    my $splice = int(scalar @kalimat/4); 
    my $html="<bagian1>".iterateFor(@kalimat,0,$splice*1)."</bagian1>\n";
    $html.="<bagian2>".iterateFor(@kalimat,$splice*1+1,$splice*2)."</bagian2>\n";
    $html.="<bagian3>".iterateFor(@kalimat,$splice*2+1,$splice*3)."</bagian3>\n";
    $html.="<bagian4>".iterateFor(@kalimat,$splice*3+1,$splice*4+@kalimat%3)."</bagian4>\n";
 
    return $html;
}

# Fungsi untuk membentuk kalimat dari array dengan range tertentu
# return string
sub iterateFor{
    $val='';
    $flag=0;
    for (my $i=$_[$_-2];$i<=$_[$_-1];$i++){
        if($flag>=1 && $flag<$_[$_-1]){
            $val.=" ";    
        }
        $val.=$_[$i]; 
        $flag++;  
    }
    
    return $val;
}

# Fungsi ini untuk normalisasi string 
# Misal setelah titik harus ada spasi, tapi untuk url dan titel tidak dan lain sebagainya
# Proses ini dilakukan agar tahap pembagian kontent jumlah kata dapat diprediksikan dengan baik
# return string
sub simanticToken{
    $var=$_[0];
    my @matches = ( $_[0] =~ m/\s+[a-z]+\.\s*[A-Z]+/g );
    # @varr=split \s+[a-z]+\.\s?[A-Z]+,$var;

    foreach $data (@matches){
        # print $data;
        my $token=simanticTokenSentence($data);
        $var=~ s/$data/$token/g;
    }

    return $var;
}

# Fungsi untuk split dan menambahkan spasi pada sepenggal string
# ex: sekolah.Zikri => sekolah. Zikri
# return string 
sub simanticTokenSentence{
    my @token = split "\\.",$_[0];
    # return index 0 dan 1 karena hasil split telah pasti hanya terdari 2 anggota
    return $token[0].". ".$token[1]; 
}

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

1;
