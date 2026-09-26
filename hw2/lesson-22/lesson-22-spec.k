requires "lesson-22.k"
requires "domains.md"

module LESSON-22-SPEC-SYNTAX
  imports LESSON-22-SYNTAX

endmodule

module VERIFICATION
  imports K-EQUAL
  imports LESSON-22-SPEC-SYNTAX
  imports LESSON-22
  imports MAP-SYMBOLIC

endmodule

module LESSON-22-SPEC
  imports VERIFICATION

  claim <k> if ( 3 + 4 == 8 ) {
            $a = 1 ;
            } else {
            $a = 2 ;
            }
        => . ... </k>
        <store> STORE => STORE [ $a <- 2 ] </store>
endmodule

/*
Result:

% kprove lesson-22-spec.k                                                                 
#Top
*/
