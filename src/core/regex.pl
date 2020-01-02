$file=`cat $ARGV[0]`;
$file=~/<title>(.*?)<\\title>/;
print $1;
