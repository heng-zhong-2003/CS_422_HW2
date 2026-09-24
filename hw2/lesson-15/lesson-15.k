/*
Chosen exercise:

Modify the definition from the previous exercise in this lesson so that the
Boolean cell you created is initialized to false. Then add a production
`syntax Stmt ::= Bool ";" Exp`, and a rule that uses this `Stmt` to set the
value of the Boolean flag. Then add another production
`syntax Stmt ::= "reset" ";" Exp` which sets the value of the Boolean flag back
to its default value via a `...` on the right-hand side. You will need to add
an additional cell around the Boolean cell to make this work.
*/

module LESSON-15-SYNTAX
  imports UNSIGNED-INT-SYNTAX
  imports BOOL-SYNTAX

  syntax IntExp ::= Int [group(literal)]
                  | "(" IntExp ")" [group(atom), bracket]
                  | "-" IntExp [group(unaryminus), seqstrict]
                  | IntExp "*" IntExp [group(mult), seqstrict]
                  | IntExp "/" IntExp [group(div), seqstrict]
                  | IntExp "+" IntExp [group(add), seqstrict]
                  | IntExp "-" IntExp [group(sub), seqstrict]

  syntax BoolExp ::= Bool [group(literal)]
                   | "(" BoolExp ")" [group(atom), bracket]
                   | IntExp "<" IntExp [group(lt), seqstrict]
                   | IntExp "<=" IntExp [group(lte), seqstrict]
                   | IntExp ">" IntExp [group(gt), seqstrict]
                   | IntExp ">=" IntExp [group(gte), seqstrict]
                   | IntExp "==" IntExp [group(eq), seqstrict]
                   | IntExp "!=" IntExp [group(neq), seqstrict]
                   | "!" BoolExp [group(not), seqstrict]
                   | BoolExp "&&" BoolExp [group(and), seqstrict]
                   | BoolExp "^" BoolExp [group(xor), seqstrict]
                   | BoolExp "||" BoolExp [group(or), seqstrict]

  syntax priority literal atom > unaryminus > mult div > add sub
      > lt lte gt gte eq neq > not > and > xor > or
  syntax right unaryminus
  syntax left mult div
  syntax left add sub
  syntax non-assoc lt lte gt gte eq neq
  syntax right not
  syntax left and
  syntax left xor
  syntax left or

  syntax Exp ::= IntExp | BoolExp | Stmt
  syntax Stmt ::= Bool ";" Exp
                | "reset" ";" Exp
endmodule

module LESSON-15
  imports LESSON-15-SYNTAX
  imports INT
  imports BOOL

  configuration <T>
    <k> $PGM:K </k>
    <state>
      <whichdiv> false </whichdiv> // false: /Int, true: divInt
    </state>
  </T>

  rule <k> I1:Int + I2:Int => I1 +Int I2 ...</k>
  rule <k> I1:Int - I2:Int => I1 -Int I2 ...</k>
  rule <k> - I:Int => 0 -Int I ...</k>
  rule <k> I1:Int * I2:Int => I1 *Int I2 ...</k>
  rule <k> I1:Int / I2:Int => I1 /Int I2 ...</k>
       <whichdiv> false </whichdiv>
      requires I2 =/=Int 0
  rule <k> I1:Int / I2:Int => I1 divInt I2 ...</k>
       <whichdiv> true </whichdiv>
      requires I2 =/=Int 0
  rule <k> I1:Int < I2:Int => I1 <Int I2 ...</k>
  rule <k> I1:Int <= I2:Int => I1 <=Int I2 ...</k>
  rule <k> I1:Int > I2:Int => I1 >Int I2 ...</k>
  rule <k> I1:Int >= I2:Int => I1 >=Int I2 ...</k>
  rule <k> I1:Int == I2:Int => I1 ==Int I2 ...</k>
  rule <k> I1:Int != I2:Int => I1 =/=Int I2 ...</k>
  rule <k> ! B:Bool => notBool B ...</k>
  rule <k> B1:Bool && B2:Bool => B1 andBool B2 ...</k>
  rule <k> B1:Bool ^ B2:Bool => B1 xorBool B2 ...</k>
  rule <k> B1:Bool || B2:Bool => B1 orBool B2 ...</k>

  rule <k> B:Bool ; E:Exp => E ...</k>
       <whichdiv> _ => B </whichdiv>
  rule <k> reset ; E:Exp => E ...</k>
       (_:StateCell => <state>... .Bag ...</state>)

  syntax Bool ::= isKResult(K) [function, symbol(isKResult)]
  rule isKResult(_:Int) => true
  rule isKResult(_:Bool) => true
  rule isKResult(_) => false [owise]
endmodule

/*
Test results:

% krun test1.txt
<T>
  <k>
    -3 ~> .K
  </k>
  <state>
    <whichdiv>
      true
    </whichdiv>
  </state>
</T>

% krun test2.txt
<T>
  <k>
    -2 ~> .K
  </k>
  <state>
    <whichdiv>
      false
    </whichdiv>
  </state>
</T>

% krun test3.txt
<T>
  <k>
    -2 ~> .K
  </k>
  <state>
    <whichdiv>
      false
    </whichdiv>
  </state>
</T>
*/
