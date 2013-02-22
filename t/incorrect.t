use strict;
use warnings;
use Test::More;
use Data::Page;

sub main {
    my $page = Data::Page->new();

    my $incorrect_number = { aa => 'bb' };

    my $methods = [
        {
            name => 'total_entries',
            default => 0,
        },
        {
            name => 'entries_per_page',
            default => 0,
        },
        {
            name => 'current_page',
            default => 0,
        },
    ];

    foreach my $method (@{$methods}) {
        my $name = $method->{name};
        eval {
            $page->$name($incorrect_number);
        };

        like (
            $@,
            qr/Expected scalar, but got '/,
            "Can't use hashref in $method->{name}()"
        );

        is(
            $page->total_entries(),
            $method->{default},
            "$method->{name}() default is $method->{default}");

    }

    done_testing();
}

main();
