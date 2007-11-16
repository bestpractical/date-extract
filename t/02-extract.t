#!perl -T
use strict;
use warnings;
use Test::More tests => 25;
use Date::Extract;
use Test::MockTime 'set_fixed_time';

# a Friday. The time I wrote this line of code, in fact
set_fixed_time('2007-08-03T00:36:52Z');

my $parser = Date::Extract->new(prefer_future => 1);

sub extract_is {
    my ($in, $expected) = @_;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    my $dt = $parser->extract($in);
    ok($dt, "got a result");
    #is($dt->ymd, $expected, "extracts '$in' to $expected");
}

# days relative to today {{{
extract_is(today     => "2007-08-03");
extract_is(tomorrow  => "2007-08-04");
extract_is(yesterday => "2007-08-02");
extract_is(tonight   => "2007-08-03");
# }}}
# days of the week {{{
extract_is("saturday"  => "2007-08-05");
extract_is("sunday"    => "2007-08-06");
extract_is("monday"    => "2007-08-07");
extract_is("tuesday"   => "2007-08-08");
extract_is("wednesday" => "2007-08-09");
extract_is("thursday"  => "2007-08-10");
extract_is("friday"    => "2007-08-11");
# }}}
# "last" days of the week {{{
extract_is("last friday"    => "2007-07-27");
extract_is("last saturday"  => "2007-07-28");
extract_is("last sunday"    => "2007-07-29");
extract_is("last monday"    => "2007-07-30");
extract_is("last tuesday"   => "2007-07-31");
extract_is("last wednesday" => "2007-08-01");
extract_is("last thursday"  => "2007-08-02");
# }}}
# "next" days of the week {{{
extract_is("next saturday"  => "2007-08-05");
extract_is("next sunday"    => "2007-08-06");
extract_is("next monday"    => "2007-08-07");
extract_is("next tuesday"   => "2007-08-08");
extract_is("next wednesday" => "2007-08-09");
extract_is("next thursday"  => "2007-08-10");
extract_is("next friday"    => "2007-08-11");
# }}}

