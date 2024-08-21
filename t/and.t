#!/usr/bin/env perl

use strict;
use warnings;
use Test::Most tests => 7;
use Test::NoWarnings;

BEGIN {
	delete $ENV{'LC_ALL'};
	$ENV{'LANGUAGE'} = 'en';
}

use_ok('Lingua::Conjunction');

cmp_ok(conjunction('A', 'B'), 'eq', 'A and B');

cmp_ok(conjunction('A', ' '), 'eq', 'A', 'blank strings ignored');

cmp_ok(conjunction('', 'B'), 'eq', 'B', 'empty strings ignored');

Lingua::Conjunction->lang('de');	# Changes the language to German

cmp_ok(conjunction('A', 'B'), 'eq', 'A und B');

Lingua::Conjunction->lang('fr');	# Changes the language to French

cmp_ok(conjunction('A', 'B'), 'eq', 'A et B');
