#!perl -wT

use strict;
use warnings;
use Test::Most;

if($ENV{AUTHOR_TESTING}) {
	eval 'use Test::Pod::Snippets';

	if($@) {
		plan(skip_all => 'Test::Pod::Snippets required for testing POD code snippets');
	} else {
		my @modules = qw/ Lingua::Conjunction /;

		Test::Pod::Snippets->new()->runtest(module => $_, testgroup => 1) for @modules;

		done_testing();
	}
} else {
	plan(skip_all => 'Author tests not required for installation');
}
