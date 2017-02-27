use strict;
use warnings;

use RPGCat;

my $app = RPGCat->apply_default_middlewares(RPGCat->psgi_app);
$app;

