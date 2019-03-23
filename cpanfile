requires 'perl', '5.008005';

requires 'Mojolicious', '7.15';

on test => sub {
    requires 'Test::More', '0.96';
    requires 'Test::Exception';
};
