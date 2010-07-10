#!/usr/bin/env perl
use warnings;
use strict;
use Test::More;

BEGIN { use_ok("Agmsc") }

ok( my $agmsc = Agmsc->new,
    "Agmsc->new" );

done_testing();


__DATA__
