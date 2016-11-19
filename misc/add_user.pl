#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::RealBin/../lib";

use RPGCat;

my $accounts = RPGCat->model('DB::Account');
$accounts->create({
    email => 'simon@example.com',
    password => 'rubbishpassword',
});
