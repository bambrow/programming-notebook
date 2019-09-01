#!/usr/bin/perl

# reference
# $scalarref = \$foo;
# $arrayref = \@ARGV;
# $hashref =%ENV;
# $coderef = \&handler;
# $globref = \*foo;

$var = 10;
$sref = \$var;

print ref($sref) . "\n";
print "\$var = " . $$sref . "\n";
print "\$var = " , $$sref , "\n";

@var = (1,2,3);
$aref = \@var;

print ref($aref) . "\n";
print "\@var = " . @$aref . "\n";
print "\@var = " , @$aref , "\n";

%var = ('k1', 10, 'k2', 20);
$href = \%var;

print ref($href) . "\n";
print "\%var = " . %$href . "\n";
print "\%var = " , %$href , "\n";

sub PrintHash {
  my (%hash) = @_;
  my $index = 0;
  foreach $i (%hash) {
    print "$i";
    $index++;
    next if $index % 2 == 0;
    print ":";
  } continue {
    print ";" if $index % 2 == 0;
    print " ";
  }
  print "\n";
}

%hash = ('k1', 1, 'k2', 2, 'k3', 3);
$cref = \&PrintHash;

print ref($cref) . "\n";
&$cref(%hash);
