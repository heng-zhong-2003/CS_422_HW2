/*
Chosen exercise:

Write a simple grammar containing at least one ambiguity that cannot be
resolved via priority or associativity, and then use the `prefer` attribute to
resolve that ambiguity.
*/

module LESSON-04
  syntax Exp ::= "true" | "false"

  syntax Stmt ::= "if" "(" Exp ")" Stmt [prefer]
                | "if" "(" Exp ")" Stmt "else" Stmt
                | "{" "}"
endmodule

/*
This is the same grammar as the `if` example in Lesson 04, but ambiguity is
resolved by `perfer` instead of `avoid`.

The output is:

% kast dangling-else.if 
`if(_)__LESSON-04_Stmt_Exp_Stmt`(
  `true_LESSON-04_Exp`(.KList),
  `if(_)_else__LESSON-04_Stmt_Exp_Stmt_Stmt`(
    `false_LESSON-04_Exp`(.KList),
    `{}_LESSON-04_Stmt`(.KList),
    `{}_LESSON-04_Stmt`(.KList)))

where the `else` clause is indeed a child of the inner `if` statement, as it
should be when using `avoid`.
*/
