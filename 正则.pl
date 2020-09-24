#!/usr/bin/perl -w

$string="This string contains the number 25.11.";
$string=~/-?(\d+)\.?(\d+)/;

print "$string\n";

print "-------------------\n";
$somework=q/i've some money/;
print "$somework\n";

$myword="catcat";
$replaceword=qr(catcat);
$finalword="ok" if($myword=~$replaceword);
print "$finalword\n";

print "===========q==========\n";
#q:相当于单引号，输出变量的原值
#使用q可以正常的输出特殊符号，不需要转义
$someword = q/i 've some money/;
print "$someword\n";
print "-----------qq-----------\n";
#这里的qq,可以理解为双引号，能正常解析变量
my $strqq=qq,\n\nthis is qq test\n,;
print "$strqq\n";

$strqw=('a','b','c');
$strqw1=qw{$strqw};
print "\$strqw1:$strqw1\n";

print "--------------qw---------------\n";
@list=qw(perl java shell ruby);
print "@list\n";

