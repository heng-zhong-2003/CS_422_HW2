/*
Chosen exercise:

Modify `lesson-02-d.k` from Lesson 1.2 so that the rules and syntax are in
separate modules in separate files.
*/

requires "lesson-05-syntax.k"

module LESSON-05
  imports LESSON-05-SYNTAX

  rule colorOf(Banana()) => Yellow()
  rule colorOf(Blueberry()) => Blue()
endmodule

/*
Running a test program, we get the result:

% krun -cPGM='colorOf(Blueberry())' --definition 'lesson-05-kompiled'
<k>
  Blue ( ) ~> .K
</k>

which is the same as that of the original `LESSON-02-D`.
*/
