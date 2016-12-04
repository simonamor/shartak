use utf8;
package RPGCat::Schema::Result::Skill;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';



__PACKAGE__->add_columns(
  "skill_id",
  {data_type => "integer",extra => { unsigned => 1 }, is_auto_increment => 1, is_nullable => 0},
  "skill_name",
  { data_type => "char", is_nullable => 0, size => 32 },
  "skill_requirements",
  { data_type => "char", size => 32, is_nullable => 0 },
  "skill_effects"
  );

__PACKAGE__->load_components("InflateColumn::Serializer");

__PACKAGE__->add_columns( 'skill_data' => {
    data_type => "mediumtext",
    is_nullable => 0,
    'serializer_class' => 'JSON',
    'serializer_options' => { allow_blessed => 0 },
});

__PACKAGE__->add_columns( 'skill_prerequisits' => {
    data_type => "mediumtext",
    is_nullable => 0,
    'serializer_class' => 'JSON',
    'serializer_options' => { allow_blessed => 0 },
});

__PACKAGE__->set_primary_key("skill_id");



__PACKAGE__->many_to_many( 'skill_id' => 'RPGCat::Schema::Result::Skillset', 'skill_id' );



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;