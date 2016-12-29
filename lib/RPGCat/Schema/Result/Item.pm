use utf8;
package RPGCat::Schema::Result::Item;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';



__PACKAGE__->add_columns(
  "item_id",
  {data_type => "integer",extra => { unsigned => 1 }, is_auto_increment => 1, is_nullable => 0},
  "item_name",
  { data_type => "char", is_nullable => 0, size => 32 },
  "item_type",
  { data_type => "char", size => 32, is_nullable => 0 }
  );

__PACKAGE__->load_components("InflateColumn::Serializer");

__PACKAGE__->add_column( 'item_data' => {
    data_type => "mediumtext",
    is_nullable => 0,
    'serializer_class' => 'JSON',
    'serializer_options' => { allow_blessed => 0 }
});
  

__PACKAGE__->set_primary_key("item_id");



__PACKAGE__->many_to_many( 'inventories' => 'RPGCat::Schema::Result::Inventory', 'item_id' );



# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
