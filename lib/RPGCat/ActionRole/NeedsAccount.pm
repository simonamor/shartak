package RPGCat::ActionRole::NeedsAccount;

use Moose::Role;
use namespace::autoclean;

=head1 NAME

RPGCat::ActionRole::NeedsAccount

=head1 DESCRIPTION

This module allows you to add a role to a controller action that requires
a logged in user account in order to access the action.

This is not the same as requiring a character from the account to be
active. That would be L<RPGCat::ActionRole::NeedsCharacter>

=head1 SYNOPSIS

 sub mypage :Path("/account") Does('NeedsAccount') Args(0) {
     ...
 }

=cut

around execute => sub {
    my $orig = shift;
    my $self = shift;
    my ($controller, $c, @args) = @_;

    $c->log->debug( $c->action . " requires an account");

    unless ($c->user_exists) {
        $c->log->debug( $c->action . " diverting to login");
        $c->session( redirect_after_login => $c->request->uri->as_string );
        $c->response->redirect( $c->uri_for("/login") );
        $c->detach();
    }

    # Can we stash the account here for later use?
    $c->stash(
        account => $c->user
    );

    return $self->$orig(@args);
};

=head1 SEE ALSO

L<RPGCat::ActionRole::NeedsCharacter>

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; but please see the LICENSING file for
more information.

=cut

1;
