use ExtUtils::MakeMaker;
WriteMakefile(
    NAME                => 'WWW::Mechanize::Cached',
    VERSION_FROM        => 'lib/WWW/Mechanize/Cached.pm',
    PREREQ_PM => {
                'Carp' => 0,
                'Cache::Cache' => '1.02',
                'Storable' => '2.08',
                'WWW::Mechanize' => '0.70',
                'Test::More' => '0.47',
            },
    ($] >= 5.005 ?
      (ABSTRACT_FROM => 'lib/WWW/Mechanize/Cached.pm',
      AUTHOR     => 'Iain Truskett <spoon@cpan.org>') : ()),
    clean => { FILES => 'WWW-Mechanize-Cached-*' },
);
