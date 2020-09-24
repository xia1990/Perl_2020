#!/usr/bin/perl -w

@array=('a','b','c','d');
print "@array\n";
#数组的考贝
@array1=@array;
print "@array1\n";

#数组长度
$len=@array;
print "$len\n";

#子数组
@subarray1=@array[0,1];
@subarray2=@array[0..2];
print "@subarray1,@subarray2\n";

print "=========数组排序===========\n";
@array2=sort(@array);
print "@array2\n";
print "=========数组反转===========\n";
@array3=reverse(@array);
print "@array3\n";
print "=========遍历数组===========\n";
for $item (@array){
	print "$item\n";
}
print "---------------------------\n";
for(my $i=0;$i<@array;$i++){
	print "$array[$i]\n";
}
