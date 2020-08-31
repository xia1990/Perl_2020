#!/usr/bin/perl

foreach('Google','Runoob','Taobao'){
	#print $_;
	print;
	print "\n";
}

print "$]\n";

print "1==================\n";
use Config::INiFiles;
my $cfg=new Config::IniFiles(-file=>"configfile.ini");
my $value=$cfg->val('Section','Parameter');
