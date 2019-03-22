# NAME

Mojolicious::Plugin::CascadingConfig - Perl-ish configuration plugin that loads and merges config files in order

# SYNOPSIS

    # myapp.conf for production mode
    {
        # Just a value
        foo => "bar",

        # Nested data structures are fine too
        baz => ['♥'],

        # You have full access to the application
        music_dir => app->home->child('music'),
    }

    # myapp.development.conf for development mode
    {
        foo => "not_bar",
    }

    # myapp.staging.conf for staging mode
    {
        baz => ['♫'],
    }


    # Mojolicious in production mode
    my $config = $app->plugin('CascadingConfig');
    say $config->{foo}; # says 'bar'
    say $config->{baz}; # says '♥'

    # Mojolicious::Lite
    my $config = plugin 'Config';
    say $config->{foo}; # says 'bar'

    # foo.html.ep
    %= $config->{foo} # evaluates to 'bar'

    # The configuration is available application-wide
    my $config = app->config;
    say $config->{foo}; # says 'bar'


    # Mojolicious in development mode
    say $config->{foo}; # says 'not_bar'
    say $config->{baz}; # says '♥'


    # Mojolicious in staging mode
    say $config->{foo}; # says 'not_bar';
    say $config->{baz}; # says '♫'

# DESCRIPTION

[Mojolicious::Plugin::CascadingConfig](https://metacpan.org/pod/Mojolicious::Plugin::CascadingConfig) is a Perl-ish configuration plugin that loads and merges config files in order, based on [Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config).

This plugin will load configs in the order specified by ["modes"](#modes) (ending with [$app-](https://metacpan.org/pod/$app-)mode|Mojolicious/mode> if it is not listed in ["modes"](#modes)), with each new config adding to
the previous config and overwriting any config key/value pairs that existed before but appeared in the config for the current mode. Once the config file is read for the mode
matching [$app-](https://metacpan.org/pod/$app-)mode|Mojolicious/mode>, the config will be returned. A file must be found for each mode specified in ["modes"](#modes).

Config filenames are generated in the form of "[$moniker](https://metacpan.org/pod/Mojolicious#moniker).$mode.conf". `production` is a special mode where the form is "[$moniker](https://metacpan.org/pod/Mojolicious#moniker).conf".

The application object can be accessed via `$app` or the `app` function,
[strict](https://metacpan.org/pod/strict), [warnings](https://metacpan.org/pod/warnings), [utf8](https://metacpan.org/pod/utf8) and Perl 5.10 [features](https://metacpan.org/pod/feature) are
automatically enabled.

If the configuration value `config_override` has been set in
["config" in Mojolicious](https://metacpan.org/pod/Mojolicious#config) when this plugin is loaded, it will not do anything.

# OPTIONS

## modes

    # Mojolicious::Lite

    # This is the default
    plugin CascadingConfig => {modes => ['production', 'development']};

Modes in the order that their config files should be loaded and merged. Any config file that is reached for a mode in ["modes"](#modes) must exist. In addition to the modes listed,
[$app-](https://metacpan.org/pod/$app-)mode|Mojolicious/mode> will be loaded if it is present once all config files have been loaded for each mode in ["modes"](#modes). The config file for 
[$app-](https://metacpan.org/pod/$app-)mode|Mojolicious/mode> is optional _only if it is not in_ ["modes"](#modes).

The default is `['production', 'development']`.

# METHODS

## register

    my $config = $plugin->register($app);
    my $config = $plugin->register($app, {modes => ['prod', 'dev', 'stage', 'qa']});

    Register plugin in L<Mojolicious> application and merge configuration.

# AUTHOR

Adam Hopkins <srchulo@cpan.org>

# COPYRIGHT

Copyright 2019- Adam Hopkins

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

- [Mojolicious::Plugin::Config](https://metacpan.org/pod/Mojolicious::Plugin::Config)
- [Mojolicious](https://metacpan.org/pod/Mojolicious)
- [Mojolicious::Guides](https://metacpan.org/pod/Mojolicious::Guides)
- [https://mojolicious.org](https://mojolicious.org)
