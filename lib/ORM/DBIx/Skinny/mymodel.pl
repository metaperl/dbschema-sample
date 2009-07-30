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

sub find_and_fix {
    my $row = MyModel->find_or_create( authors => { au_lname => 'Wall' } ) ;

    $row->set(au_lname => 'Ball');
    $row->update;
}

sub find_and_fix2 {
    my $row = MyModel->single( authors => { au_lname => 'White' } ) ;

    $row->update( { au_lname => 'Kite' } );
}

find_and_fix2();

