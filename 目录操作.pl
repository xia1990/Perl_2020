#!/usr/bin/perl

$dir="/home/gaoyx/perl_work/*";
my @files=glob($dir);
foreach(@files){
	print $_."\n";
}

print "当前目录下所有.txt文件\n";
$dir="/home/gaoyx/perl_work/*.txt";
my @files=glob($dir);
foreach(@files){
	print $_."\n";
}

print "/tmp && /home下的所有文件\n";
$dir="/tmp/* /home/*";
@files=glob($dir);
foreach(@files){
	print $_."\n";
}

print "==============================1\n";
opendir(DIR,".") or die "无法打开目录，$!";
while($file=readdir DIR){
	print "$file\n";
}
closedir DIR;
