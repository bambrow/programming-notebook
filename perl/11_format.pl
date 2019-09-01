#!/usr/bin/perl

# format FormatName = 
# fieldline
# v1, v2, v3
# fieldline
# v1, v2
# .

format EMPLOYEE =
===================================
@<<<<<<<<<<<<<<<<<<<<<< @<< 
$name, $age
@#####.##
$salary
===================================
.
 
format EMPLOYEE_TOP =
===================================
Name                    Age Page @<
                                 $%
=================================== 
.
 
select(STDOUT);
$~ = EMPLOYEE;
$^ = EMPLOYEE_TOP;
 
@n = ("Alice", "Bob", "David", "Eric");
@a  = (21,23,27,26);
@s = (2000, 3000.123, 4000, 5000.234);
 
$i = 0;
foreach (@n) {
   $name = $_;
   $age = $a[$i];
   $salary = $s[$i++];
   write;
}