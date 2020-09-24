#!/usr/bin/perl -w


@list=(1,2,3,4,5);
foreach $temp (@list){
	if($temp==2){
		$temp=20;
		print "$temp\n";
	}
}
print "@list\n";

print "------------------1\n";
#函数的调用方法
&a;
sub a{
	print "hello,world\n";
}

print "------------------2\n";
sub b{
	print "he,he,he,he\n";
}
b;

print "------------------3\n";
#调用函数并传递参数
&sub1(1,2,3);
sub sub1{
	my($number1,$number2,$number3)=@_;
	print "@_\n";
}

print "------------------4\n";
@array1=(1,2,3);
@array2=(4,5,6);
&two_array_sub(@array1,@array2);
sub two_array_sub{
	my (@subarray1,@subarray2) = @_;
	print "@_\n";
}
