#!/usr/bin/env perl

# ./dh.pl  -s RPGCat::Schema -I lib -c 'dbi:mysql:rpgcat_db;user=rpgcat_user;password=rpgcat_pass' -o ./ddl/ write_ddl

use App::DH;
{
    package RPGCat::DH;
    use Moose;
    use Path::Class;
    extends 'App::DH';

    has '+connection_name'  => (
        default => sub { 'dbi:mysql:rpgcat_db;user=rpgcat_user;password=rpgcat_pass' }
    );
    has '+schema'           => (
        default => sub { 'RPGCat::Schema' }
    );
    has '+include'          => (
        default => sub { [ dir( 'lib' )->stringify ] }
    );
    has '+script_dir'       => (
        default => sub { dir( 'ddl' )->stringify }
    );

    __PACKAGE__->meta->make_immutable;
}
RPGCat::DH->new_with_options->run;
