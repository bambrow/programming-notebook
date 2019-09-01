#!/usr/bin/perl

# while
$a = 1;
while ($a < 10) {
  print "$a ";
  $a = $a + 1;
}
print "\n";

# until
$b = 1;
until ($b > 10) {
  print "$b ";
  $b = $b + 1;
}
print "\n";

# for
for ($i = 0; $i < 10; $i = $i + 1) {
  print "$i ";
}
print "\n";

# foreach
@list = (1,3,5,7,9);
foreach $i (@list) {
  print "$i ";
}
print "\n";

# last
$c = 1;
while ($c < 20) {
  print "$c ";
  if ($c > 5) {
    last;
  }
  $c = $c + 1;
}
print "\n";

# continue
foreach $i (@list) {
  print "$i ";
} continue {
  last if $i == 3;
}
print "\n";

# next
foreach $i (@list) {
  next if $i == 3;
  print "$i ";
} continue {
  print "[skipped] " if $i == 3;
}
print "\n";

# redo
foreach $i (@list) {
  $i = $i + 2;
  next if $i == 3;
  redo if $i == 5;
  print "$i ";
} continue {
  print "[skipped] " if $i == 3;
}
print "\n";