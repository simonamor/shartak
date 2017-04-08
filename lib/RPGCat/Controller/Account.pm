package RPGCat::Controller::Account;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

=head1 NAME

RPGCat::Controller::Account

=head1 DESCRIPTION

Account related pages - settings, pick an active character, logout, etc

=cut

sub account_chain :Chained("/") PathPart("account") CaptureArgs(0) Does('NeedsAccount') {
    my ($self, $c) = @_;

}

sub account_index :Chained("account_chain") PathPart("") Args(0) {
    my ($self, $c) = @_;

    $c->stash(
        account => $c->user,
        template => "account/index.html"
    );
}

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; but please see the LICENSING file for
more information.

=cut

1;
