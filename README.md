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

Then clone the repository from github and install any extra dependencies.

    cd ~
    git clone git@github.com:YOURUSER/rpgcat.git
    cd ~/rpgcat
    cpanm --installdeps .

## Testing

To test the applications, run the following:

    script/rpgcat_server -r -d --fork

If you don't use --fork, it'll only run a single thread which will cause
simultaneous requests to hang until the previous request has finished.

-r causes the server to monitor Perl modules and automatically reload if
there are any changes detected.

-d enables debug output which includes timings, headers, etc.

