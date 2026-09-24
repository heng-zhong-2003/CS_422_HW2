/*
Chosen exercise:

Add integer division to `LESSON-14-D`. Make division and addition `strict`
instead of `seqstrict`, and write a rule evaluating integer division with a
side condition that the denominator is non-zero. Run `krun --search` on the
program `1 / 0 + 2 / 1` and observe all possible outputs of the program. How
many are there total, and why?
*/

module LESSON-14-D-SYNTAX
  imports UNSIGNED-INT-SYNTAX
  imports BOOL-SYNTAX

  syntax Exp ::= Int
               | Bool
               > left: Exp "/" Exp [strict]
               > left: Exp "+" Exp [strict]
               > left: Exp "&&" Exp [strict]
endmodule

module LESSON-14
  imports LESSON-14-D-SYNTAX
  imports INT
  imports BOOL

  rule <k> I1:Int + I2:Int => I1 +Int I2 ...</k>
  rule <k> I1:Int / I2:Int => I1 /Int I2 ...</k> requires I2 =/=Int 0
  rule <k> B1:Bool && B2:Bool => B1 andBool B2 ...</k>

  syntax Bool ::= isKResult(K) [function, symbol(isKResult)]
  rule isKResult(_:Int) => true
  rule isKResult(_:Bool) => true
  rule isKResult(_) => false [owise]
endmodule

/*
Test result:

% krun --search test.txt             
  {
    Result:GeneratedTopCell
  #Equals
    <k>
      1 / 0 ~> #freezer_+__LESSON-14-D-SYNTAX_Exp_Exp_Exp0_ ( 2 / 1 ~> .K ) ~> .K
    </k>
  }
#Or
  {
    Result:GeneratedTopCell
  #Equals
    <k>
      1 / 0 ~> #freezer_+__LESSON-14-D-SYNTAX_Exp_Exp_Exp0_ ( 2 ~> .K ) ~> .K
    </k>
  }

There are two possible executions of the program. The first one evaluates
`1 / 0` first, for which no rule applies because of the side condition. The
second one evaluates `2 / 1` first, which rewrites to 2 and is then frozen when
evaluating `1 / 0` next, for which no rule applies.
*/
