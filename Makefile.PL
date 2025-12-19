use strict;
use warnings;
use ExtUtils::MakeMaker 6.64;	# 6.64 for TEST_REQUIRES

my $dist = {
	COMPRESS => 'gzip -9f',
	SUFFIX => 'gz'
};

if($^O eq 'darwin') {
	$dist->{'TAR'} = 'gtar';
}

WriteMakefile(
	NAME		=> 'Lingua::Conjunction',
	AUTHOR		=> q{Nigel Horne <njh@bandsman.co.uk>},
	VERSION_FROM	=> 'lib/Lingua/Conjunction.pm',
	ABSTRACT_FROM	   => 'lib/Lingua/Conjunction.pm',
	((defined($ExtUtils::MakeMaker::VERSION) &&
	 ($ExtUtils::MakeMaker::VERSION >= 6.3002))
	  ? ('LICENSE'=> 'GPL')
	  : ()),
	'LIBS' => [''],   # e.g., '-lm'
	'DEFINE' => '',     # e.g., '-DHAVE_SOMETHING'
	'INC' => '',     # e.g., '-I/usr/include/other'
	PL_FILES	=> {},
	TEST_REQUIRES => {
		'File::Spec' => 0,
		'Module::Metadata' => 0,
		'Test::DescribeMe' => 0,
		'Test::More' => 0,
		'Test::Most' => 0,
		'Test::Needs' => 0,
		'Test::NoWarnings' => 0
	}, PREREQ_PM => {
		'Carp' => 0,
		'Exporter' => 0,
		'I18N::LangTags::Detect',
	}, dist => $dist,
	clean		=> { FILES => 'Lingua-Conjunction-*' },
	# META_ADD => {
		# provides => {}
	# },
	META_MERGE => {	# https://perldoc.perl.org/CPAN::Meta::Spec
		'meta-spec' => { version => 2 },
		resources => {
			repository => {
				type => 'git',
				url => 'git://github.com/nigelhorne/Lingua-Conjunction.git',
				web => 'https://github.com/nigelhorne/Lingua-Conjunction',
				repository => 'https://github.com/nigelhorne/Lingua-Conjunction',
			}, bugtracker => {
				# RT#134010
				web => 'https://rt.cpan.org/Public/Dist/Display.html?Name=Lingua-Conjunction',
				# web => 'https://github.com/nigelhorne/Lingua-Conjunction/issues',
				# url => 'https://github.com/nigelhorne/Lingua-Conjunction/issues',
				mailto => 'bug-Lingua-Conjunction@rt.cpan.org'
			}
		},
	},
	MIN_PERL_VERSION	=> '5.008'	# Probably would work, but never tested on earlier versions than this
);
