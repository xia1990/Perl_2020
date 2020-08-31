#!/usr/bin/perl

@months=qw(一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月);
@days=qw(星期天 星期一 星期二 星期三 星期四 星期五 星期六);
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();
print "$mday $months[$mon] $days[$wday]\n";

$datestring=localtime();
print "时间日期为:$datestring\n";

$gmt_datestring=gmtime();
print "GMT时间日期为：$gmt_datestring\n";

print "=============================\n";
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime();
printf("格式化时间：HH:MM:SS\n");
printf("%02d:%02d:%02d\n",$hour,$min,$sec);

print "=============================\n";
$epoc=time();
print "从1970年1月1日起累计的秒数为：$epoc\n";


print "=============================\n";
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
print "当前时间和日期:";
printf("%d-%d-%d %d:%d:%d",$year+1900,$mon+1,$mday,$hour,$min,$sec);
print "\n";

$epoc=time();
$epoc=$epoc-24*60*60;
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($epoc);
print "昨天时间和日期:";
printf("%d-%d-%d %d:%d:%d\n",$year+1900,$mon+1,$mday,$hour,$min,$sec);


print "===============================2\n";
use POSIX qw(strftime);
$datestring=strftime "%Y-%m-%d %H:%M:%S",localtime;
printf("时间日期-$datestring\n");

$datestring=strftime "%Y-%m-%d %H:%M:%s",gmtime;
printf("时间日期-$datestring\n");
