use utf8;
package Company::Schema::Result::Client;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

__PACKAGE__->table("client");

__PACKAGE__->add_columns(
  clientid      => { data_type => "integer",  is_nullable => 0, is_auto_increment => 1 },
  name          => { data_type => "varchar",  is_nullable => 1, size => 40 },
  address       => { data_type => "varchar",  is_nullable => 1, size => 100 },
  contactperson => { data_type => "varchar",  is_nullable => 1, size => 80 },
  contactnumber => { data_type => "char",     is_nullable => 1, size => 12 },
);

__PACKAGE__->set_primary_key("clientid");

# Один служащий может работать только с одним клиентом в заданное время (workdate)
__PACKAGE__->has_one(
  assignment => "Company::Schema::Result::Assignment",
  "clientid",
  { cascade_copy => 0, cascade_delete => 0 },
);

1;
