#!perl -T
use strict;
use warnings;
use Test::More tests => 25;
use Date::Glean;
use Test::MockTime 'set_fixed_time';

# a Friday. The time I wrote this line of code, in fact
set_fixed_time('2007-08-03T00:36:52Z');

my $parser = Date::Glean->new(prefer_future => 1);

# days relative to today {{{
my $dt = $parser->glean_date("today");
is($dt->ymd, "2007-08-03", "gleans 'today'");

$dt = $parser->glean_date("tomorrow");
is($dt->ymd, "2007-08-04", "gleans 'tomorrow'");

$dt = $parser->glean_date("yesterday");
is($dt->ymd, "2007-08-02", "gleans 'yesterday'");

$dt = $parser->glean_date("tonight");
is($dt->ymd, "2007-08-03", "gleans 'tonight'");
# }}}
# days of the week {{{
$dt = $parser->glean_date("saturday");
is($dt->ymd, "2007-08-05", "gleans 'saturday'");

$dt = $parser->glean_date("sunday");
is($dt->ymd, "2007-08-06", "gleans 'sunday'");

$dt = $parser->glean_date("monday");
is($dt->ymd, "2007-08-07", "gleans 'monday'");

$dt = $parser->glean_date("tuesday");
is($dt->ymd, "2007-08-08", "gleans 'tuesday'");

$dt = $parser->glean_date("wednesday");
is($dt->ymd, "2007-08-09", "gleans 'wednesday'");

$dt = $parser->glean_date("thursday");
is($dt->ymd, "2007-08-10", "gleans 'thursday'");

$dt = $parser->glean_date("friday");
is($dt->ymd, "2007-08-11", "gleans 'friday'");
# }}}
# "last" days of the week {{{
$dt = $parser->glean_date("last friday");
is($dt->ymd, "2007-07-27", "gleans 'last friday'");

$dt = $parser->glean_date("last saturday");
is($dt->ymd, "2007-07-28", "gleans 'last saturday'");

$dt = $parser->glean_date("last sunday");
is($dt->ymd, "2007-07-29", "gleans last 'sunday'");

$dt = $parser->glean_date("last monday");
is($dt->ymd, "2007-07-30", "gleans 'last monday'");

$dt = $parser->glean_date("last tuesday");
is($dt->ymd, "2007-07-31", "gleans 'last tuesday'");

$dt = $parser->glean_date("last wednesday");
is($dt->ymd, "2007-08-01", "gleans 'last wednesday'");

$dt = $parser->glean_date("last thursday");
is($dt->ymd, "2007-08-02", "gleans 'last thursday'");
# }}}
# "next" days of the week {{{
$dt = $parser->glean_date("next saturday");
is($dt->ymd, "2007-08-05", "gleans 'next saturday'");

$dt = $parser->glean_date("next sunday");
is($dt->ymd, "2007-08-06", "gleans 'next sunday'");

$dt = $parser->glean_date("next monday");
is($dt->ymd, "2007-08-07", "gleans 'next monday'");

$dt = $parser->glean_date("next tuesday");
is($dt->ymd, "2007-08-08", "gleans 'next tuesday'");

$dt = $parser->glean_date("next wednesday");
is($dt->ymd, "2007-08-09", "gleans 'next wednesday'");

$dt = $parser->glean_date("next thursday");
is($dt->ymd, "2007-08-10", "gleans 'next thursday'");

$dt = $parser->glean_date("next friday");
is($dt->ymd, "2007-08-11", "gleans 'next friday'");
# }}}

