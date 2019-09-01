#!/usr/bin/perl

# basics [skipped]
# + - * / % **
# basics [skipped]
# == != > < >= <= 

# $a <=> $b
# will return -1 if $a < $b
# will return 0 if $a == $b
# will return 1 if $a > $b

# string comparison
# $a lt $b
# true if $a < $b

# $a gt $b
# true if $a > $b

# $a le $b
# true if $a <= $b

# $a ge $b
# true if $a >= $b

# $a eq $b
# true if $a == $b

# $a ne $b
# true if $a != $b

# $a cmp $b
# will return -1 if $a < $b
# will return 0 if $a == $b
# will return 1 if $a > $b

# basics [skipped]
# = += -= *= /= %= **= ++ --

# basics [skipped]
# & | ^ ~ << >>

# basics [skipped]
# and && or || not

# quote operators
# q adds ''
$a = 10;
$b = q{\$a = $a};
print "q{\$a = $a} = $b\n";

# qq adds ""
$b = qq{\$a = $a};
print "qq{\$a = $a} = $b\n";

# qx adds ``
$t = qx{date};
print "qx{date} = $t\n";

# others
# . concatenates strings
print "hello" . "world\n";

# x repeats strings
print "hello" x 3;
print "\n";

# .. returns a range
@c = (1..5);
print "(1..5) = @c\n";