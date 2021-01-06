#!perl -T

use strict;

use Test::Most tests => 2;

BEGIN {
	use_ok('Lingua::Conjunction') || print 'Bail out!';
}

require_ok('Lingua::Conjunction') || print 'Bail out!';

diag("Testing Lingua::Conjunction $Lingua::Conjunction::VERSION, Perl $], $^X");
