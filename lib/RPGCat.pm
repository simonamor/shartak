package RPGCat;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple

    Authentication
    Authorization::Roles

    Session
    Session::Store::DBI
    Session::State::Cookie

    StatusMessage
/;

extends 'Catalyst';

our $VERSION = '0.01';

use DBIx::Class::DeploymentHandler;

# Configure the application.
#
# Note that settings in rpgcat.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'RPGCat',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header

#    default_view => 'HTML',
    using_frontend_proxy => 1,
);

__PACKAGE__->config(
    'Model::DB' => {
        'dsn' => 'dbi:SQLite:./rpgcat.db',
    }
);

# Authentication
__PACKAGE__->config(
    'Plugin::Authentication' => {
        default => {
            store => {
                class           => 'DBIx::Class',
                user_model      => 'DB::Account',
                role_relation   => 'roles',
                role_field      => 'role',
                use_userdata_from_session   => 0, # cache user data in session
            },
            credential => {
                class           => 'Password',
                password_type   => 'self_check',
            },
        },
    },
);

# Default view for pages
__PACKAGE__->config(
    default_view => 'Web',

    'Plugin::Session' => {
        dbi_dbh   => 'DB', # which means RPGCat::Model::DB
        dbi_table => 'sessions',
        dbi_id_field => 'id',
        dbi_data_field => 'session_data',
        dbi_expires_field => 'expires',

        expires   => 3600*72,   # 72 hours (in seconds)

        # If nothing in the session changed, only refresh the expiry
        # time if it's got less than 70 hours until it expires
        expiry_threshold => 3600*70,
    },
);


# Start the application
__PACKAGE__->setup();

# Auto-deploy the database schema or upgrade to the latest
# - this uses DBIx::Class::DeploymentHandler so you have to
# make sure the schema is generated correctly.

my $model = __PACKAGE__->model('DB');
my $dh = DBIx::Class::DeploymentHandler->new({
    schema => $model->schema,
    force_overwrite => 0,
    script_directory => __PACKAGE__->path_to("ddl")->stringify,
    databases => [ $model->schema->storage->sqlt_type ],
});
if ($dh->version_storage_is_installed) {
    if ($dh->next_version_set) {
#        warn "next version set is not undef - we should call upgrade()";
        my $ret = eval {
            $dh->upgrade();
        };
        die "upgrade failed: $@\n" if $@;
#    } else {
#        warn "next version is undef - nothing to do";
    }
} else {
#    warn "version storage is installed - we should call install()";
    my $ret = eval {
        $dh->install();
    };
    die "install failed: $@\n" if $@;
}

=encoding utf8

=head1 NAME

RPGCat - Catalyst based application

=head1 SYNOPSIS

    script/rpgcat_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<RPGCat::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Catalyst developer

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
