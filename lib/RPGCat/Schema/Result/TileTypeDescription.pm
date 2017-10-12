use utf8;
package RPGCat::Schema::Result::TileTypeDescription;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

__PACKAGE__->table("tile_type_descriptions");

__PACKAGE__->add_columns(
    "tile_type_id",
    {data_type => "integer",extra => { unsigned => 1 }, is_auto_increment => 1, is_nullable => 0},
    "description",
    { data_type => "mediumtext", is_nullable => 0},
);



__PACKAGE__->set_primary_key("tile_type_id");


__PACKAGE__->belongs_to( 'tile_type' => 'RPGCat::Schema::Result::TileType', 'tile_type_id' );



__PACKAGE__->meta->make_immutable;
1;
