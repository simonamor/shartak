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

    my $email = $c->request->params->{ 'email' };
    my $password = $c->request->params->{ 'password' };

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

    $c->stash( template => "signup.html" );
    unless ($c->request->method =~ /^POST$/i) {
        $c->detach();
    }

    my $email = $c->request->params->{ 'email' };
    my $password = $c->request->params->{ 'password' };

    # Process to follow...

    # Enter an email and password. Account is created. "Verification
    # email has been sent to $email" is shown. User redirected to login page.

    # If the account already existed, they'll more than likely have the
    # wrong password when they try to login - at that point the legit
    # user with that email will have received something like "We
    # received a request for a new account with this email. You already
    # have an account so the new account was NOT created. If you have
    # forgotten your password, you can <reset it>."

    # If the account didn't exist, the email says "We received a request
    # for a new account with this email. If this was requested by yourself,
    # <confirm your email>. If it was not requested by you, <deactivate
    # the account>"

    my $account = eval {
        $c->model('DB::Account')->create({
            email => $email,
            password => $password,
        });
    };
    if ($@ || (! defined $account)) {

        # An account most likely already exists with this email address

        # FIXME: At this point, we could re-populate the form, but since
        # we don't want to provide their password in the page source, and
        # the email they picked already has an account, there's not a lot
        # of point!

        # FIXME: Send email to $email

    } else {

        # FIXME: Send verification email to $email asking user to confirm
        # their email address (note - this does not log them in!)
    }

    # Now we redirect to the login page. If it was a new account, they'll
    # know the password and it'll allow them to confirm that they know what
    # it is (and maybe auto-store in password manager)
    # If it was an attempt to create a duplicate, then chances are they
    # won't know the password and will then get the option to recover the
    # password through the normal route.

    $c->response->redirect(
        $c->uri_for("/login", {
            mid => $c->set_success_msg(
                "A confirmation email has been sent."
            )
        })
    );
}

=head2 forgot

This page allows a user to request a password reset link.

=cut

sub forgot :Path("/forgot") Args(0) {
    my ($self, $c) = @_;

    $c->stash( template => "forgot.html" );
    my $email = $c->request->params->{ 'email' };

    # Not a form submission, just the GET so show the form.
    unless ($email) { $c->detach(); }

    # Tell the user we're doing something.
    $c->stash( success_msg => "An email is being sent with instructions." );

    # Find the account by email address
    my $account = eval {
        $c->model('DB::Account')->search({ email => $email })->single();
    };
    if ($@ || ! defined $account) {
        # Something went wrong, or we didn't find the user account
        $c->log->debug("No user found for $email");

        my $emkit = $c->model('EMKit',
                transport_class => 'Email::Sender::Transport::Sendmail');
        $emkit = $emkit->template("forgotten-notexists.mkit", {
                destination_email => $email,
                account => undef,
                config_url  => $c->uri_for('/'),
                config_name => $c->config->{ name },
            })
            ->to( $email );
        $emkit->send();

        $c->detach();
    } else {
        $c->log->debug("User found " . $account->account_id );
        my $emkit = $c->model('EMKit',
                transport_class => 'Email::Sender::Transport::Sendmail')
            ->template("forgotten-exists.mkit", {
                destination_email => $account->email,
                account => $account,
                config_url  => $c->uri_for('/'),
                config_name => $c->config->{ name },
            })
            ->to( $account->email );
        $emkit->send();

        $c->detach();
    }
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
