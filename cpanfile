# Generated from Makefile.PL using makefilepl2cpanfile

requires 'perl', '5.008';

requires 'Carp';
requires 'Exporter';
requires 'I18N::LangTags::Detect';

on 'test' => sub {
	requires 'File::Spec';
	requires 'Module::Metadata';
	requires 'Test::DescribeMe';
	requires 'Test::More';
	requires 'Test::Most';
	requires 'Test::Needs';
	requires 'Test::NoWarnings';
};

on 'develop' => sub {
	requires 'Devel::Cover';
	requires 'Perl::Critic';
	requires 'Test::Pod';
	requires 'Test::Pod::Coverage';
};
