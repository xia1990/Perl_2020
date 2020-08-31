#!/usr/bin/perl

$a="run";
$b="oob";
print "$a,$b\n";

$c=$a.$b;
print "$c\n";

$c='-'x3;
print "$c\n";

@c=(1..10);
print "@c\n";

$a=10;
$b=15;
print "a=$a,b=$b\n";
$a++;
print "a=$a\n";
$b--;
print "b=$b\n";

print "1=======================\n";
$a=20;
$b=10;
$c=15;
$d=5;
$e;
$e=($a+$b)*$c/$d;
print "(a+b)*c/d=$e\n";
