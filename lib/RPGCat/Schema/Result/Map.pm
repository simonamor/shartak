use utf8;
package RPGCat::Schema::Result::Map;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

__PACKAGE__->table("maps");

__PACKAGE__->add_columns(
  "tile_id",
  {data_type => "integer",extra => { unsigned => 1 }, is_nullable => 0},
  "tile_x",
  {data_type => "integer",extra => { unsigned => 0 }, is_nullable => 0},
  "tile_y",
  {data_type => "integer",extra => { unsigned => 0 }, is_nullable => 0},
  "tile_z",
  {data_type => "integer",extra => { unsigned => 0 }, is_nullable => 0},
  );



__PACKAGE__->set_primary_key("tile_id");

__PACKAGE__->add_unique_constraint("tile_coords" => ["tile_x","tile_y","tile_z"]);


__PACKAGE__->has_one( 'tile' => 'RPGCat::Schema::Result::Tile', 'tile_id' );



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
