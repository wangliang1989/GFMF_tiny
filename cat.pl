#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);
use Time::Local;
require "$ENV{GFMF}/script/getcatlog.pm";

my $config = "cali";
my @ths = (11);
my @windows = (10);

my @days = ("20180815");
foreach my $th (@ths) {
    foreach my $window (@windows) {
        open (OUT, "> ${config}_${th}_${window}.txt") or die;
        foreach my $day (@days) {
            print "$day $th*MAD $window sec\n";
            my @pt = input("$day/result_${config}.txt", $th);
            my @pt_sort = sort_cc(@pt);
            my @pt_select = check($th, $window, @pt_sort);
            my @out = sort_time(@pt_select);
            foreach (@out) {print OUT "$_\n";}
        }
        close (OUT);
    }
}
