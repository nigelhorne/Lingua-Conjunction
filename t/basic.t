#!/usr/bin/env perl

use strict;
use warnings;
use Test::Most tests => 8;

use_ok('Lingua::Conjunction');

$ENV{'LANGUAGE'} = 'en';

ok( 'A' eq conjunction( qw( A ) ) );
ok( 'A and C' eq conjunction( qw( A C ) ) );
ok( 'A, B, and C' eq conjunction( qw( A B C ) ) );

Lingua::Conjunction->connector_type('or');

ok( 'A' eq conjunction( qw( A ) ) );
ok( 'A or C' eq conjunction( qw( A C ) ) );
ok( 'A, B, or C' eq conjunction( qw( A B C ) ) );

Lingua::Conjunction->penultimate();

is(conjunction(qw( A B C )), 'A, B or C', 'Remove the Oxford comma');
