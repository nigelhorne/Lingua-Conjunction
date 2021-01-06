# NAME

Lingua::Conjunction - Convert lists into simple linguistic conjunctions

# VERSION

Version v2.1.5

# SYNOPSIS

Language-specific definitions (these may not be correct, and certainly
they are not complete... E-mail corrections and additions to the author
and an updated version will be released.)

# SUBROUTINES/METHODS

## conjunction

Lingua::Conjunction exports a single subroutine, `conjunction`, that
converts a list into a properly punctuated text string.

You can cause `conjunction` to use the connectives of other languages, by
calling the appropriate subroutine:

    Lingua::Conjunction->lang('en');   # use 'and'
    Lingua::Conjunction->lang('es');   # use 'y'
    Lingua::Conjunction->lang();        # Tries to determine your language, otherwise falls back to 'en'

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

## separator

Sets the separator, usually ',' or ';'.

    Lingua::Conjunction->separator(',');

## separator\_phrase

Sets the alternate (phrase) separator.

    Lingua::Conjunction->separator_phrase(';');

The `separator_phrase` is used whenever the separator already appears in
an item of the list. For example:

    # emits "Doe, a deer; Ray; and Me"
    $name_list = conjunction('Doe, a deer', 'Ray', 'Me');

## penultimate

Enables/disables punultimate separator.

You may use the `penultimate` routine to diable the separator after the
next to last item.
In English, The Oxford Comma is a highly debated issue.

    # emits "Jack, Jill and Spot"
    Lingua::Conjunction->penultimate(0);
    $name_list = conjunction('Jack', 'Jill', 'Spot');

The original author was told that the penultimate comma is not standard for some
languages, such as Norwegian.
Hence the defaults set in the `%languages`.

    Lingua::Conjunction->penultimate(0);

## connector\_type

Use "and" or "or", with appropriate translation for the current language

    Lingua::Conjunction->connector_type('and');

## connector

Sets the for the current connector\_type.

    Lingua::Conjunction->connector(SCALAR)

## lang

Sets the language to use.
If no arguments are given,
it tries its best to guess.

    Lingua::Conjunction->lang('de');    # Changes the language to German

# AUTHORS

- Robert Rothenberg <rrwo@cpan.org>
- Damian Conway <damian@conway.org>

# MAINTAINER

    2021-present        Maintained by Nigel Horne, C<< <njh at bandsman.co.uk> >>

# CONTRIBUTORS

- Ade Ishs <adeishs@cpan.org>
- Mohammad S Anwar <mohammad.anwar@yahoo.com>
- Nigel Horne `<njh at bandsman.co.uk>`

# SEE ALSO

`Locale::Language`

The _Perl Cookbook_ in Section 4.2 has a simular subroutine called
`commify_series`. The differences are that
1\. this routine handles multiple languages and
2\. being a module, you do not have to add the subroutine to a script every time you need it.

# SOURCE

The development version is on github at [https://github.com/nigelhorne/Lingua-Conjunction](https://github.com/nigelhorne/Lingua-Conjunction)
and may be cloned from [git://github.com/nigelhorne/Lingua-Conjunction.git](git://github.com/nigelhorne/Lingua-Conjunction.git)

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lingua::Conjunction

You can also look for information at:

- MetaCPAN

    [https://metacpan.org/release/Lingua-Conjunction](https://metacpan.org/release/Lingua-Conjunction)

- RT: CPAN's request tracker

    [https://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-Conjunction](https://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-Conjunction)

- CPANTS

    [http://cpants.cpanauthors.org/dist/Lingua-Conjunction](http://cpants.cpanauthors.org/dist/Lingua-Conjunction)

- CPAN Testers' Matrix

    [http://matrix.cpantesters.org/?dist=Lingua-Conjunction](http://matrix.cpantesters.org/?dist=Lingua-Conjunction)

- CPAN Ratings

    [http://cpanratings.perl.org/d/Lingua-Conjunction](http://cpanratings.perl.org/d/Lingua-Conjunction)

- CPAN Testers Dependencies

    [http://deps.cpantesters.org/?module=Lingua::Conjunction](http://deps.cpantesters.org/?module=Lingua::Conjunction)

# BUGS

Please report any bugs or feature requests on the bugtracker website
[https://github.com/nigelhorne/Lingua-Conjunction/issues](https://github.com/nigelhorne/Lingua-Conjunction/issues)

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# COPYRIGHT AND LICENSE

This software is Copyright (c) 1999-2020 by Robert Rothenberg.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
