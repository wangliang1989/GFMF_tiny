#!/usr/bin/env perl
use strict;
use warnings;

my ($workdir) = @ARGV;
die unless defined $workdir and -d $workdir;
# 路径 $workdir 内的所有内容都可能被删除，所以务必保证 $workdir 内本来是空的
system "p-search.pl cali.conf 20180815 $workdir";
