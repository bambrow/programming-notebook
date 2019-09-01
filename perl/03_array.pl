#!/usr/bin/perl

@arr = (1,2,3);

print "\$arr[0] = $arr[0]\n";
print "\@arr = @arr\n";

# qw string array
@arr2 = qw/this is an array/;

print "\$arr2[0] = $arr2[0]\n";
print "\@arr2 = @arr2\n";

# reverse access
print "\$arr[-1] = $arr[-1]\n";
print "\$arr2[-1] = $arr2[-1]\n";

# range
@v10 = (1..10);
@vaz = (a..z);

print "\@v10 = @v10\n";
print "\@vaz = @vaz\n";

# array size
@array = (1,2,3);
$array[50] = 4;

$size = @array;
$max_index = $#array;

print "size: $size\n";
print "max_index: $max_index\n";

# add and delete
push(@arr, 4);
unshift(@arr, 0);
print "\@arr = @arr\n";

pop(@arr);
shift(@arr);
print "\@arr = @arr\n";

# slice
@arr3 = @arr2[0,2];
@arr4 = @arr2[0..2];
print "\@arr3 = @arr3\n";
print "\@arr4 = @arr4\n";

# splice
@nums = (1..20);
print "\@nums = @nums\n";
splice(@nums, 5, 5, 21..25);
print "\@nums = @nums\n";

# split
$s1 = "hello";
$s2 = "this is a string";
@s1 = split('', $s1);
@s2 = split(' ', $s2);
print "\@s1 = @s1\n";
print "\@s2 = @s2\n";

# join
$ss1 = join('', @s1);
$ss2 = join(' ', @s2);
print "\$ss1 = $ss1\n";
print "\$ss2 = $ss2\n";

# sort
@arr5 = sort(@arr2);
print "\@arr5 = @arr5\n";

# combine arrays
@numbers = (1,3,(4,5,6));
print "\@numbers = @numbers\n";
@odd = (1,3,5);
@even = (2,4,6);
@numbers2 = (@odd, @even);
print "\@numbers2 = @numbers2\n";

# select elements
$var1 = (1,2,3,4,5)[4];
@var2 = (1,2,3,4,5)[1..3];
print "\$var1 = $var1\n";
print "\@var2 = @var2\n";
