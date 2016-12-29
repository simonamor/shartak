use utf8;
package RPGCat::Schema::Result::Description;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';



__PACKAGE__->add_columns(
  "tile_id",
  {data_type => "integer",extra => { unsigned => 1 }, is_auto_increment => 1, is_nullable => 0},
  "tile_description",
  { data_type => "mediumtext", is_nullable => 0}
  );



__PACKAGE__->set_primary_key("tile_id");


__PACKAGE__->has_one( 'tile_id' => 'RPGCat::Schema::Result::Tile', 'tile_id' );



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;