use strict;
use warnings;

use DBI;
use DBIx::DataModel;
DBIx::DataModel->Schema('HR');






HR->Table(qw/Employee      t_employee        emp_id/);
  HR->Table(qw/Department    t_department      dpt_code/);
  HR->Table(qw/Activity      t_activity        act_id/);
  HR->Table(qw/Skill         t_skill           skill_code/);
  HR->Table(qw/EmployeeSkill t_employee_skill  emp_id  skill_code/);

 HR->ColumnType(Date => 
     fromDB => sub {$_[0] =~ s/(\d\d\d\d)-(\d\d)-(\d\d)/$3.$2.$1/   if $_[0]},
     toDB   => sub {$_[0] =~ s/(\d\d)\.(\d\d)\.(\d\d\d\d)/$3-$2-$1/ if $_[0]},
     validate => sub {$_[0] =~ m/\d\d\.\d\d\.\d\d\d\d/});

  HR::Employee->ColumnType(Date => qw/d_birth/);
  HR::Activity->ColumnType(Date => qw/d_begin d_end/);


 HR->Association([qw/Department department  1 /],
                  [qw/Activity   activities  * /]);


HR->Composition([qw/Employee   employee    1 /],
                  [qw/Activity   activities  * /]);



  HR->Association([qw/Employee      employee   1 /],
                  [qw/EmployeeSkill emp_skills * /]);

  HR->Association([qw/Skill         skill      1 /],
                  [qw/EmployeeSkill emp_skills * /]);


  HR->Association([qw/Employee  employees  *  emp_skills employee/],
                  [qw/Skill     skills     *  emp_skills skill   /]);




my $dbh = DBI->connect( 'dbi:SQLite:emps.sqlite3', '', '' , {RaiseError => 1}); 
 HR->dbh($dbh);               # give $dbh handle to the schema


  my ($bach_id, $berlioz_id, $monteverdi_id) = 
    HR::Employee->insert({firstname => "Johann",  lastname => "Bach"      },
                         {firstname => "Hector",  lastname => "Berlioz"   },
                         {firstname => "Claudio", lastname => "Monteverdi"});

 HR::Department->insert({dpt_code => "CPT",  dpt_name => "Counterpoint" },
                         {dpt_code => "ORCH", dpt_name => "Orchestration"});

  HR::Skill->insert({skill_code => "VL",  skill_name => "Violin"  },
                     {skill_code => "KB",  skill_name => "Keyboard"},
                     {skill_code => "GT",  skill_name => "Guitar"});


HR::Employee->update($bach_id => {firstname => "Johann Sebastian"});

  my $bach = HR::Employee->fetch($bach_id); # get single record from prim.key
  
  $bach->insert_into_activities({d_begin => '01.01.1695',
                                 d_end   => '18.07.1750',
                                 dpt_code => 'CPT'});
  
  $bach->insert_into_emp_skills({skill_code => 'VL'},
                                {skill_code => 'KB'});

  HR::Employee->insert({firstname  => "Richard",  
                        lastname   => "Strauss",
                        activities => [ {d_begin  => '01.01.1874',
                                         d_end    => '08.09.1949',
                                         dpt_code => 'ORCH'      } ]});
