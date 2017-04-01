package RPGCat::Controller::Account;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub account_index :Chained("/") PathPart("account") Args(0) {
    my ($self, $c) = @_;

    $c->stash(
        account => $c->user,
        template => "account/index.html"
    );
}

1;
