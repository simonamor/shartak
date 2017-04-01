use utf8;
package RPGCat::Schema::Result::AccountRole;

=head1 NAME

RPGCat::Schema::Result::AccountRole

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<account_roles>

=cut

__PACKAGE__->table("account_roles");

=head1 ACCESSORS

=head2 account_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 role_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "account_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "role_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</account_id>

=item * L</role_id>

=back

=cut

__PACKAGE__->set_primary_key("account_id", "role_id");

__PACKAGE__->belongs_to( 'role' => 'RPGCat::Schema::Result::Role', 'role_id' );
__PACKAGE__->belongs_to( 'account' => 'RPGCat::Schema::Result::Account', 'account_id' );

__PACKAGE__->meta->make_immutable;
1;
