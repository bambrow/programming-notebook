#!/usr/bin/perl

$a = 1;

if ($a == 0) {
  print "got 0\n";
} elsif ($a == 1) {
  print "got 1\n"; 
} else {
  print "got other value\n";
}

unless ($a >= 2) {
  print "a is smaller than 2\n";
} elsif ($a == 3) {
  print "got 3\n";
} else {
  print "got other value\n";
}

$str = ($a == 1) ? "got 1" : "not 1";
print ("$str\n");