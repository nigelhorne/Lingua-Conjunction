#!/usr/bin/env perl

use strict;
use warnings;
use Test::Most tests => 9;

delete $ENV{'LC_ALL'};
$ENV{'LANGUAGE'} = 'en';

use_ok('Lingua::Conjunction');

ok( 'A' eq conjunction( qw( A ) ) );
ok( 'A and C' eq conjunction( qw( A C ) ) );
is(conjunction('A', ' ', 'C'), 'A and C', 'Spaces not included in the list');
ok( 'A, B, and C' eq conjunction( qw( A B C ) ) );

Lingua::Conjunction->connector_type('or');

ok( 'A' eq conjunction( qw( A ) ) );
ok( 'A or C' eq conjunction( qw( A C ) ) );
ok( 'A, B, or C' eq conjunction( qw( A B C ) ) );

Lingua::Conjunction->penultimate();

is('A, B or C', conjunction(qw( A B C )), 'Remove the Oxford comma');
