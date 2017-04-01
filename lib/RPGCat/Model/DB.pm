package RPGCat::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'RPGCat::Schema',
    
    connect_info => {
        dsn => 'dbi:mysql:rpgcat_db',
        user => 'rpgcat_user',
        password => 'rpgcat_pass',
    }
);

=head1 NAME

RPGCat::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<RPGCat>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<RPGCat::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; but please see the LICENSING file for
more information.

=cut

1;
