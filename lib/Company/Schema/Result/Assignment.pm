use utf8;
package Company::Schema::Result::Assignment;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

__PACKAGE__->table("assignment");

__PACKAGE__->add_columns(
  clientid    => { data_type => "integer", is_nullable => 0, is_foreign_key => 1            },
  employeeid  => { data_type => "integer", is_nullable => 0, is_foreign_key => 1            },
  workdate    => { data_type => "date",    is_nullable => 0, datetime_undef_if_invalid => 1 },
  hours       => { data_type => "float",   is_nullable => 1                                 },
);

__PACKAGE__->set_primary_key(qw/employeeid workdate/);
__PACKAGE__->add_unique_constraint(fk_employee => [qw/employeeid workdate/]);

# Один клиент относится к одному служащему
__PACKAGE__->belongs_to(
  client => "Company::Schema::Result::Client",
  'clientid',
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

# Одно внешнее задание относится к одному служащему (выполняет один служащий)
__PACKAGE__->belongs_to(
  employee => "Company::Schema::Result::Employee",
  'employeeid',
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT", join_type => 'LEFT' },
);

1;
