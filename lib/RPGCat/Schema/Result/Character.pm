use utf8;
package RPGCat::Schema::Result::Character;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

__PACKAGE__->table("characters");

__PACKAGE__->add_columns(
  "character_id",
  {data_type => "integer", extra => { unsigned => 1 }, is_auto_increment => 1, is_nullable => 0 },
  "character_name",
  { data_type => "char", is_nullable => 0, size => 32 },
  "account_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "character_health",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "character_exp",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "character_max_ap",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "character_ap",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },

    "map_x",
    { data_type => "integer", extra => { unsigned => 0 }, is_nullable => 0, default => 0 },
    "map_y",
    { data_type => "integer", extra => { unsigned => 0 }, is_nullable => 0, default => 0 },
    "map_z",
    { data_type => "integer", extra => { unsigned => 0 }, is_nullable => 0, default => 0 },
);



__PACKAGE__->set_primary_key("character_id");

__PACKAGE__->add_unique_constraint("character_name", ["character_name"]);

__PACKAGE__->has_one( 'location' => 'RPGCat::Schema::Result::Map',
    {
        'foreign.map_x' => 'self.map_x',
        'foreign.map_y' => 'self.map_y',
        'foreign.map_z' => 'self.map_z',
    }
);


__PACKAGE__->belongs_to( 'account' => 'RPGCat::Schema::Result::Account', 'account_id' );
__PACKAGE__->might_have( 'inventory' => 'RPGCat::Schema::Result::Inventory', 'character_id' );


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
