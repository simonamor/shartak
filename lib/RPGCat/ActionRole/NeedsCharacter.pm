package RPGCat::ActionRole::NeedsCharacter;

use Moose::Role;
use namespace::autoclean;

=head1 NAME

RPGCat::ActionRole::NeedsCharacter

=head1 DESCRIPTION

This module allows you to add a role to a controller action that requires
a logged in user account AND an active character in order to access the
action.

NeedsCharacter implies NeedsAccount since you cannot have an active
character without being logged into an account.

This is not the same as requiring just an account to be logged in.
That would be L<RPGCat::ActionRole::NeedsAccount>

=head1 SYNOPSIS

 sub mypage :Path("/account") Does('NeedsAccount') Args(0) {
     ...
 }

=cut

around execute => sub {
    my $orig = shift;
    my $self = shift;
    my ($controller, $c, @args) = @_;

    unless ($c->user_exists) {
        $c->log->debug( $c->action . " diverting to login");
        $c->session( redirect_after_login => $c->request->uri->as_string );
        $c->response->redirect( $c->uri_for("/login") );
        $c->detach();
    }

    if ($c->session->{ active_character }) {
        my $character = $c->model('DB::Character')->find( $c->session->{ active_character } );
        if ($character && $character->account_id == $c->user->account_id) {

            # FIXME: Stash the active character data?
            $c->stash( character => $character );

        }
    }

    unless ($c->stash->{ character }) {
        $c->response->redirect( $c->uri_for("/account", {
            mid => $c->set_error_msg("Please pick an active character.")
        }));
        $c->detach();
    }
    # If we get here, we should have stashed the active character
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
