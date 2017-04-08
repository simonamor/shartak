package RPGCat::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

RPGCat::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=head2 index

This is the main login page

=cut

sub login_index :Path("/login") Args(0) {
    my ( $self, $c ) = @_;

    my $email = $c->request->param('email');
    my $password = $c->request->param('password');

    if ($email && $password) {

        # Default location after login
        $c->response->redirect("/");

        # Attempt to log the user in
        if ($c->authenticate({
                email => $email,
                password => $password
            })) {

            # Prevents session fixation exploit
            $c->change_session_id;

            my $ral = $c->flash->{ redirect_after_login };
            if ($ral) {
                $c->response->redirect($ral);
            }
        } else {

            # Set an error
            $c->response->redirect(
                $c->uri_for(
                    $c->controller('Login')->action_for('login_index'), {
                        mid => $c->set_error_msg("Bad email or password")
                    }
                )
            );
            $c->detach();
        }
    }

    $c->stash(
        template => "login.html"
    );
}

=head2 logout

Logout the current account

=cut

sub logout :Path('/logout') :Args(0) {
    my ( $self, $c ) = @_;

    # Log the user out
    $c->logout;

    # Send the user to the starting point
    $c->response->redirect($c->uri_for('/'));
}

=head2 signup

The signup page for new accounts.

=cut

sub signup :Path("/signup") Args(0) {
    my ($self, $c) = @_;

    $c->stash(
        template => "signup.html",
    );
}

=encoding utf8

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; but please see the LICENSING file for
more information.

=cut

__PACKAGE__->meta->make_immutable;

1;
