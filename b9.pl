#!/usr/bin/perl -w

use strict;
#总和
sub total{
	my $a;
	foreach(@_){
		$a+=$_;
	}
	$a;
}
#平均值
sub average{
	&total(@_)/@_;
}
#比平均值大的数值
sub above_average{
	my ($b,@e);
	$b=&average(@_);
	foreach(@_){
		push @e,$_,"\n" if($_>$b);
	}
	@e
}

#计算1-10的总和
my @c=(1..10);
$b=&total(@c);
print "$b\n";

#比平均值大的元素
print &above_average(@c),"\n";
