#!/usr/bin/perl

# Author: Muammar Zikri Aksana
# http://cs.unsyiah.ac.id/~mksana/
# Department of Informatics College of Science, Syiah Kuala University
# 5 Mar 2019 

# Dependencies:
# HTML::ExtractContent
# util.pl


use strict;
use warnings;
use HTML::ExtractContent;
use File::Basename;
use File::Path qw(make_path);
require "./src/utils/util.pl";

my $extractor = HTML::ExtractContent->new;
my $countf=0;
my $startAt=localtime;

#perl extractContent.pl /media/mza/Pro/DataPro/data-crawl/indopos/ /media/mza/Pro/DataPro/data-clean/
main();

# Procedure main adalah bagain utama
# Didapat sub path dari path yang diberikan (command) 
sub main{
    # mendapatkan semua file dari path yang diberikan
    my $listFile=`find $ARGV[0] -type f -follow`;
    # setiap path file disimpan kedalam array
    my @filePaths= split("\n",$listFile);

    # untuk setiap file
    foreach my $file (@filePaths){
        # print $filePaths[0];
        print "------------------------------------------\n";
        print "Start at : $startAt\n";
        print "Time     : ".localtime."\n";
        print "countf : ".$countf++." : ".scalar @filePaths."\n"; # array size
        print "from : $file\n";
        # ubah kedalam format clean lalu di save
        saveFile($ARGV[1],$file,extractFile($file));
    }
}

# Fungsi untuk mendapatkan teks dari sebuah file dengan tag atau simbol tertentu
# return string
sub extractFile{
    my $file =`cat $_[0]`;
    my $title ="";
    my $url ="";
    # get TITLE
    if( $file =~ /<title.*?>(.*?)<\/title>/){
        $title = $1;
        $title = clean_str($title);
        $title="<title>$title</title>\n";
        # bagian title dihapus dari file agar tidak ikut dalam content
        $file  =~ s/<title.*?>(.*?)<\/title>//;
    }
    # get URL
    if( $file =~ /<url>(.*?)<\/url>/){
        $url = $1;
        $url="<url>$url</url>\n";
        # bagian url dihapus dari file agar tidak ikut dalam content
        $file  =~ s/<url>(.*?)<\/url>//;
    }
    $extractor->extract($file);
    # get BODY (Content)
    my $content = $extractor->as_text;
    $content = simanticToken(clean_str($content));
    # print OUT "<content>$content</content>\n";
    return $url.$title.fragmentContent($content);

}

sub saveFile{
    #mendapatkan path untuk file
    my $dir= $_[0].filePathFolder(0,dirname($_[1]));
    # concat path dengan nama file
    my $newFile=$dir."/".basename(filePathFolder(1,$_[1]),".txt");


    # print $_[1];
    # fragmentContent($_[2]);
    print "to : $newFile\n";
    print "------------------------------------------\n";

    # cek dir, jika tidak ada maka buat dir tersebut
    unless(-e $dir or `mkdir -p $dir`) {
        open(my $fail,'>>:encoding(UTF-8)','data/log/logFailedClean.txt') or die;
        my $line="fail : ".$newFile."\n";
		print $fail $line ;    	
    	close $fail; 
        return 1;
    }
    #save file
    open (my $OUT, '>:encoding(UTF-8)',$newFile)or die;
    print $OUT $_[2];
    close $OUT;
}


