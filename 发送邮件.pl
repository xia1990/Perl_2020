#!/usr/bin/perl

$to="454963081@qq.com";
$form="18016074089@163.com";
$subject="菜鸟教程perl发送邮件测试";
$message="这是一封使用PERL发送的邮件！";
open(MAIL,"|/usr/sbin/sendmail -t");
print MAIL "TO:$to\n";
print MAIL "FORM:$from\n";
print MAIL "Subject:$subject\n\n";
print MAIL $message;
close(MAIL);
print "邮件发送成功\n";
