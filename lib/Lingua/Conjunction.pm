package Lingua::Conjunction;

# ABSTRACT: Convert lists into simple linguistic conjunctions

use 5.008;

use strict;
use warnings;

use Carp qw/ croak /;
use Exporter qw/ import /;

our @EXPORT    = qw( conjunction );
our @EXPORT_OK = @EXPORT;

=head1 NAME

Lingua::Conjunction - Convert lists into simple linguistic conjunctions

=head1 VERSION

Version 2.5

=cut

our $VERSION = '2.5';

=head1 SYNOPSIS

Language-specific definitions.
These may not be correct, and certainly they are not complete.
E-mail corrections and additions to C<< <njh at bandsman.co.uk> >>,
and an updated version will be released.

=cut

# Format of %language is as follows:
# Two-letter ISO language codes... see L<Locale::Language> from CPAN for more details.
# sep = item  separator (usually a comma)
# alt = alternate ("phrase") separator
# pen = 1 = use penultimate separator/0 = don't use penultimate
#	(i.e., "Jack, Jill and Spot" vs. "Jack, Jill, and Spot")
# con = conjunction ("and")
# dis = disjunction ("or"), well, grammatically still a "conjunction"...

my %language = (
	'af' => { sep => ',', alt => ';', pen => 1, con => 'en',  dis => 'of' },
	'br' => { sep => ',', alt => ';', pen => 0, con => 'ha',  dis => 'ou' },	# Breton - 'and' is 'ha'
	'da' => { sep => ',', alt => ';', pen => 1, con => 'og',  dis => 'eller' },
	'de' => { sep => ',', alt => ';', pen => 1, con => 'und', dis => 'oder' },
	'en' => { sep => ',', alt => ';', pen => 1, con => 'and', dis => 'or' },
	'es' => { sep => ',', alt => ';', pen => 1, con => 'y',   dis => 'o' },
	'fi' => { sep => ',', alt => ';', pen => 1, con => 'ja',  dis => 'tai' },
	'fr' => { sep => ',', alt => ';', pen => 0, con => 'et',  dis => 'ou' },
	'id' => { sep => ',', alt => ';', pen => 1, con => 'dan', dis => 'atau' },
	'it' => { sep => ',', alt => ';', pen => 1, con => 'e',   dis => 'o' },
	'la' => { sep => ',', alt => ';', pen => 1, con => 'et',  dis => 'vel' },
	'nl' => { sep => ',', alt => ';', pen => 1, con => 'en',  dis => 'of' },
	'no' => { sep => ',', alt => ';', pen => 0, con => 'og',  dis => 'eller' },
	'pt' => { sep => ',', alt => ';', pen => 1, con => 'e',   dis => 'ou' },
	'sw' => { sep => ',', alt => ';', pen => 1, con => 'na',  dis => 'au' },
);

# Conjunction types. TODO: Someday we'll add either..or, neither..nor
my %types = (
    'and' => 'con',
    'or'  => 'dis'
);

my %punct     = %{ $language{_get_language()} };
my $list_type = $types{'and'};

=head1 SUBROUTINES/METHODS

=head2 conjunction

Lingua::Conjunction exports a single subroutine, C<conjunction>, that
converts a list into a properly punctuated text string.

You can cause C<conjunction> to use the connectives of other languages, by
calling the appropriate subroutine:

    Lingua::Conjunction->lang('en');   # use 'and'
    Lingua::Conjunction->lang('es');   # use 'y'
    Lingua::Conjunction->lang();	# Tries to determine your language, otherwise falls back to 'en'

Supported languages in this version are
Afrikaans,
Danish,
Dutch,
English,
French,
German,
Indonesian,
Italian,
Latin,
Norwegian,
Portuguese,
Spanish,
and Swahili.

You can also set connectives individually:

    Lingua::Conjunction->separator("...");
    Lingua::Conjunction->separator_phrase("--");
    Lingua::Conjunction->connector_type("or");

    # emits "Jack... Jill... or Spot"
    $name_list = conjunction('Jack', 'Jill', 'Spot');

=cut

sub conjunction {
	# See List::ToHumanString
	my @list = grep defined && /\S/, @_;

	return if(scalar(@list) == 0);
	return $list[0] if(scalar(@list) == 1);
	return join(" $punct{$list_type} ", @list) if(scalar(@list) == 2);

	if ( $punct{pen} ) {
		return join "$punct{sep} ", @list[ 0 .. $#list - 1 ],
		  "$punct{$list_type} $list[-1]",
		  unless grep /$punct{sep}/, @list;
		return join "$punct{alt} ", @list[ 0 .. $#list - 1 ],
		  "$punct{$list_type} $list[-1]";
	} else {
		return join "$punct{sep} ", @list[ 0 .. $#list - 2 ],
		  "$list[-2] $punct{$list_type} $list[-1]",
		  unless grep /$punct{sep}/, @list;
		return join "$punct{alt} ", @list[ 0 .. $#list - 2 ],
		  "$list[-2] $punct{$list_type} $list[-1]";
	}
}

=head2 separator

Sets the separator, usually ',' or ';'.

    Lingua::Conjunction->separator(',');

Returns the previous value.

=cut

sub separator {
	my $rc = $punct{'sep'};

	$punct{sep} = $_[1];
	return $rc;
}

=head2 separator_phrase

Sets the alternate (phrase) separator.

    Lingua::Conjunction->separator_phrase(';');

The C<separator_phrase> is used whenever the separator already appears in
an item of the list. For example:

    # emits "Doe, a deer; Ray; and Me"
    $name_list = conjunction('Doe, a deer', 'Ray', 'Me');

Returns the previous value;

=cut

sub separator_phrase {
	my $rc = $punct{'alt'};

	$punct{alt} = $_[1];
	return $rc;
}

=head2 penultimate

Enables/disables penultimate separator.

You may use the C<penultimate> routine to disable the separator after the
next to last item.
In English, The Oxford Comma is a highly debated issue.

    # emits "Jack, Jill and Spot"
    Lingua::Conjunction->penultimate(0);
    $name_list = conjunction('Jack', 'Jill', 'Spot');

The original author was told that the penultimate comma is not standard for some
languages, such as Norwegian.
Hence the defaults set in the C<%languages>.

    Lingua::Conjunction->penultimate(0);

Returns the previous value.

=cut

sub penultimate {
	my $rc = $punct{'pen'};

	$punct{pen} = $_[1];
	return $rc;
}

=head2 connector_type

Use "and" or "or", with appropriate translation for the current language

    Lingua::Conjunction->connector_type('and');

=cut

sub connector_type {
	if($types{ $_[1]}) {
		$list_type = $types{ $_[1] };
	} else {
		croak "Undefined connector type \`$_[1]\'"
	}

	return $list_type;
}

=head2 connector

Sets the for the current connector_type.

    Lingua::Conjunction->connector(SCALAR)

Returns the previous value.

=cut

sub connector {
	my $rc = $punct{'list_type'};

	$punct{$list_type} = $_[1];
	return $rc;
}

=head2 lang

Sets the language to use.
If no arguments are given,
it tries its best to guess.

    Lingua::Conjunction->lang('de');	# Changes the language to German

=cut

sub lang {
	my $language = $_[1] || _get_language();

	if(defined($language{$language})) {
		%punct = %{ $language{$language} };
	} else {
		croak "Undefined language \`$language\'";
	}

	return $language;
}

# https://www.gnu.org/software/gettext/manual/html_node/Locale-Environment-Variables.html
# https://www.gnu.org/software/gettext/manual/html_node/The-LANGUAGE-variable.html
sub _get_language
{
	if($ENV{'LANGUAGE'}) {
		foreach my $l(split/:/, $ENV{'LANGUAGE'}) {
			if($language{$l}) {
				return $l;
			}
		}
	}
	foreach my $variable('LC_ALL', 'LC_MESSAGES', 'LANG') {
		my $val = $ENV{$variable};
		next unless(defined($val));

		$val = substr($val, 0, 2);
		if($language{$val}) {
			return $val;
		}
	}
	return 'en';
}

=head1 AUTHORS

=over 4

=item *

Robert Rothenberg <rrwo@cpan.org>

=item *

Damian Conway <damian@conway.org>

=back

=head1 MAINTAINER

    2021-present	Maintained by Nigel Horne, C<< <njh at bandsman.co.uk> >>

=head1 CONTRIBUTORS

=for stopwords Ade Ishs Mohammad S Anwar Nigel Horne

=over 4

=item *

Ade Ishs <adeishs@cpan.org>

=item *

Mohammad S Anwar <mohammad.anwar@yahoo.com>

=item *

Nigel Horne C<< <njh at bandsman.co.uk> >>

=back

=head1 SEE ALSO

C<Locale::Language>, C<List::ToHumanString>

The I<Perl Cookbook> in Section 4.2 has a similar subroutine called
C<commify_series>. The differences are that
1. this routine handles multiple languages and
2. being a module, you do not have to add the subroutine to a script every time you need it.

=head1 SOURCE

The development version is on github at L<https://github.com/nigelhorne/Lingua-Conjunction>
and may be cloned from L<git://github.com/nigelhorne/Lingua-Conjunction.git>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lingua::Conjunction

You can also look for information at:

=over 4

=item * MetaCPAN

L<https://metacpan.org/release/Lingua-Conjunction>

=item * RT: CPAN's request tracker

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-Conjunction>

=item * CPANTS

L<http://cpants.cpanauthors.org/dist/Lingua-Conjunction>

=item * CPAN Testers' Matrix

L<http://matrix.cpantesters.org/?dist=Lingua-Conjunction>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Lingua-Conjunction>

=item * CPAN Testers Dependencies

L<http://deps.cpantesters.org/?module=Lingua::Conjunction>

=back

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests on the bugtracker website
L<https://rt.cpan.org/Dist/Display.html?Queue=Lingua-Conjunction>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 1999-2020 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

1;
