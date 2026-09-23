/*
Chosen exercise:

Use the color attribute on `LESSON-09-C` to color the keywords `true` and
`false` one color, the keywords `if` and `else` another color, and the operators
`(`, `)`, `{`, and `}` a third color.
*/

module LESSON-09
  imports BOOL

  syntax Cond ::= "true" [color(yellow)]
                | "false" [color(yellow)]

  syntax Stmt ::= "{" Stmt "}" [colors(red, red), format(%1%i%n%2%d%n%3)]
              | "{" "}" [color(red), format(%1%2)]
              > right:
                Stmt Stmt [format(%1%n%2)]
              | "if" "(" Cond ")" Stmt [colors(blue, red, red),
                                        format(%1 %2%3%4 %5)]
              | "if" "(" Cond ")" Stmt "else" Stmt
                    [avoid, colors(blue, red, red, blue),
                    format(%1 %2%3%4 %5 %6 %7)]
endmodule

/*
Note that I cannot directly color the keywords `true` and `false` from `BOOL`.
Therefore, I have to define a separate `Cond`. If evaluation rules are needed
in the future, a conversion function can be defined from `Cond` to `Bool`.

Result shown in result.png.
*/
