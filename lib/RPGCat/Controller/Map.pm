package RPGCat::Controller::Map;

use Moose;
use namespace::autoclean;

use HTML::FormHandler;

BEGIN { extends 'Catalyst::Controller' }

=head1 NAME

RPGCat::Controller::Map

=head1 DESCRIPTION

Map related pages - view, move

=cut

sub map_chain :Chained("/") PathPart("map") CaptureArgs(0) Does('NeedsCharacter') {
    my ($self, $c) = @_;

}

=head2 /map

=cut

sub map_index :Chained("map_chain") PathPart("") Args(0) {
    my ($self, $c) = @_;

    $c->stash(
        template => "map/index.html",
    );
}

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; but please see the LICENSING file for
more information.

=cut

1;
