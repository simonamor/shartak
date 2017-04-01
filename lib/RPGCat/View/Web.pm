package RPGCat::View::Web;
use Moose;
use namespace::autoclean;

use RPGCat;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    render_die => 1,
    INCLUDE_PATH => [
        RPGCat->path_to( 'templates', 'webapp' ), # Look here first
        RPGCat->path_to( 'templates', 'library' ),
    ],
    # This is the wrapper template in templates/library/
    WRAPPER => "load_wrapper",
);

=head1 NAME

RPGCat::View::Web - TT View for RPGCat

=head1 DESCRIPTION

TT View for RPGCat.

=head1 SEE ALSO

L<RPGCat>

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; but please see the LICENSING file for
more information.

=cut

1;
