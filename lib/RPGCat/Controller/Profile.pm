package RPGCat::Controller::Profile;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub profile_index :Chained("/") PathPart("profile") Args(0) {
    my ($self, $c) = @_;

    $c->stash( template => "profile/index.html" );
}

sub profile_view :Chained("/") PathPart("profile") Args(1) {
    my ($self, $c, $uid) = @_;

    my $character = $c->model('DB::Character')->find($uid);
    unless ($character) {
        $c->response->redirect(
            $c->uri_for_action('/profile/profile_index', {
                mid => $c->set_error_msg("Character not found")
            })
        );
    }
    $c->stash(
        character => $character,
        template => "profile/view.html",
    );
}

1;
