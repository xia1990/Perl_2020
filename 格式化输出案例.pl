#!/usr/bin/perl -w

print "请输入字符长度，按Ctrl+D\n";
chomp(my $width=<STDIN>);
print "请输入字符串，按Ctrl+D\n";
chomp(my @lines=<STDIN>);
print "="x100,"\n";
foreach(@lines){
	printf "%${width}s\n",$_;
}
