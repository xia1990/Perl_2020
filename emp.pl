#!/usr/bin/perl

#如果要使用Person.pm需要先加载Person.pm的路径
use FindBin;
use lib ($FindBin::RealBin);
use Person;

$object=new Person("小明","王",1001);
$firstName=$object->getFirstName();
print "设置前姓名为：$firstName\n";

$object->setFirstName("小强");
$firstName=$object->getFirstName();
print "设置后姓名为：$firstName\n";
