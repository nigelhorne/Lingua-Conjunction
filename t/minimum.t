#!/usr/bin/env perl

use strict;
use warnings;
use Test::Most;

BEGIN {
	if($ENV{AUTHOR_TESTING}) {
		eval {
			require Test::MinimumVersion;
		};
		if($@) {
			plan(skip_all => 'Test::MininumVeresion not installed');
		} else {
			import Test::MinimumVersion;
			all_minimum_version_from_metayml_ok();
		}
	} else {
		plan(skip_all => 'Author tests not required for installation');
	}
}
