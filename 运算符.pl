#!/usr/bin/perl

$a="abc";
$b="xyz";
print "$a,$b\n";

if($a lt $b){
	print "lt true\n";
}else{
	print "lt false\n";
}

if($a gt $b){
	print "true\n";
}else{
	print "false\n";
}

if($a eq $b){
	print "true\n";
}else{
	print "false\n";
}

$c=$a cmp $b;
print "\$a cmp \$b return $c\n";

print "1============================\n";
use integer
$a=60;
$b=13;
$c=$a&$b;
print "\$a & \$b = $c\n";
$c=$a|$b;
print "\$a | \$b = $c\n";
$c=$a^$b;
print "a^b=$c\n";
$c=~$a;
print "~a=$c\n";
$c=$a>>2;
print "a>>2=$c\n";
$c=$a<<2;
print "a<<2=$c\n";

print "2================================\n";
$a=10;
$b=q{a=$a};
print "$b\n";
$b=qq{a=$a};
print "$b\n";
$b=qx{date};
print "$b\n";
