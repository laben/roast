# S02-literals/allomorphic.t --- Tests for the various allmorphic types, and val() processing

use v6;
use Test;

# L<S02/Allomorphic value semantics>

plan 93;

## Sanity tests (if your compiler fails these, there's not much hope for the
## rest of the test)

#?rakudo skip 'undeclared routine'
lives-ok val("foo"), "val() exists";

## IntStr

#?rakudo skip 'val and IntStr NYI'
{
    my $intval = val("42");

    isa-ok $intval, IntStr, "val(\"42\") returns an IntStr";
    isa-ok $intval, Int,    "val(\"42\") can be an Int";
    isa-ok $intval, Str,    "val(\"42\") can be a Str";

    is $intval, 42, "val(\"42\") is equal to integer 42";
    is $intval, "42", "val(\"42\") is equal to string \"42\"";
}

#?rakudo skip 'val and IntStr NYI'
{
    my $intval = val("    -42");

    isa-ok $intval, IntStr, "val(\"    -42\") returns an IntStr";
    isa-ok $intval, Int,    "val(\"    -42\") can be an Int";
    isa-ok $intval, Str,    "val(\"    -42\") can be a Str";

    is $intval, -42, "val(\"    -42\") is equal to integer -42";
    is $intval, "    -42", "val(\"    -42\") is equal to string \"    -42\"";
}

## RatStr

#?rakudo skip 'val and RatStr NYI'
{
    my $ratval = val("1/5");

    isa-ok $ratval, RatStr, "val(\"1/5\") returns a RatStr";
    isa-ok $ratval, Rat,    "val(\"1/5\") can be a Rat";
    isa-ok $ratval, Str,    "val(\"1/5\") can be a Str";

    is $ratval, 0.2,   "val(\"1/5\") is equal to rational 0.2";
    is $ratval, "1/5", "val(\"1/5\") is equal to string \"1/5\"";
}

#?rakudo skip 'val and RatStr NYI'
{
    my $ratval = val(" -0.7\t");

    isa-ok $ratval, RatStr, "val(\" -0.7\\t\") returns a RatStr";
    isa-ok $ratval, Rat,    "val(\" -0.7\\t\") can be a Rat";
    isa-ok $ratval, Str,    "val(\" -0.7\\t\") can be a Str";

    is $ratval, -0.7, "val(\" -0.7\\t\") is equal to rational -0.7";
    is $ratval, " -0.7\t", "val(\" -0.7\\t\") is equal to string \" -0.7\\t\"";
}

## NumStr

#?rakudo skip 'val and NumStr NYI'
{
    my $numval = val("6.02e23");

    isa-ok $numval, NumStr, "val(\"6.02e23\") returns a NumStr";
    isa-ok $numval, Num,    "val(\"6.02e23\") can be a Num";
    isa-ok $numval, Str,    "val(\"6.02e23\") can be a Str";

    is $numval, 6.02e23, "val(\"6.02e23\") is equal to floating-point 6.02e23";
    is $numval, "6.02e23", "val(\"6.02e23\") is equal to string \"6.02e23\"";
}

#?rakudo skip 'val and NumStr NYI'
{
    my $numval = val("+1.200e-10  ");

    isa-ok $numval, NumStr, "val(\"+1.200e-10  \") returns a NumStr";
    isa-ok $numval, Num,    "val(\"+1.200e-10  \") can be a Num";
    isa-ok $numval, Str,    "val(\"+1.200e-10  \") can be a Str";

    is $numval, 1.2e-10, "val(\"+1.200e-10  \") is equal to floating-point 1.2e-10";
    is $numval, "+1.200e-10  ", "val(\"+1.200e-10  \") is equal to string \"+1.200e-10  \"";
}

## ComplexStr

#?rakudo skip 'val and ComplexStr NYI'
{
    my $cmpxval = val("1+2i");

    isa-ok $cmpxval, ComplexStr, "val(\"1+2i\") returns a ComplexStr";
    isa-ok $cmpxval, Complex,    "val(\"1+2i\") can be a Complex";
    isa-ok $cmpxval, Str,        "val(\"1+2i\") can be a Str";

    is $cmpxval, (1+2i), "val(\"1+2i\") is equal to complex number 1+2i";
    is $cmpxval, "1+2i", "val(\"1+2i\") is equal to string \"1+2i\"";
}

#?rakudo skip 'val and ComplexStr NYI'
{
    my $cmpxval = val(" +1.0+-3.2i ");

    isa-ok $cmpxval, ComplexStr, "val(\" +1.0+-3.2i \") returns a ComplexStr";
    isa-ok $cmpxval, Complex,    "val(\" +1.0+-3.2i \") can be a Complex";
    isa-ok $cmpxval, Str,        "val(\" +1.0+-3.2i \") can be a Str";

    is $cmpxval, (1-3.2i), "val(\" +1.0+-3.2i \") is equal to complex number 1-3.2i";
    is $cmpxval, " +1.0+-3.2i ", "val(\" +1.0+-3.2i \") is equal to string \" +1.0+-3.2i \"";
}

# Note: L<S02/The :val modifier> seems to suggest that version literals and
# enums would be recognized by val() as well, which implies a VersionStr (not
# fundamentally different from the others) and some kind of EnumStr that sounds
# quite a bit more interesting.

## Quoting forms (consider using subtests on these?)

#?rakudo skip 'Allomorphic types NYI'
{
    my @wordlist = qw[1 2/3 4.5 6e7 8+9i] Z (IntStr, RatStr, RatStr, NumStr, ComplexStr);

    for @wordlist -> $val, $wrong-type {
        isa-ok $val, Str, "'$val' from qw[] is a Str";
        nok $val.isa($wrong-type), "'$val' from qw[] is not a $wrong-type";
    }
}

#?rakudo skip 'Allomorphic types NYI'
{
    my @wordlist = qqww[1 2/3 4.5 6e7 8+9i] Z (IntStr, RatStr, RatStr, NumStr, ComplexStr);

    for @wordlist -> $val, $wrong-type {
        isa-ok $val, Str, "'$val' from qqww[] is a Str";
        nok $val.isa($wrong-type), "'$val' from qqww[] is not a $wrong-type";
    }
}

#?rakudo skip ':v and allomorphic types NYI'
{
    my @wordlist  = qw:v[1 2/3 4.5 6e7 8+9i];
    my @purenum   = Int, Rat, Rat, Num, Complex;
    my @allotypes = IntStr, RatStr, RatStr, NumStr, ComplexStr;

    for (@wordlist Z @purenum Z @allotypes) -> $val, $ntype, $atype {
        isa-ok $val, Str,    "'$val' from qw:v[] is a Str";
        isa-ok $val, $ntype, "'$val' from qw:v[] is a $ntype";
        isa-ok $val, $atype, "'$val' from qw:v[] is a $atype";
    }
}

#?rakudo skip ':v and allomorphic types NYI'
{
    my @wordlist  = qqww:v[1 2/3 4.5 6e7 8+9i];
    my @purenum   = Int, Rat, Rat, Num, Complex;
    my @allotypes = IntStr, RatStr, RatStr, NumStr, ComplexStr;

    for (@wordlist Z @purenum Z @allotypes) -> $val, $ntype, $atype {
        isa-ok $val, Str,    "'$val' from qw:v[] is a Str";
        isa-ok $val, $ntype, "'$val' from qw:v[] is a $ntype";
        isa-ok $val, $atype, "'$val' from qw:v[] is a $atype";
    }
}

#?rakudo skip ':v NYI'
{
    my @written = qw:v[1 2/3 4.5 6e7 8+9i ten];
    my @angled  =     <1 2/3 4.5 6e7 8+9i ten>;

    is-deeply @angled, @written, "<...> is equivalent to qw:v[...]";
}

#?rakudo skip ':v NYI'
{
    my $num = "4.5";
    my @written = qqww:v[1 2/3 $num 6e7 8+9i ten];
    my @angled  =       «1 2/3 $num 6e7 8+9i ten»;

    is-deeply @angled, @written, "«...» is equivalent to qqww:v[...]";
}