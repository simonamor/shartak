use strict;
use warnings;

use Test::More;
use Test::DBIx::Class;

is Account->count, 0, 'no records in accounts table';

ok my $account = Account->create({
    email => 'first@example.com',
    password => 'nothing',
}), 'Created a test account';

is_result $account;

is_fields [qw(email)], $account,
    ['first@example.com'],
    'account record looks good';

isnt $account->password, 'nothing', 'password is not in plain text, good';

done_testing();
