# Program ini digunakan untuk meng-generate url untuk dicrawling
# Pattern yang diterima : 
#          - date 
#                  ex : www.html.com/{2014-01-28}
#                     : www.html.com/{date:val=date-format}
#                     : www.html.com/{date:val=%Y-%m-%d}
#          - inc 
#                  ex : www.html.com/count={inc:val=1}
#                     : www.html.com/{inc:val=num-format}
#                     : www.html.com/{inc:val=1}
#
# Author: Muammar Zikri Aksana
# http://cs.unsyiah.ac.id/~mksana/
# Department of Informatics College of Science, Syiah Kuala University
# Date: Jan 2019
#
# Dependencies:
# 1. Mechanize
# 2. Tiny

use POSIX qw(strftime);
use feature qw(state);
require "./src/utils/util.pl";

# Fungsi ini untuk mengambil pettern url
# Dimana url yang diberikan memiliki {format}
# Isi didalam kurung kurawal akan di ubah menjadi format yang diberikan
# return hash addres , index hash adalah val => ex ditop {date:val}
sub preproces{
    my %map;
    my @pattern = ($_[0]=~ /\{([^}]+)\}/g);

    foreach my $line (@pattern){
        my @flag=$line=~/^.*?(?=:)/g;
        my @key=$line=~/(?<=$flag[0]:).*?(?==)/g;
        my @value=$line=~/(?<=$key[0]=).*/g;
        $map{$key[0]}=transform($flag[0],$value[0]);

    }
    return \%map;
}

# Procedure yang menentukan suatu pattern ditransformasi kedalam
# format yang bagaimana , date atau angka
# see genDate inc : util.pl
sub transform{
    state $counter = 0;
    # print $counter."\t";
    if($_[0]=~/date/){
        return genDate($_[1],$counter++);
    }
    if($_[0]=~/inc/){
        return inc($_[1],$counter++);
    }
}


# Fungsi yang menggenerate url yang baru berdasarkan format yang ditentukan
#  Return string url
sub generator{
    my $url=shift;
    my $ref=preproces($url);
    my %map=%$ref;
    # my $map=%$_[1];
    foreach my $key (keys %map) {
        $url=~ s/{([^{]*$key.*?)\}/$map{$key}/;
    }
    return $url;
}

