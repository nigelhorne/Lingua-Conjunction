#!/usr/bin/env perl

use strict;
use warnings;
use Test::Most tests => 4;

$ENV{'LANGUAGE'} = 'fr';

use_ok('Lingua::Conjunction');

delete $ENV{'LANGUAGE'};
$ENV{'LC_MESSAGES'} = 'fr';

is(conjunction(qw( A B C )), 'A, B et C', 'LC_MESSAGES is honoured');

Lingua::Conjunction->lang('de');

is(conjunction(qw( A B C )), 'A, B, und C', 'lang() switches languages');
is('A und C', conjunction('A', undef, 'C'), 'undef is not included in the list')
