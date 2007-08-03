#!perl -T
use strict;
use warnings;
use Test::More tests => 24;
use Date::Glean;

my $parser = Date::Glean->new();
ok($parser, "got a parser out of Date::Glean->new");
ok($parser->isa("Date::Glean"), "new parser is a Date::Glean object");

# conflict {{{
for my $preference (qw/first last earliest latest all all_cron/)
{
    $parser = Date::Glean->new(conflict => $preference);
    ok($parser, "got a parser out of Date::Glean->new(conflict => 'first')");
    ok($parser->isa("Date::Glean"), "new parser is a Date::Glean object");
}

$parser = eval { Date::Glean->new(conflict => "invalid argument") };
ok(!$parser, "did NOT get a parser out of Date::Glean->new(conflict => 'invalid argument')");
like($@, qr/Invalid `conflict` passed to constructor/, "(conflict => 'invalid argument') gave a sensible error message");
like($@, qr/01-new\.t/, "invalid `conflict` error reported from caller's perspective");

# }}}
# prefer_future, prefer_past {{{
for my $prefer (qw/prefer_future prefer_past/)
{
    $parser = Date::Glean->new($prefer => 1);
    ok($parser, "got a parser out of Date::Glean->new($prefer => 1)");
    ok($parser->isa("Date::Glean"), "new parser is a Date::Glean object");
}

$parser = Date::Glean->new(prefer_future => 1, prefer_past => 1);
ok(!$parser, "did NOT get a parser when specifying prefer future AND past");
like($@, qr/Conflicting options `prefer_future` and `prefer_past` found in constructor/, "prefer_future and prefer_past together gives a specific error");
like($@, qr/01-new\.t/, "conflicting options error reported from caller's perspective");
# }}}

