#!/usr/bin/perl

# variable
# you do not need to specify type in perl
$v1 = 123;
$v2 = "abc";

print "\$v1 = $v1\n";
print "\$v2 = $v2\n";

# array
@arr = (1,2,3);

print "\$arr[0] = $arr[0]\n";
print "\$arr[1] = $arr[1]\n";

# hash
%h1 = ('a' => 1, 'b' => 2);
%h2 = ('abc', 1, 'def', 2);

print "\$h1{'a'} = $h1{'a'}\n";
print "\$h2{'def'} = $h2{'def'}\n";

# copy array
@arr_copy = @arr;
# array size
$arr_size = @arr;

print "\@arr_copy = @arr_copy\n";
print "\$arr_size = $arr_size\n";

# calculations
$str = "hello" . "world";
$num = 5 + 10;
$mul = 4 * 5;
$mix = $str . $num;

print "\$str = $str\n";
print "\$mix = $mix\n";

# special characters
print "file name: " . __FILE__ . "\n";
print "line number: " . __LINE__ . "\n";
print "package name: " . __PACKAGE__ . "\n";

# v string
$foo = v102.111.111;
print "\$foo = $foo\n";
