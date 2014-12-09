use utf8;
package Company::Schema::Result::EmployeeSkill;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

__PACKAGE__->table("employeeSkills");

__PACKAGE__->add_columns(
  employeeid  => { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  skill       => { data_type => "varchar", is_nullable => 0, size => 15 },
);

__PACKAGE__->set_primary_key("employeeid", "skill");

# Один навык относится к одному служащему
__PACKAGE__->belongs_to(
  employee => "Company::Schema::Result::Employee",
  "employeeid",
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

1;
