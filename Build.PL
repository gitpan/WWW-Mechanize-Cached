
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Cache response to be polite",
  "dist_author" => [
    "Iain Truskett (original author)",
    "Andy Lester <petdance\@cpan.org> (2004 - July 2009)",
    "Olaf Alders <olaf\@wundercounter.com> (current maintainer)"
  ],
  "dist_name" => "WWW-Mechanize-Cached",
  "dist_version" => "1.43",
  "license" => "perl",
  "module_name" => "WWW::Mechanize::Cached",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Cache::FileCache" => 0,
    "Carp" => 0,
    "Data::Dump" => 0,
    "Moose" => 0,
    "Storable" => "2.21",
    "WWW::Mechanize" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "Devel::SimpleTrace" => 0,
    "File::Spec" => 0,
    "Find::Lib" => 0,
    "HTTP::Request" => 0,
    "Path::Class" => 0,
    "Test::More" => 0,
    "constant" => 0,
    "lib" => 0,
    "vars" => 0
  }
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  my $tr = delete $module_build_args{test_requires};
  my $br = $module_build_args{build_requires};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
