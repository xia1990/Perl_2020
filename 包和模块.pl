#!/usr/bin/perl

$i=1;
print "包名：",__PACKAGE__,"$i\n";

package Foo;
$i=10;
print "package name:",__PACKAGE__,"$i\n";

package main;
$i=100;
print "package name:",__PACKAGE__,"$i\n";
print "package name:",__PACKAGE__,"$Foo::i\n";

1;

print "1======================\n";
package Foo;
print "BEGIN and BLOCK example\n";

BEGIN{
	print "这是BEGIN语句块\n";
}

END{
	print "这是END语句块\n";
}
1;
