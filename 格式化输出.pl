#!/usr/bin/perl

$text="google runoob taobao";
format STDOUT=
first:^<<<<<
	$text
second:^<<<<<
	$text
third:^<<<
	$text
.
write

print "1===============================\n";
format EMPLOYEE=
==========================
@<<<<<<@<<
$name,$age
@#####.##
$salary
==========================
.
select(STDOUT);
$~=EMPLOYEE;
@n=("kate","rose","lily");
@a=(20,30,40);
@s=(2000.00,3000.00,4000.00);
$i=0;
foreach(@n){
	$name=$_;
	$age=$a[$i];
	$salary=$s[$i++];
	write;
}


$~="MYFORMAT";
write;
format MYFORMAT=
=====================
	Text # 菜鸟教程
=====================
.
WRITE;
