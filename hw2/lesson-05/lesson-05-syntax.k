module LESSON-05-SYNTAX
  syntax Color ::= Yellow()
                 | Blue()
                 | Kiwi()
                 | colorOf(Fruit) [function]
  syntax Fruit ::= Banana()
                 | Blueberry()
endmodule
