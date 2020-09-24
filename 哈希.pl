#!/usr/bin/perl -w


#哈希的定义
%user=('a'=>1,'b'=>2);
#遍历哈希
while(my($key,$value)=each%user){
	#print "$key,$value\n";
	print "";
}
#add
$user{'c'}=3;
$user{'d'}=4;
#根据哈希键得到哈希值
print "$user{'a'}\n";
#delete
delete $user{'a'} or die "key 不存在,$!";

while(my($k,$v)=each %user){
	print "$k,$v\n";
}


#嵌套哈希
%info=(
'fruit'=>{'apple'=>1,'banana'=>2},
'vegetable'=>{'potato'=>1},
'family'=>['wife'=>1,'husband'=>2,'son'=>3]
);


#add
$info{'vegetable'}={'tomato'=>2};
$info{'family'}[3]='father';
$info{'family'}[4]='mather';

print "=========================\n";
#遍历
for $i (sort keys %info){
	print "$i\n";
	for $j (sort keys %{ $info{$i} } ){
		print "$info{$i}{$j}\n";
	}
}
