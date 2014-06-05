#!perl -T
use strict;
use warnings;
use Test::More tests => 3;
use Test::MockTime 'set_fixed_time';
use Date::Extract;

# a Thursday. The time I wrote this line of code, in fact (in UTC)
set_fixed_time('2007-11-16T02:48:52Z');

my $in = "Today I see a boat. Tomorrow I'll see another. Yesterday I swam.";

my $parser;

$parser = Date::Extract->new(format => 'DateTime');
my $dt = $parser->extract($in);
is($dt->ymd, '2007-11-16', 'default: returns DateTime object');

$parser = Date::Extract->new(format => 'verbatim');
my $verbatim = $parser->extract($in);
is($verbatim, 'Today', 'returns verbatim text');

$parser = Date::Extract->new(format => 'epoch');
my $epoch = $parser->extract($in);
is($epoch, 1195171200, 'returns epoch');
