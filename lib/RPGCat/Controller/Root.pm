package RPGCat::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

RPGCat::Controller::Root - Root Controller for RPGCat

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub root_index_index :Path('/index') :Args(0) {
    my ($self, $c) = @_;
    $c->response->redirect( $c->uri_for("/") );
}

sub root_index :Path('/') :Args(0) {
    my ( $self, $c ) = @_;

    my $counter = ++ $c->session->{ counter };

    $c->stash( counter => $counter );
    $c->stash( template => "index.html" );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub auto :Private {
    my ($self, $c) = @_;

    # Load the status messages into the stash
    $c->load_status_msgs;

    return 1;
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; but please see the LICENSING file for
more information.

=cut

__PACKAGE__->meta->make_immutable;

1;
