use utf8;
package RPGCat::Schema::Result::Skills;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';



__PACKAGE__->add_columns(
  "character_id",
  {data_type => "integer",extra => { unsigned => 1 }, is_nullable => 0},
  "skill_id",
  {data_type => "integer",extra => { unsigned => 1 }, is_nullable => 0},
  "item_quantity",
  {data_type => "integer",extra => { unsigned => 1 }, is_nullable => 0}
  );



__PACKAGE__->set_primary_key("character_id","skill_id");


__PACKAGE__->belongs_to( 'character_id' => 'RPGCat::Schema::Result::Character', 'character_id' );
__PACKAGE__->belongs_to( 'skill_id' => 'RPGCat::Schema::Result::Skill', 'skill_id' );


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;