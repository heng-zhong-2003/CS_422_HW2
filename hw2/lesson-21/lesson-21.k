/*
Chosen exercise:

Create another rule in `LESSON-21` that rewrites odd integers greater than
ten to a symbolic even integer less than 10 and greater than 0. This rule will
now apply nondeterministically along with the existing rules. Predict what the
resulting output configuration will be from rewriting `0` after adding this
rule. Then run the program and see whether your prediction is correct.
*/

module LESSON-21
    imports INT
    imports BOOL

    rule <k> 0 => ?X:Int ... </k> ensures ?X =/=Int 0
    rule <k> X:Int => 5  ... </k> requires X >=Int 10
    rule <k> X:Int => ?Y:Int ...</k>
        requires X >Int 10 andBool X %Int 2 ==Int 1
        ensures ?Y >Int 0 andBool ?Y <Int 10 andBool ?Y %Int 2 ==Int 0
endmodule

/*
Predictions:

1. 0 matches the first rule and ?X does not satisfy the requirements of the
   second or third. The program terminates.
2. ?X satisfies the requirements of the second rule, which (possibly non-
   deterministically) applies and rewrites ?X to 5. Then, the program
   terminates because no rule applies.
3. ?X satisfies the requirements of the third rule, which (possibly non-
   deterministically) applies and rewrites ?X to an even integer less than 10
   and greater than 0. Then, the program terminates because no rule applies.

Test result:

% krun -cPGM=0
    #Not ( {
        1
      #Equals
        ?X:Int %Int 2
      }
    #And
      {
        true
      #Equals
        ?X:Int >Int 10
      } )
  #And
    #Not ( {
      ?X:Int
    #Equals
      0
    } )
  #And
    #Not ( {
      true
    #Equals
      ?X:Int >=Int 10
    } )
  #And
    <k>
      ?X:Int ~> .K
    </k>
#Or
    #Not ( {
      ?X:Int
    #Equals
      0
    } )
  #And
    #Not ( {
      ?Y:Int
    #Equals
      0
    } )
  #And
    #Not ( {
      true
    #Equals
      ?Y:Int >=Int 10
    } )
  #And
    <k>
      ?Y:Int ~> .K
    </k>
  #And
    {
      0
    #Equals
      ?Y:Int %Int 2
    }
  #And
    {
      1
    #Equals
      ?X:Int %Int 2
    }
  #And
    {
      true
    #Equals
      ?X:Int >Int 10
    }
  #And
    {
      true
    #Equals
      ?Y:Int <Int 10
    }
  #And
    {
      true
    #Equals
      ?Y:Int >Int 0
    }
#Or
    #Not ( {
      ?X:Int
    #Equals
      0
    } )
  #And
    <k>
      5 ~> .K
    </k>
  #And
    {
      true
    #Equals
      ?X:Int >=Int 10
    }

The actual output of running the program indeed matches the predictions.
*/
