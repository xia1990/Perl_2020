#!/usr/bin/perl 


$file1="build_id-br-ibiza.mk";
open(FILE1,$file1);
open(FILE2,">file2.txt");

@array=<FILE1>;
foreach(@array){
	if($_=~/BUILD_ID_PREFIX=/){
		@build_id_prefix=split(/=/,$_);
		$BUILD_ID_PREFIX=$build_id_prefix[1];
	}
	if($_=~/BUILD_ID=/){
		@ID=split(/-/,$_);
		$NEXT_ID=$ID[1]+1;
		$_=~s/BUILD_ID\=\$\(BUILD\_ID\_PREFIX\)\-[0-9]*/BUILD_ID\=\$\(BUILD\_ID\_PREFIX\)\-$NEXT_ID/;
	}
	print FILE2 "$_";
}
close(FILE1);
close(FILE2);
