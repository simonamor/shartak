package RPGCat::Model::EMKit;

use strict;
use warnings;

use base 'Catalyst::Model::Factory';

use RPGCat::EMKit;
use Moose;

=head1 NAME

RPGCat::Model::EMKit - Catalyst model for sending emails

=head1 DESCRIPTION

This module provides a way to access RPGCat::EMKit and send emails. It
is based on (copied from) Sendme::Model::EMKit found at
https://github.com/simonamor/catalyst-example-email/

=head1 METHODS

=cut

our $AUTOLOAD;

has 'EmailInstance' => (
    is => 'rw',
    isa => 'RPGCat::EMKit',
);

has 'from_email' => (
    is => 'ro',
    isa => 'Str',
    default => 'rpgcat@localhost',
);
has 'from_name' => (
    is => 'ro',
    isa => 'Str',
    default => 'RPGCat',
);

__PACKAGE__->config( class => "RPGCat::Model::EMKit" );

=head2 ACCEPT_CONTEXT

This ensures that any requests for $c->model('EMKit') return a fresh
object that hasn't already been referenced.

=cut

# One instance per $c->model() request
sub ACCEPT_CONTEXT {
    my ($self, $c, @args) = @_;
    my $emkit = RPGCat::EMKit->new(
        template_path => $c->path_to('templates', 'email')->stringify,
        default_from_name => $self->from_name,
        default_from_email => $self->from_email,
        @args );

    return $emkit;
}

=head2 AUTOLOAD

Any methods requested are passed through to RPGCat::EMKit

=cut

sub AUTOLOAD {
    my $self = shift;
    my $name = $AUTOLOAD;
    $name =~ s/.*://;
    $self->EmailInstance->$name(@_);
}

=head1 AUTHOR

Simon Amor <simon@leaky.org>

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of either:

    a) the GNU General Public License as published by the Free
    Software Foundation; either version 1, or (at your option) any
    later version, or

    b) the "Artistic License" version 2 which comes with this program.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either
the GNU General Public License or the Artistic License for more details.

You should have received a copy of the Artistic License with this
program in the file named "LICENSES/Artistic-2_0". If not, please visit
http://www.perlfoundation.org/artistic_license_2_0

You should also have received a copy of the GNU General Public License
along with this program in the file named "LICENSES/Copying". If not,
write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
Boston, MA 02110-1301, USA or visit their web page on the internet at
http://www.gnu.org/copyleft/gpl.html

=cut

1;
