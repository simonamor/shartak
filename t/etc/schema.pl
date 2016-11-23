{
    schema_class => "RPGCat::Schema",
    resultsets => [ qw/Account Role AccountRole/ ],
    connect_info => [ 'dbi:SQLite:dbname=:memory:', undef, undef ],
    fixture_path => [ qw/t etc/ ],
}
