package Date::Extract;
use strict;
use warnings;
use DateTime;

=head1 NAME

Date::Extract - simple date extraction

=head1 VERSION

Version 0.00 released ???

=cut

our $VERSION = '0.00';

=head1 SYNOPSIS

    my $parser = Date::Extract->new();
    my $dt = $parser->extract_date($arbitrary_text);
    if ($parser->success) {
        return $dt->ymd;
    } else {
        die "no parse for $date_time";
    }

=head1 MOTIVATION

There are already a few modules for getting a date out of a string.
L<DateTime::Format::Natural> should be your first choice. There's also
L<Time::ParseDate> which fits some very specific formats. Finally, you can
coerce L<Date::Manip> to do your bidding.

But I needed something that will take an arbitrary block of text, search it
for something that looks like a date string, and build a L<DateTime> object
out of it. This module fills this niche. By design it will produce few false
positives. This means it will not catch nearly everything that looks like a
date string.

=head1 METHODS

=head2 new PARAMHASH => C<Date::Extract>

=head3 arguments

=over 4

=item time_zone

Forces a particular time zone to be set (this actually matters, as "Tuesday"
on Monday at 11 PM means something different than "Tuesday" on Tuesday at 1
AM).

By default it will use the "floating" time zone. See the documentation for
L<DateTime>.

=item prefer_future

If a bare weekday appears, setting this option will interpret it as the
nearest such weekday in the future. This is the default.

Note that this means that, on a Friday, "Friday" will return the next Friday.

=item prefer_past

If a bare weekday appears, setting this option will interpret it as the
nearest such weekday in the past.

Note that this means that, on a Friday, "Friday" will return the previous
Friday.

=item conflict

If the text has multiple possible dates, then this argument determines which
date will be returned. By default it's 'first'.

=over 4

=item first

Returns the first date found in the string.

=item last

Returns the final date found in the string.

=item earliest

Returns the date found in the string that chronologically precedes any other
date in the string.

=item latest

Returns the date found in the string that chronologically follows any other
date in the string.

=item all

Returns all dates found in the string, in the order they were found in the
strong.

=item all_cron

Returns all dates found in the string, in chronological order.

=back

=cut

sub new {
    my $class = shift;
    my %args = (
        conflict => 'first',
        success => undef,
        @_,
    );

    if ($args{conflict} ne 'first'
     && $args{conflict} ne 'last'
     && $args{conflict} ne 'earliest'
     && $args{conflict} ne 'latest'
     && $args{conflict} ne 'all'
     && $args{conflict} ne 'all_cron') {
        require Carp;
        Carp::croak "Invalid `conflict` passed to constructor: expected 'first', 'last', earliest', 'latest', 'all', or 'all_cron'.";
    }

    my $self = bless \%args, ref($class) || $class;

    return $self;
}

=head2 extract_date text => C<DateTime>

Takes an arbitrary amount of text and extracts one or more dates from it. The
return value will always be a list of valid L<DateTime> objects. Be sure to
check the C<success> method before using them, though.

See the documentation of C<new> for the configuration of this method.

You may reuse a parser for multiple calls to C<extract_date>.

=cut

sub extract_date {
    my ($self, $text) = @_;
    $self->{success} = 0;

    my $best = DateTime->now;

    return $best;
}

=head2 success => C<boolean>

Returns whether or not the most recent C<extract_date> successfully extracted a
date. This will be C<undef> if C<extract_date> has not been run at all yet.

=cut

sub success {
    my ($self) = @_;
    return $self->{success};
}

=head1 CAVEATS

This module is I<intentionally> very simple. Surprises are I<not> welcome
here.

=head1 SEE ALSO

L<DateTime::Format::Natural>, L<Time::ParseDate>, L<Date::Manip>

=head1 AUTHOR

Shawn M Moore, C<< <sartak at gmail.com> >>

=head1 BUGS

No known bugs at this point.

Please report any bugs or feature requests to
C<bug-date-extract at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Date-Extract>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Date::Extract

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Date-Extract>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Date-Extract>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Date-Extract>

=item * Search CPAN

L<http://search.cpan.org/dist/Date-Extract>

=back

=head1 ACKNOWLEDGEMENTS

Thanks to Steven Schubiger for writing the fine L<DateTime::Format::Natural>.
We still use it, but it doesn't quite fill all the particular needs we have.

=head1 COPYRIGHT & LICENSE

Copyright 2007 Best Practical Solutions.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Date::Extract

