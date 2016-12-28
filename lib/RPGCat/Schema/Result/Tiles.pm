use utf8;
package RPGCat::Schema::Result::Tile;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';



__PACKAGE__->add_columns(
  "tile_id",
  {data_type => "integer",extra => { unsigned => 1 }, is_auto_increment => 1, is_nullable => 0},
  "tile_name",
  { data_type => "char", is_nullable => 0, size => 32 },
  "colour_code",
  { data_type => "char", size => 6, is_nullable => 0 },
  "move_type",
  { data_type => "char", size => 10, is_nullable => 0 }
  );



__PACKAGE__->set_primary_key("tile_id");


__PACKAGE__->has_many( 'tile_id' => 'RPGCat::Schema::Result::Map', 'tile_id' );

__PACKAGE__->has_one( 'tile_id' => 'RPGCat::Schema::Result::Description', 'tile_id' );


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;