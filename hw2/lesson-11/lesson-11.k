/*
Chosen exercise:

Extend the `eval` function in `LESSON-11-E` to include Strings and add a `.`
operator which concatenates them.
*/

module LESSON-11
  imports INT
  imports BOOL
  imports STRING

  syntax Exp ::= Int | Bool | Exp "+" Exp | Exp "&&" Exp | String | Exp "." Exp

  syntax Exp ::= eval(Exp) [function]

  rule eval(I:Int) => I
  rule eval(B:Bool) => B
  rule eval(S:String) => S
  rule eval(E1 + E2) => {eval(E1)}:>Int +Int {eval(E2)}:>Int
  rule eval(E1 && E2) => {eval(E1)}:>Bool andBool {eval(E2)}:>Bool
  rule eval(S1 . S2) => {eval(S1)}:>String +String {eval(S2)}:>String
endmodule

/*
Test result:

% krun test.eval
<k>
  "aaabbbbb" ~> .K
</k>

% krun test-type-err.eval 
[Error] krun: ./lesson-11-kompiled/interpreter 
/var/folders/l9/mcwjkdv110b5nj8xn6dgtk_h0000gn/T/.krun-2026-09-23-16-39-05-ig1sU
QZRLn/tmp.in.wuZnaUk93b -1 
/var/folders/l9/mcwjkdv110b5nj8xn6dgtk_h0000gn/T/.krun-2026-09-23-16-39-05-ig1sU
QZRLn/result.kore
project:String ( 3 ~> .K )
*/
