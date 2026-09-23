/*
Chosen exercise:

Write a function that takes a paragraph of text (I.e., a sequence of
sentences, each ending in a period), and constructs a new (nonsense) sentence
composed of the first word of each sentence, followed by a period. Do not
worry about capitalization or periods within the sentence which do not end the
sentence (e.g. "Dr."). You can assume that all whitespace within the paragraph
are spaces. For more information about the functions over strings required to
implement such a function, refer to `domains.md`.
*/

module LESSON-10
  imports STRING
  imports INT
  imports BOOL

  syntax String ::= firstWords(String) [function]
                  | firstWord(String) [function]
                  | firstSentence(String) [function]
                  | trimLeft(String) [function]

  syntax Int ::= firstSentenceEnd(String) [function]
               | firstSentenceIter(String, Int) [function] // exclusive end

  rule trimLeft(S) => trimLeft(substrString(S, 1, lengthString(S)))
      requires (lengthString(S) >Int 0
                andBool substrString(S, 0, 1) ==String " ")
  rule trimLeft(S) => S [owise]
  rule firstSentenceIter(S, I) => I requires lengthString(S) ==Int 0
  rule firstSentenceIter(S, I) => I +Int 1
      requires (lengthString(S) >Int 0
                andBool substrString(S, 0, 1) ==String ".")
  rule firstSentenceIter(S, I) =>
      firstSentenceIter(substrString(S, 1, lengthString(S)), I +Int 1) [owise]
  rule firstSentence(S) => trimLeft(substrString(S, 0, firstSentenceEnd(S)))
  rule firstSentenceEnd(S) => firstSentenceIter(S, 0)
  rule firstWord(S) => substrString(S, 0, findChar(S, " .", 0))
      requires findChar(S, " .", 0) =/=Int -1
  rule firstWord(S) => S [owise]
  rule firstWords(S) => "" requires lengthString(S) ==Int 0
  rule firstWords(S) => firstWord(firstSentence(S)) +String "."
      requires (lengthString(S) >Int 0
                andBool trimLeft(substrString(S, firstSentenceEnd(S),
                                              lengthString(S))) ==String "")
  rule firstWords(S) => firstWord(firstSentence(S)) +String " "
      +String firstWords(
          trimLeft(substrString(S, firstSentenceEnd(S), lengthString(S))))
      [owise]
endmodule

/*
Test results:

% krun test1.txt
<k>
  "aa dd ffff." ~> .K
</k>

% krun test2.txt
<k>
  "aaa ajlj WWWWW." ~> .K
</k>
*/
