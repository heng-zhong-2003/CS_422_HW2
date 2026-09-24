/*
Chosen exercise:

Modify your solution to Lesson 1.16, Exercise 1 and introduce an `if`
`Stmt` to the syntax of the language, then implement it using the `#if` symbol.
Make sure to write tests for the resulting interpreter.
*/

module LESSON-18-SYNTAX
  imports UNSIGNED-INT-SYNTAX
  imports BOOL-SYNTAX
  imports ID-SYNTAX

  syntax IntExp ::= Int [group(literal)]
                  | "(" IntExp ")" [group(atom), bracket]
                  | "-" IntExp [group(unaryminus), seqstrict]
                  | IntExp "*" IntExp [group(mult), seqstrict]
                  | IntExp "/" IntExp [group(div), seqstrict]
                  | IntExp "+" IntExp [group(add), seqstrict]
                  | IntExp "-" IntExp [group(sub), seqstrict]
                  | Id [group(id)]

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
                   | Id [group(id)]

  syntax priority literal atom id > unaryminus > mult div > add sub
      > lt lte gt gte eq neq > not > and > xor > or
  syntax right unaryminus
  syntax left mult div
  syntax left add sub
  syntax non-assoc lt lte gt gte eq neq
  syntax right not
  syntax left and
  syntax left xor
  syntax left or

  syntax Id ::= "main" [token]
  syntax Exp ::= IntExp | BoolExp | Id | Id "(" ")"
  syntax VarDecl ::= "int" Id "=" IntExp ";" [strict(2)]
                   | "bool" Id "=" BoolExp ";" [strict(2)]
  syntax FunDecl ::= "fun" Id "(" ")" "{" Stmts "}"
  syntax Decl ::= FunDecl
  syntax Decls ::= List{Decl, ""}
  syntax Stmt ::= VarDecl
                | "return" Exp ";" [strict]
                | Id ":=" Exp ";" [strict(2)]
                | "if" BoolExp "then" Stmts "endif" [strict(1)]
  syntax Stmts ::= List{Stmt, ""}
  syntax Pgm ::= Decls
endmodule

module LESSON-18
  imports LESSON-18-SYNTAX
  imports INT
  imports BOOL
  imports MAP
  imports LIST
  imports K-EQUAL

  configuration <T>
    <k> $PGM:Pgm ~> main () </k>
    <state> .Map </state> // Id -> Int | Bool, variable names to values.
    <functions>
      <function multiplicity="*" type="Map">
        <id> main </id>
        <body> .Stmts </body>
      </function>
    </functions> // Id -> Stmts, function names to bodies.
    <fstack> .List </fstack> // Stack (list) of where to return to.
    <envstack> .List </envstack> // Stack (list) of local environments.
  </T>

  rule <k> I1:Int + I2:Int => I1 +Int I2 ...</k>
  rule <k> I1:Int - I2:Int => I1 -Int I2 ...</k>
  rule <k> - I:Int => 0 -Int I ...</k>
  rule <k> I1:Int * I2:Int => I1 *Int I2 ...</k>
  rule <k> I1:Int / I2:Int => I1 /Int I2 ...</k> requires I2 =/=Int 0
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

  rule <k> X:Id => V ...</k>
       <state>... X |-> V ...</state>

  rule <k> D:Decl DS:Decls => D ~> DS ...</k>
  rule <k> .Decls => .K ...</k>

  rule <k> S:Stmt SS:Stmts => S ~> SS ...</k>
  rule <k> .Stmts => .K ...</k>

  rule <k> int X:Id = I:Int ; => .K ...</k>
       <state> STATE => STATE [X <- I] </state>
  rule <k> bool X:Id = B:Bool ; => .K ...</k>
       <state> STATE => STATE [X <- B] </state>
  rule <k> fun F:Id () { S:Stmts } => .K ...</k>
       (.Bag => <function> <id> F </id> <body> S </body> </function>)

  rule <k> X:Id := I:Int ; => .K ...</k>
       <state>... X |-> (_:Int => I) ...</state>
  rule <k> X:Id := B:Bool ; => .K ...</k>
       <state>... X |-> (_:Bool => B) ...</state>
  rule <k> if B:Bool then S:Stmts endif
           => #if B #then S #else .K #fi ...</k>
  
  syntax KItem ::= stackFrame(K)

  rule <k> F:Id () ~> K => S </k>
       <function> <id> F </id> <body> S </body> </function>
       <fstack> .List => ListItem(stackFrame(K)) ...</fstack>
       <state> STATE => .Map </state>
       <envstack> .List => ListItem(STATE) ...</envstack>

  rule <k> return I:Int ; ~> _ => I ~> K </k>
       <fstack> ListItem(stackFrame(K)) => .List ...</fstack>
       <envstack> ListItem(STATE) => .List ...</envstack>
       <state> _ => STATE </state>
  rule <k> return B:Bool ; ~> _ => B ~> K </k>
       <fstack> ListItem(stackFrame(K)) => .List ...</fstack>
       <envstack> ListItem(STATE) => .List ...</envstack>
       <state> _ => STATE </state>

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
    12 ~> .K
  </k>
  <state>
    .Map
  </state>
  <functions>
    <function>
      <id>
        main
      </id>
      <body>
        int x = 7 ;  int y = 12 ;  int max = x ;  if x < y then max := y ;  .Stmts endif  if max == x then max := 0 - 1 ;  .Stmts endif  return max ;  .Stmts
      </body>
    </function>
  </functions>
  <fstack>
    .List
  </fstack>
  <envstack>
    .List
  </envstack>
</T>

% krun test2.txt 
<T>
  <k>
    29 ~> .K
  </k>
  <state>
    .Map
  </state>
  <functions>
    <function>
      <id>
        main
      </id>
      <body>
        int s = 0 ;  int r = 0 ;  bool big = false ;  s := sign ( ) ;  if s < 0 then r := 10 ;  if ! big && r >= 10 then big := true ;  r := r * 3 ;  .Stmts endif  .Stmts endif  if big then return r + s ;  .Stmts endif  return 0 ;  .Stmts
      </body>
    </function> <function>
      <id>
        sign
      </id>
      <body>
        int n = 0 - 5 ;  if n > 0 then return 1 ;  .Stmts endif  if n == 0 then return 0 ;  .Stmts endif  return 0 - 1 ;  .Stmts
      </body>
    </function>
  </functions>
  <fstack>
    .List
  </fstack>
  <envstack>
    .List
  </envstack>
</T>
*/
