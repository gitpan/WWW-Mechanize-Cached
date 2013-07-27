
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Cache response to be polite",
  "AUTHOR" => "Iain Truskett (original author), Andy Lester <petdance\@cpan.org> (2004 - July 2009), Olaf Alders <olaf\@wundercounter.com> (current maintainer)",
  "BUILD_REQUIRES" => {
    "Module::Build" => "0.3601"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "DISTNAME" => "WWW-Mechanize-Cached",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "WWW::Mechanize::Cached",
  "PREREQ_PM" => {
    "Cache::FileCache" => 0,
    "Carp" => 0,
    "Data::Dump" => 0,
    "Moose" => 0,
    "Storable" => "2.21",
    "WWW::Mechanize" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Devel::SimpleTrace" => 0,
    "File::Spec" => 0,
    "Find::Lib" => 0,
    "HTTP::Request" => 0,
    "Path::Class" => 0,
    "Test::More" => 0,
    "constant" => 0,
    "lib" => 0,
    "vars" => 0
  },
  "VERSION" => "1.43",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



