#!/usr/bin/perl -w

#去除字符串左边的空格
sub ltrim{
	my $s=shift;
	$s=~s/^\s+//;
	return $s;
}

#去除字符串右边的空格
sub rtrim{
	my $s=shift;
	$s=~s/\s+$//;
	return $s;
}

#去除两边的空格
sub trim{
	my $s=shift;
	$s=~s/^\s+|\s+$//g;
	return $s;
}

my $s="		hello	";
printf "<%s>\n",ltrim($s);
printf "<%s>\n",rtrim($s);
printf "<%s>\n",trim($s);
