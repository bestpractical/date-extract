#!perl -T
use strict;
use warnings;
use Test::More tests => 25;
use Date::Extract;
use Test::MockTime 'set_fixed_time';

# a Friday. The time I wrote this line of code, in fact
set_fixed_time('2007-08-03T00:36:52Z');

my $parser = Date::Extract->new(prefer_future => 1);

# days relative to today {{{
my $dt = $parser->extract_date("today");
is($dt->ymd, "2007-08-03", "extracts 'today'");

$dt = $parser->extract_date("tomorrow");
is($dt->ymd, "2007-08-04", "extracts 'tomorrow'");

$dt = $parser->extract_date("yesterday");
is($dt->ymd, "2007-08-02", "extracts 'yesterday'");

$dt = $parser->extract_date("tonight");
is($dt->ymd, "2007-08-03", "extracts 'tonight'");
# }}}
# days of the week {{{
$dt = $parser->extract_date("saturday");
is($dt->ymd, "2007-08-05", "extracts 'saturday'");

$dt = $parser->extract_date("sunday");
is($dt->ymd, "2007-08-06", "extracts 'sunday'");

$dt = $parser->extract_date("monday");
is($dt->ymd, "2007-08-07", "extracts 'monday'");

$dt = $parser->extract_date("tuesday");
is($dt->ymd, "2007-08-08", "extracts 'tuesday'");

$dt = $parser->extract_date("wednesday");
is($dt->ymd, "2007-08-09", "extracts 'wednesday'");

$dt = $parser->extract_date("thursday");
is($dt->ymd, "2007-08-10", "extracts 'thursday'");

$dt = $parser->extract_date("friday");
is($dt->ymd, "2007-08-11", "extracts 'friday'");
# }}}
# "last" days of the week {{{
$dt = $parser->extract_date("last friday");
is($dt->ymd, "2007-07-27", "extracts 'last friday'");

$dt = $parser->extract_date("last saturday");
is($dt->ymd, "2007-07-28", "extracts 'last saturday'");

$dt = $parser->extract_date("last sunday");
is($dt->ymd, "2007-07-29", "extracts last 'sunday'");

$dt = $parser->extract_date("last monday");
is($dt->ymd, "2007-07-30", "extracts 'last monday'");

$dt = $parser->extract_date("last tuesday");
is($dt->ymd, "2007-07-31", "extracts 'last tuesday'");

$dt = $parser->extract_date("last wednesday");
is($dt->ymd, "2007-08-01", "extracts 'last wednesday'");

$dt = $parser->extract_date("last thursday");
is($dt->ymd, "2007-08-02", "extracts 'last thursday'");
# }}}
# "next" days of the week {{{
$dt = $parser->extract_date("next saturday");
is($dt->ymd, "2007-08-05", "extracts 'next saturday'");

$dt = $parser->extract_date("next sunday");
is($dt->ymd, "2007-08-06", "extracts 'next sunday'");

$dt = $parser->extract_date("next monday");
is($dt->ymd, "2007-08-07", "extracts 'next monday'");

$dt = $parser->extract_date("next tuesday");
is($dt->ymd, "2007-08-08", "extracts 'next tuesday'");

$dt = $parser->extract_date("next wednesday");
is($dt->ymd, "2007-08-09", "extracts 'next wednesday'");

$dt = $parser->extract_date("next thursday");
is($dt->ymd, "2007-08-10", "extracts 'next thursday'");

$dt = $parser->extract_date("next friday");
is($dt->ymd, "2007-08-11", "extracts 'next friday'");
# }}}

