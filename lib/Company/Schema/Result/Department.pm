use utf8;
package Company::Schema::Result::Department;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

__PACKAGE__->table("department");

__PACKAGE__->add_columns(
  departmentid  => { data_type => "integer", is_nullable => 0, is_auto_increment => 1 },
  name          => { data_type => "varchar", is_nullable => 1, size => 30 },
);

__PACKAGE__->set_primary_key("departmentid");

# Несколько служащих могут работать в одном отделе
__PACKAGE__->has_many(
  employees => "Company::Schema::Result::Employee",
  "departmentid",
  { cascade_copy => 0, cascade_delete => 0 },
);

1;
