use lib '.' ;

use MyModel;


sub add_author {
    my $row = MyModel->insert( authors => {
				       au_id => '111-11-1111', au_lname => 'Wall', au_fname => 'Larry'
				      }
			 );

}

sub add_title {

    my $row = MyModel->insert( titles => {
				      title_id => 'xyzabc', title => 'some neat book',
				      contract => 0
				      }
			   );

}

# class-based update
sub find_and_fix0 {
    my $rows = MyModel->update( authors => { au_lname => 'Bright' }, { au_lname => 'Dull' } ) ;

    warn "$rows";

}

# set then update
sub find_and_fix {
    my $row = MyModel->find_or_create( authors => { au_lname => 'Wall' } ) ;

    $row->set(au_lname => 'Ball');
    $row->update;
}

# update row object
sub find_and_fix2 {
    my $row = MyModel->single( authors => { au_lname => 'White' } ) ;

    $row->update( { au_lname => 'Kite' } );
}

# update column via scalar expression
sub find_and_fix3 {
    my $row = MyModel->single( authors => { au_lname => 'Straight' } ) ;


}

# class-based delete
sub del0 {
    my $rows = MyModel->delete( authors => { au_lname => '8' } ) ;

    warn "$rows";

}

# row-based delete
sub del2 {
    my $row = MyModel->single( authors => { city => 'Nashville' } );

    $row->delete;

}


del2;

