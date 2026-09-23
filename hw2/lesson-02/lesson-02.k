/*
Chosen exercise:

Create a new definition which defines an outfit as a multi-argument constructor 
consisting of a hat, shirt, pants, and shoes. Define a new sort
`Boolean` with two constructors, true and false. Productions for hat, shirt, pants,
and shoes will have a single argument each&mdash;a color, either black or
white. Then define an `outfitMatching` function that will return true if all
the pieces of the outfit are the same color. You do not need to define the
case that returns false. Execute your program on different values to see that 
your function behaves the way you expect.
*/

module LESSON-02
  syntax Boolean ::= True() | False()
  syntax Color ::= Black() | White()
  syntax Hat ::= Hat(Color)
  syntax Shirt ::= Shirt(Color)
  syntax Pants ::= Pants(Color)
  syntax Shoes ::= Shoes(Color)
  syntax Outfit ::= Outfit(Hat, Shirt, Pants, Shoes)
  syntax Boolean ::= outfitMatching(Outfit) [function]

  rule outfitMatching(Outfit(Hat(Black()), Shirt(Black()),
                             Pants(Black()), Shoes(Black()))) => True()
  rule outfitMatching(Outfit(Hat(White()), Shirt(White()),
                             Pants(White()), Shoes(White()))) => True()
endmodule
