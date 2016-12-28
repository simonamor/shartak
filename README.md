# rpgcat
Catalyst based RPG framework

## Installation

This works best if you install a local version of Perl and all
associated modules. This can be done as follows:

    curl -L https://install.perlbrew.pl | bash
    source ~/perl5/perlbrew/etc/bashrc
    perlbrew install perl-5.20.1
    perlbrew switch perl-5.20.1
    perlbrew install-cpanm
    cpanm Catalyst::Devel

This next command should output 1.39 (or something more recent)

    perl -MCatalyst::Devel -e 'print "$Catalyst::Devel::VERSION\n";'

In github, fork the main rpgwnn/rpgcat repository into your personal
repository and clone your repository and install any extra Perl dependencies.

    cd ~
    git clone git@github.com:YOURUSER/rpgcat.git
    cd ~/rpgcat
    cpanm --installdeps .

To keep your version in sync with the main repository, configure the
upstream repository

    git remote add upstream https://github.com/rpgwnn/rpgcat.git

and merge in changes from upstream/master. Full instructions can be
found at https://help.github.com/articles/syncing-a-fork/

    git fetch upstream
    git merge upstream/master

## Testing

To test the applications, run the following:

    script/rpgcat_server -r -d --fork

If you don't use --fork, it'll only run a single thread which will cause
simultaneous requests to hang until the previous request has finished.

-r causes the server to monitor Perl modules and automatically reload if
there are any changes detected.

-d enables debug output which includes timings, headers, etc.

