#!/usr/bin/perl

sub hello{
	print "Hello,world\n";
}
hello();

sub Average{
	$n=scalar(@_);
	$sum=0;

	foreach $item(@_){
		$sum+=$item;
	}
	$average=$sum / $n;
	print "传入的参数为：","@_\n";
	print "第一个参数值为:$_[0]\n";
	print "传入参数的平均值为：$average\n";
}
Average(10,20,30);

sub PrintList{
	my @list=@_;
	print "列表为：@list\n";
}
$a=10;
@b=(1,2,3,4);
PrintList($a,@b);

sub PrintHash{
	my(%hash)=@_;
	foreach my $key(keys %hash){
		my $value=$hash{$key};
		print "$key:$value\n";
	}
}
%hash=('name'=>'runoob','age'=>2);
PrintHash(%hash);

print "1===========================\n";
sub add_a_b{
	$_[0]+$_[1];
}
print add_a_b(1,2);

print "1===========================\n";
$string="Hello,World!";
sub PrintHello{
	my $string;
	$string="Hello,Runoob!";
	print "函数内字符串：$string\n";
}
PrintHello();
print "函数外字符串：$string\n";


print "1===========================\n";
$string="Hello,World!";
sub PrintRunoob{
	local $string;
	$string="Hello,Runoob!";
	PrintMe();
	print "PrintRunoob函数内字符串值:$string\n";
}
sub PrintMe{
	print "PrintMe函数内字符串值：$string\n";
}
sub PrintHello{
	print "PrintHello函数内字符串：$string\n";
}
PrintRunoob();
PrintHello();
print "函数外部字符串值：$string\n";


print "2===========================\n";
use feature 'state';
sub PrintCount{
	state $count=0;
	print "counter值为：$count\n";
	$count++;
}
for(1..5){
	PrintCount();
}
