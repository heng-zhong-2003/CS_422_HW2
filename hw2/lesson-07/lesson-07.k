/*
Chosen exercises:

Write a function `isEven` that returns whether an integer is an even number.
Use two rules and one side condition. The right-hand side of the rules should
be Boolean literals. Refer back to domains.md for the relevant
integer operations.
*/

module LESSON-07
  imports INT
  imports BOOL

  syntax Bool ::= "isEven" "(" Int ")" [function]
  rule isEven(I) => true requires I %Int 2 ==Int 0
  rule isEven(_) => false [owise]
endmodule

/*
Test results:

% krun test-even1.even 
<k>
  true ~> .K
</k>

% krun test-even2.even 
<k>
  true ~> .K
</k>

% krun test-odd1.even 
<k>
  false ~> .K
</k>

% krun test-odd2.even 
<k>
  false ~> .K
</k>
*/
