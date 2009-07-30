package MyModel;

#			   connect_options => { TraceLevel => 3 }
use DBIx::Skinny setup => {
        dsn => 'dbi:SQLite:test',
        username => '',
        password => '',

    }
;

1;

