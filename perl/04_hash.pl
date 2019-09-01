#!/usr/bin/perl

%data = (1,"hello",2,"world");
$data{3} = ':)';

print "\$data{1} = $data{1}\n";
print "\$data{2} = $data{2}\n";
print "\$data{3} = $data{3}\n";

@arr = @data{1,2,3};
print "\@arr = @arr\n";

@ks = keys %data;
print "\@ks = @ks\n";

@vs = values %data;
print "\@vs = @vs\n";

if (exists($data{3})) {
  print "\$data{3} = $data{3}\n";
} else {
  print "\$data{3} does not exist\n";
}

delete $data{3};

if (exists($data{3})) {
  print "\$data{3} = $data{3}\n";
} else {
  print "\$data{3} does not exist\n";
}
