#!/usr/bin/env perl

# ./script/rpgcat_dh.pl  -s RPGCat::Schema -I lib -o ./ddl/ \
#   -c 'dbi:mysql:rpgcat_db;user=rpgcat_user;password=rpgcat_pass' \
#   install

# The above -c option can be used to install the current database
# into a MySQL db instead of the default SQLite db

use App::DH;
{
    package RPGCat::DH;
    use Moose;
    use Path::Class;
    extends 'App::DH';

    has '+connection_name'  => (
        default => sub { 'dbi:SQLite:./rpgcat.db' }
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

# Nasty hack to make it generate SQL for all 3 database types
if (grep { /write_ddl/ } @ARGV) {
    unshift @ARGV, "-d", "MySQL", "-d", "SQLite", "-d", "PostgreSQL";
}

RPGCat::DH->new_with_options->run;

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; but please see the LICENSING file for
more information.

=cut
