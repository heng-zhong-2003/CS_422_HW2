/*
Chosen exercise:

Extend your solution from Lesson 1.4, Exercise 2 to implement the rules
that define the behavior of addition, subtraction, multiplication, and
division. Do not worry about the case when the user tries to divide by zero
at this time. Use `/Int` to implement division. Test your new calculator
implementation by executing the arithmetic expressions you wrote as part of
Lesson 1.3, Exercise 2. Check to make sure each computes the value you expected.
*/

module LESSON-06-SYNTAX
  syntax Int ::= r"0|([1-9][0-9]*)" [group(literal), token]
               | "(" Int ")" [group(atom), bracket]
               | "-" Int [group(unaryminus), function]
               | Int "*" Int [group(mult), function]
               | Int "/" Int [group(div), function]
               | Int "+" Int [group(add), function]
               | Int "-" Int [group(sub), function]
  
  syntax priority literal atom > unaryminus > mult div > add sub
  syntax left mult div
  syntax left add sub
  syntax right unaryminus 
endmodule

module LESSON-06
  imports LESSON-06-SYNTAX
  imports INT

  rule - A => 0 -Int A
  rule A + B => A +Int B
  rule A - B => A -Int B
  rule A * B => A *Int B
  rule A / B => A /Int B
endmodule

/*
Test results:

Test 1: 1+2+3+4
% krun test1.int 
<k>
  10 ~> .K
</k>

Test 2: 7-2*5
% krun test2.int 
<k>
  -3 ~> .K
</k>

Test 3: 3+-2
% krun test3.int 
<k>
  1 ~> .K
</k>
*/
