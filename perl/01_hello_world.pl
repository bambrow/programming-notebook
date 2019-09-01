#!/usr/bin/perl

# this is a comment
print "hello world!\n";
print 'hello world\n';
print "\n";

=pod
these
are
multiple
comments
=cut

$a = 10;
print "a = $a\n";
print 'a = $a\n';
print "\n";

$var = <<"EOF";
This is an example of here-document
We can print multiple lines
Like: a = $a
EOF

print "$var\n";
