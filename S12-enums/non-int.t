use v6;
use Test;
plan 6;

{
    my enum A (a => 'foo', b => 'bar');
    is a.Str, 'foo', 'stringy enum first value';
    is b.Str, 'bar', 'stringy enum first value';
}

eval-dies-ok 'my enum B (a => 1, b => "bar")',
             'mixed type enums are forbidden';

#?rakudo todo 'NYI RT #124833'
#?niecza todo
eval-lives-ok 'my Cool enum C (a => 1, b => "bar")',
             '... unless that type covers both enum value types';

#?niecza todo
eval-dies-ok 'my Str enum D (a => 1)',
             'violating an explicit type constraint dies';

{
    my enum E ( a => 'x', 'b');
    is E::b.Str, 'y', 'Str enum correctly uses string-increment';
}
