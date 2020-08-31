#!/usr/bin/perl

%data=('google'=>'google.com','runoob'=>'runoob.com','taobao'=>'taobao.com');
#读取哈希的所有key
@names=keys %data;
#打印数组的值
print "@names\n";
#读取哈希所有的value
@urls=values %data;
print "@urls\n";

print "1:===================================\n";
%data=('google'=>'google.com','runoob'=>'runoob.com','taobao'=>'taobao.com');
if(exists($data{'facebook'})){
	print "facebook的网址为$data{'facebook'}\n";
}else{
	print "facebook键不存在\n";
}

print "2===================================\n";
%data=('google'=>'google.com','runoob'=>'runoob.com','taobao'=>'taobao.com');
@keys=keys %data;
$size=@keys;
print "1-哈希大小 ：$size\n";

@values=values %data;
$size=@values;
print "2-哈希大小：$size\n";

print "3==================================\n";
%data2=('google'=>'google.com','runoob'=>'runoob.com','taobao'=>'taobao.com');
#删除哈希中的指定元素
delete $data{'taobao'};
@keys=keys %data;
$size=@keys;
print "3-哈希大小：$size\n";

print "4:迭代哈希：\n";
%data=('google'=>'google.com','runoob'=>'runoob.com','taobao'=>'taobao.com');
foreach $key(keys %data){
	print "$data{$key}\n";
}

print "5:迭代哈希：\n";
%data2=('google'=>'google.com','runoob'=>'runoob.com','taobao'=>'taobao.com');
while(($key,$value)=each(%data)){
	print "$data{$key}\n";
}
