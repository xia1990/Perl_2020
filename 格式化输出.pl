#!/usr/bin/perl 


format TITLE=
************************
名称	价格
************************
.

format CONT=
------------------------
@<<<<<<<<<<<<<<<<@<<<<<
$name,$price
------------------------
.

@name=('红豆奶茶','经典奶茶','香芋奶茶','珍珠奶茶','西米露');
@price=(15,18,20,18,19);
$count=0;
#$~ = STUDENT;和$^ = STUDENT_TOP;必须写在if语{}内
if(open(FILE,">milk.txt")){
	select(FILE);
	$~=CONT;
	$^=TITLE;
	$count=0;
	foreach (@name){
		$name=$_;
		$price=$price[$count++];
		write;
	}
	close(FILE);
}
