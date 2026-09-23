/*
Chosen exercise:

Modify the `sum` function in `LESSON-12-C` so that the `Ints` sort is an
`NeList{}`. Verify that calling `sum()` with no arguments is now a syntax
error.
*/

module LESSON-12-A-SYNTAX
  imports INT-SYNTAX

  syntax Ints ::= NeList{Int,","}
endmodule

module LESSON-12-A
  imports LESSON-12-A-SYNTAX
endmodule

module LESSON-12
  imports LESSON-12-A
  imports INT

  syntax Int ::= sum(Ints) [function]
  rule sum(I:Int) => I
  rule sum(I1:Int, I2:Int, Is:Ints) => sum(I1 +Int I2, Is)
endmodule

/*
Test results:

% krun test-multi.sum 
<k>
  10 ~> .K
</k>

% krun test-single.sum 
<k>
  25 ~> .K
</k>

% krun test-zero-err.sum 
[Error] Inner Parser: Parse error: unexpected token ')' following token '('.
        Source(/Users/nicolasbourbaki/Desktop/PhD2Sem1/ProgrammingLanguageDesign/assignments/CS_422_HW2/hw2/lesson-12/./test-zero-err.sum)
        Location(1,5,1,6)
        1 |     sum()
          .         ^
[Error] kparse: 
/nix/store/aqjgfc96ra0v1drpil3jlx23frcz5nrb-k-7.1.337-4a46d1231473b599c699160132
fd6e76a5c46406/bin-unwrapped/kast --output kore --definition 
./lesson-12-kompiled test-zero-err.sum
[Error] krun: kparse --definition ./lesson-12-kompiled test-zero-err.sum

What `sum()` triggers is indeed a syntax/parse error, not a runtime error.
*/
