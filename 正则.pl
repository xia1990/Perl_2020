#!/usr/bin/perl

$bar="I am runoob site. welcome to runoob site.";
if($bar=~/run/){
	print "第一次匹配\n";
}else{
	print "第一次不匹配\n";
}

$bar="run";
if($bar=~/run/){
	print "第二次匹配\n";
}else{
	print "第二次不匹配\n";
}

print "1====================\n";
$string="welcome to runoob site.";
#匹配字符串
$string =~ m/run/;
print "匹配前的字符串：$`\n";
print "匹配的字符串：$&\n";
print "匹配后的字符串：$'\n";


print "2====================\n";
$string="welcome to google site.";
#替换字符串
$string =~ s/google/runoob/;
print "$string\n";

print "3====================\n";
$string='welcome to runoob site';
#将小写字符转换成大写字符
$string =~ tr/a-z/A-Z/;
print "$string\n";

print "4====================\n";
$string='runoob';
#去重复
$string =~ tr/a-z/a-z/s;
print "$string\n";

print "5====================\n";


print "1====================\n";
print "1====================\n";
