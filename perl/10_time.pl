#!/usr/bin/perl

@months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
@days = qw(Sun Mon Tue Wed Thu Fri Sat);

($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime();
print "$mday $months[$mon] $days[$wday]\n";

$datestr = localtime();
print "current time: ", $datestr, "\n";

$gmtdatestr = gmtime();
print "GMT time: " . $gmtdatestr . "\n";

printf("formatted time: %02d:%02d:%02d\n", $hour, $min, $sec);

$unix = time();
print "unix time(s): " . $unix . "\n";

printf("formatted date and time: %d-%02d-%02d %02d:%02d:%02d\n", $year+1900, $mon+1, $mday, $hour, $min, $sec);

use POSIX qw(strftime);
$pstr = strftime "%Y-%m-%d %H:%M:%S", localtime;
printf("strftime local: $pstr\n");
$gmtpstr = strftime "%Y-%m-%d %H:%M:%S", gmtime;
printf("strftime GMT: $gmtpstr\n");