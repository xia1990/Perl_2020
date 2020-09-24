#!/usr/bin/perl -w



$str="Caine:Michael:Actor:14,LeafyDrive";
#以冒号作为分隔符
@array=split(/:/,$str);
print "@array\n";

my $substr1=substr("I love Perl",2,5);
print "$substr1\n";
