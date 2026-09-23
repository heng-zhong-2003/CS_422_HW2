/*
Chosen exercise:

Compile this lesson with the selector expression `k & (! foo)` and confirm
that you get a parser error if you try to evaluate the `foo` function with the
resulting definition.

This exercise requires no code in this k file. The process of doing
this exercise is as follows.

% kompile --md-selector 'k & (! foo)' --main-module LESSON-08 README.md
[Warning] Compiler: Could not find main syntax module with name
LESSON-08-SYNTAX in definition.  Use --syntax-module to specify one. Using
LESSON-08 as default.

% krun -cPGM='foo(0)'
[Error] Inner Parser: Parse error: unexpected token '(' following token 'foo'.
        Source(/var/folders/l9/mcwjkdv110b5nj8xn6dgtk_h0000gn/T/.krun-2026-09-23-14-03-11-rbKRSwfJvt/tmp.PGM.pretty.BGlGufyuJE)
        Location(1,4,1,5)
        1 |     foo(0)
          .        ^
[Error] kparse: 
/nix/store/aqjgfc96ra0v1drpil3jlx23frcz5nrb-k-7.1.337-4a46d1231473b599c699160132
fd6e76a5c46406/bin-unwrapped/kast --output kore --definition ./README-kompiled 
--module LESSON-08 
/var/folders/l9/mcwjkdv110b5nj8xn6dgtk_h0000gn/T/.krun-2026-09-23-14-03-11-rbKRS
wfJvt/tmp.PGM.pretty.BGlGufyuJE
[Error] krun: kparse --definition ./README-kompiled --module LESSON-08 
/var/folders/l9/mcwjkdv110b5nj8xn6dgtk_h0000gn/T/.krun-2026-09-23-14-03-11-rbKRS
wfJvt/tmp.PGM.pretty.BGlGufyuJE

The interpreter indeed errored when parsing `foo(0)`.
*/
