#!/usr/bin/perl -w

use 5.012;

sub greet{
	state @names;
	my $name=shift;
	print "hi,$name。";

	#if(defined $last_person){
	#	print "$last_person is also here!\n";
	#}else{
	#	print "You are the first one here!\n";
	#}
	#$last_person=$name;
	if(@names){
		print "I have seen:@names!\n";
	}else{
		print "You are the first one here!\n";
	}
	push @names,$name;
}

&greet("Fred");
&greet("borneo");
&greet("baobao");
