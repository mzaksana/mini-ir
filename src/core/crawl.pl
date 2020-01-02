#!/usr/bin/perl
#
# Program ini digunakan untuk melalukan crawling
#
# Author: Muammar Zikri Aksana
# http://cs.unsyiah.ac.id/~mksana/
# Department of Informatics College of Science, Syiah Kuala University
# Date: Jan 2019
#
# Dependencies:
# 1. Mechanize
# 2. Tiny

use strict;
use Try::Tiny;
use WWW::Mechanize;

require "./src/utils/generateUrl.pl";

my $mech = WWW::Mechanize->new(autocheck => 0); # inisialisasi 
# Untuk Melakukan crawling , beberapa website meminta user agent
my $initial_user_agent = 'Mozilla/5.0 (Linux; U; Android 2.2; de-de; HTC Desire HD 1.18.161.2 Build/FRF91) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1';
# $mech->add_header('User-agent' => $initial_user_agent);
$mech->agent($initial_user_agent);

my $loop=1; # var untuk counter , sebagai informasi untuk menunjukkan hitungan url yang dicrawling
my %urls; # hash untuk menampung unik url
my $go=0; # var untuk counter link unik
my $startAt=localtime; # untuk menyimpan waktu awal pada saat program dijalankan
my @links_get=[];
main();

# args
# name-file link{pattern} day folder regex

# name-file 		: prefix for downloaded file
# link{pattern} 	: pattern for link crawl
# day 				: counter
# folder 			: destination for downloaded file
# regex				: accapted link format for crawl
sub main{
    
    # looping sebanyak jumlah day yang ditentukan
	for(my $i=0; $i <= $ARGV[2]; $i++){
        # proses mendapatkan url
		my $uri=generator($ARGV[1]);
        print "$i Make link : ---- $uri\n";
		fly($uri,$ARGV[4]);
	}
	print scalar @links_get."\n";
	my @sort = uniq(@links_get);
	print scalar @sort."\n";

    # proses crawling
    print "Crawling : ---- \n";
	go($ARGV[0],$ARGV[3]);
	return 1;
}


# Procedure fly untuk melakukan mech pada sebuah url 
# Setiap url yang di dapat dan memenuhi url filter ditambah kedalam hash yang nantinya dicrawling
sub fly{
	#url - url-filter
    # proses mendapat semua url dari sebuah laman web (url)
	my $temp = eval{$mech->get($_[0])};
    # jika tidak ada url yang didapatkan maka laman web (url) tersebut die atau timeout
	if (not $temp){
        # dicatat, sebagai log link yang mati
    	open(my $deadLink,'>>:encoding(UTF-8)','data/link/deadLink.txt');
		# print "skip dead Link : $_[0]\n";    	
		print $deadLink $_[0]."\n";
    	close $deadLink; 
        return 1;
	}

    # jika url didapatkan maka catat dan tambah ke hash urls
    open(my $hashLink,'>>:encoding(UTF-8)','data/link/hashLink.txt');
    
    # untuk setiap link yang didapat
	for my $i ($mech->links()){
        # difilter dengan filer url yang ditentukan
        if($i->url=~$_[1]){
			push @links_get,$i->url;
            if(exists $urls{$i->url}){
    	        # print "Link get exists : ".$go."\n";
	            # print $i->url."\n";
                $urls{$i->url}++;

            }else{
	            # print "Link get : ".$go."\t";
                $urls{$i->url}=1;
                # print $hashLink $i->url."\n";
				$go++;
            }
        }else{
            # print "skip : ".$i->url."\n";
        }
	}
    close $hashLink;
	return 1;
}

# Procedure go untuk melakukan proses each dari url
sub go{
    # static-name - destination
	foreach my $url (keys %urls) {
		print "-------------------------------------------------\n";
		print "Crawl    : $_[0] : $loop : $go\n";
        print "From     : $url\n";
        print "To       : $_[1]\n";
        print "Start at : $startAt\n";
        print "Time     : ".localtime."\n";
		print "-------------------------------------------------\n";
        # proses crawling untuk setiap url dari hash
	   	crawl($_[1],($_[0]."-".$loop++),$url);
	}
	return 1;
}

# Fungsi untuk melakukan crawling
sub crawl{
	#folder-file-url

    # perintah wget melakukan crawling terhadap url yang diberkan dan hasilnya disimpan pada sebuah scalar
    my $RESULT=`wget -qO- --user-agent="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" $_[0]/$_[1].html $_[2]`;
    # print $RESULT;
    open(my $web,'>>:encoding(UTF-8)',"$_[0]/$_[1].html");
    my $uri="<url>$_[2]</url>\n";
    # concat url dengan hasil crawling sebelumnya, agar data url dari web terdata
    print $web $uri.$RESULT;
    close $web;
    # print $CMDOUT;
    
}





