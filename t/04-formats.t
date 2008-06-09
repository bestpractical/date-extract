#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Date::Extract;

my %formats = (
    'today'    =>
        sub { is($_->ymd, DateTime->today->ymd, "today") },
    'tomorrow' =>
        sub { is($_->ymd, DateTime->today->add(days => 1)->ymd, "tomorrow") },
    'yesterday' =>
        sub { is($_->ymd, DateTime->today->add(days => -1)->ymd, "yesterday") },
    'last Friday' =>
        sub {},
    'next Monday' =>
        sub {},
    'previous Sat' =>
        sub {},
    'Monday' =>
        sub {},
    'Mon' =>
        sub {},
    'November 13th, 1986' =>
        sub {},
    'Nov 13, 1986' =>
        sub {},
    'November 13th' =>
        sub {},
    'Nov 13' =>
        sub {},
    '13 Nov' =>
        sub {},
    '13th November' =>
        sub {},
    '1986/11/13' =>
        sub {},
    '1986-11-13' =>
        sub {},
    '11-13-86' =>
        sub {},
    '11/13/1986' =>
        sub {},
);

plan tests => 2 * keys(%formats);

while (my ($input, $checker) = each %formats) {
    my $got = Date::Extract->extract($input);
    ok($got, "got a date out of $input");

    unless ($got) {
        fail("No date parsed, so no use running the checker");
        next;
    }

    local $_ = $got;
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    $checker->();
}

