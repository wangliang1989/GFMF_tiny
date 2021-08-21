#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);
use Time::Local;

die "cali_11_10.txt not exist!" unless -e "cali_11_10.txt";
my @wangliang = getdata("wangliang_cali_11_10.txt");
my @you = getdata("cali_11_10.txt");

system "gmt begin histgram";
draw("-BWStr+t'Wangliang result' -Gred", @wangliang);
draw("-BWStr+t'Your result' -Gblue -Y10c", @you);
system "gmt end show";

sub getdata{
    my ($in) = @_;
    my @out;
    open (IN, "< $in") or die "cannot open $in";
    foreach (<IN>) {
        #2018-08-15T00:28:20.86
        my ($origin) = split m/\s+/;
        my ($time) = (split "T", $origin)[1];
        my ($hour, $min, $sec) = split ":", $time;
        $sec = (($hour * 60) + $min) * 60 + $sec;
        push @out, $sec;
    }
    close(IN);
    return @out;
}
sub draw {
    my $cmd = shift;
    $cmd = "-JX15c/7c -R0/86400/0/80 " . "-Bxa7200f3600+l'Time (s)' -Byaf $cmd";
    open (GMT, "| gmt histogram -D -W1p -T3600 $cmd") or die;
    print GMT "$_\n" foreach (@_);
    close(GMT);
}
