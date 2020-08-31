#!/usr/bin/perl

$var=10;
$r=\$var;
print "$var为：",$$r,"\n";

@var=(1,2,3);
$r=\@var;
print "\$r引用数组：",@$r,"\n";

%hash=('google'=>'google.com','baidu'=>'baidu.com');
$r=\%hash;
print "\$r引用哈希：",%$r,"\n";

print "1========================\n";
$var=10;
$r=\$var;
print "r的引用类型：",ref($r),"\n";

@var=(1,2,3);
$r=\@var;
print "r的引用类型：",ref($r),"\n";

%var=('key1'=>10,'key2'=>20);
$r=\%var;
print "r的引用类型：",ref($r),"\n";

print "2=========================\n";
my $foo=100;
$foo=\$foo;
print "value of foo is:",$$foo,"\n";

#函数引用:&
print "3=====================\n";
sub PrintHash{
	my(%hash)=@_;
	foreach $item (%hash){
		print "元素:$item\n";
	}
}
%hash=('name'=>'runoob','age'=>3);
$cref=\&PrintHash;
&$cref(%hash);
