#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 7;

BEGIN { use_ok('Lingua::Conjunction') }

# Test case 1: Basic conjunction in English
Lingua::Conjunction->lang('en');
my $result = conjunction('Jack', 'Jill', 'Spot');
is($result, 'Jack, Jill, and Spot', 'English conjunction test');

# Test case 2: Disable Oxford comma
Lingua::Conjunction->penultimate(0);
$result = conjunction('Jack', 'Jill', 'Spot');
is($result, 'Jack, Jill and Spot', 'English without Oxford comma');

# Test case 3: Two-item list
$result = conjunction('Jack', 'Jill');
is($result, 'Jack and Jill', 'Two-item list test');

# Test case 4: Language test - Spanish
Lingua::Conjunction->lang('es');
$result = conjunction('Manzana', 'Naranja', 'Plátano');
is($result, 'Manzana, Naranja, y Plátano', 'Spanish conjunction test');

# Test case 5: Custom separator
Lingua::Conjunction->connector_type('or');
Lingua::Conjunction->separator('...');	# Since '.' means any character in regex, this checks the \Q works
$result = conjunction('Jack', 'Jill', 'Spot');
is($result, 'Jack... Jill... o Spot', 'Custom separator test');

# Test case 6: Unsupported language fallback
eval {
	Lingua::Conjunction->lang('xx');
};
like($@, qr/Undefined language/, 'Unsupported language throws error');
