Database Schema updates
=======================

If you make a change to the database schema (files in `lib/RPGCat/Schema/`),
remember to update the `$VERSION` in `RPGCat::Schema` and then when everything
works, run through the following procedure.

If you are using a database other than MySQL, use the appropriate backup
commands in case the upgrade process breaks your database and you need to
roll it back. An example MySQL command is:

    mysqldump rpgcat_db > rpgcat_db-$(date +%Y%m%d.%H%M%S).db

Obviously you will need to change your database name if you have changed
it from the default. Do not commit the rpgcat_db backup!

Create the files within the `ddl/` directory that contain SQL to upgrade or
install the current version of the schema (remember to `git add` them!)

    script/rpgcat_dh.pl write_ddl

Upgrade your database to the latest version.

    script/rpgcat_dh.pl upgrade

If something goes wrong, you'll need to restore the database from the backup
you made at the start (you did do that step, didn't you?) and fix whatever
is wrong with the upgrade files.

