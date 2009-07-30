package MyModel::Schema;

use DBIx::Skinny::Schema;

install_table authors => schema {
    pk 'au_id';
    columns qw/
       au_id 	au_lname 	au_fname 	
       phone	address	city 	state 	zip
  /;
};


1;

