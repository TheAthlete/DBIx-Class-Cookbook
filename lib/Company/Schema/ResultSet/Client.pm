package Company::Schema::ResultSet::Client;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

sub department_client_employee {
  my $self = shift;

  $self->search(undef,
    {
      join => {
        assignment => {
          employee => 'department'
        }
      }
    }
  );
}

1;
