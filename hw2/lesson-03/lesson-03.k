/*
Chosen exercise:

Compile `lesson-03-d.k` with ahead-of-time parsing enabled. Then compare
how long it takes to run `kast --output kore and-or-left.bool` with how long it
takes to run `lesson-03-d-kompiled/parser_PGM and-or-left.bool`. Confirm for
yourself that both produce the same result, but that the latter is faster.
*/

module LESSON-03
  syntax Boolean ::= "true" | "false"
                   | "(" Boolean ")" [bracket]
                   | "!" Boolean [function]
                   | Boolean "&&" Boolean [function]
                   | Boolean "^" Boolean [function]
                   | Boolean "||" Boolean [function]
endmodule

/*
Result:

% time ./lesson-03-kompiled/parser_PGM and-or-left.bool
inj{SortBoolean{}, SortKItem{}}(Lbl'UndsPipePipeUndsUnds'LESSON-03'Unds'Boolean'Unds'Boolean'Unds'Boolean{}(Lbl'UndsAnd-And-UndsUnds'LESSON-03'Unds'Boolean'Unds'Boolean'Unds'Boolean{}(Lbltrue'Unds'LESSON-03'Unds'Boolean{}(),Lblfalse'Unds'LESSON-03'Unds'Boolean{}()),Lblfalse'Unds'LESSON-03'Unds'Boolean{}()))
./lesson-03-kompiled/parser_PGM and-or-left.bool  0.00s user 0.00s system 71% cpu 0.004 total

% time kast --output kore and-or-left.bool             
inj{SortBoolean{}, SortKItem{}}(Lbl'UndsPipePipeUndsUnds'LESSON-03'Unds'Boolean'Unds'Boolean'Unds'Boolean{}(Lbl'UndsAnd-And-UndsUnds'LESSON-03'Unds'Boolean'Unds'Boolean'Unds'Boolean{}(Lbltrue'Unds'LESSON-03'Unds'Boolean{}(),Lblfalse'Unds'LESSON-03'Unds'Boolean{}()),Lblfalse'Unds'LESSON-03'Unds'Boolean{}()))kast --output kore and-or-left.bool  1.52s user 0.19s system 125% cpu 1.362 total

The AOT parser took 0.004 seconds, while the kast command took 1.362 seconds.
Both produced the same result, but the AOT parser was significantly faster.
*/
