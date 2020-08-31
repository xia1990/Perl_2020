#!/usr/bin/perl

#print "菜鸟教程网址?\n";
#$name=<STDIN>;
#print "网址:$name\n";

open(DATA,"<import.txt") or die "无法打开数据";
@lines=<DATA>;
print "@lines\n";
close(DATA);

print "===============================1\n";
open(DATA1,"<file1.txt");
open(DATA2,">file2.txt");
while(DATA1){
	print DATA2 $_;
}
close(DATA1);
close(DATA2);
