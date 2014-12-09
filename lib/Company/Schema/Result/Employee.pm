use utf8;
package Company::Schema::Result::Employee;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/InflateColumn::DateTime InflateColumn::Object::Enum Core/);

__PACKAGE__->table("employee");

__PACKAGE__->add_columns(
  employeeid    => { data_type => "integer", is_nullable => 0, is_auto_increment => 1 },
  name          => { data_type => "varchar", is_nullable => 1, size => 80 },
  job           => { data_type => "varchar", is_nullable => 1, size => 30 },
  departmentid  => { data_type => "integer", is_nullable => 0, is_foreign_key => 1 },
  vacation      => { data_type => 'enum',    is_nullable => 1, default_value => 'No', is_enum => 1, extra => {list => [qw/Yes No/]} },
);

__PACKAGE__->set_primary_key("employeeid");

# Один служащий может иметь несколько внешних заданий
__PACKAGE__->has_many(
  assignments => "Company::Schema::Result::Assignment",
  "employeeid",
  { cascade_copy => 0, cascade_delete => 0, join_type => 'LEFT' },
);

# Один служащий может иметь несколько навыков
__PACKAGE__->has_many(
  employee_skills => "Company::Schema::Result::EmployeeSkill",
  "employeeid",
  { cascade_copy => 0, cascade_delete => 0 },
);
# Несколько служащих могут иметь несколько навыков
__PACKAGE__->many_to_many( employee_skill => 'employee_skills', 'employee');

# Один служащий относится к одному отделу
__PACKAGE__->belongs_to(
  department => "Company::Schema::Result::Department",
  "departmentid",
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

sub name_and_job {
  my $self = shift;
  return $self->name . ' | ' . $self->job;
}

1;
