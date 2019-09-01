#!/usr/bin/perl

sub Hello {
  print "hello world\n";
}

Hello();

sub Avg {
  # get all parameters
  $n = scalar(@_);
  $sum = 0;
  foreach $i (@_) {
    $sum += $i;
  }
  $sum / $n;
}

$avg = Avg(1,2,3,4,5);
print "Avg(1,2,3,4,5) = $avg\n";

sub PrintList {
  my @list = @_;
  print "list: @list\n"; 
}

PrintList(1,(2,3,4),5,(6,7));

sub PrintHash {
  my (%hash) = @_;
  foreach my $key (keys %hash) {
    my $value = $hash{$key};
    print "{$key: $value} ";
  }
  print "\n";
}

%h = (1,'hello',2,'world',3,'!');
PrintHash(%h);

sub AddTwo {
  $_[0] + $_[1];
}

$add2 = AddTwo(1,3);
print "AddTwo(1,3) = $add2\n";

# my: private variable
# local: give temperary value to global variable
$str = "hello";
sub PrintMe {
  print "\$str = $str in PrintMe\n";
}
sub PrintHello {
  my $str = "hello world!";
  PrintMe();
  print "\$str = $str in PrintHello\n";
}
PrintHello();

sub PrintHello2 {
  local $str = "hello perl!";
  PrintMe();
  print "\$str = $str in PrintHello2\n";
}
PrintHello2();
print "\$str = $str outside\n";

# static variable
use feature 'state';

sub PrintCount {
  state $cnt = 0;
  print "\$cnt = $cnt\n";
  $cnt++;
}
PrintCount() for (1..3);


