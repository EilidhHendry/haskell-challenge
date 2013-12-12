module Preprocess
(commaSplit,
bracketSplit,
closeSplit,
newlineSplit,
removeBothBracket,
removeBracket,
removeComma,
cleanUp,
removeWhitespace,
getProp,
getArg,
removeArg,
getPrems,
removePrems,
getEx,
removeEx,
getCon,
removeCon,
getWeight,
getArgSet,
getStandard,
getProofStandard,
getStandardSet,
getProofStandardSet) where


import Data.List.Split
import Data.Char


--Some functions to help me split the text into meaningful components
--splits on a ','
commaSplit input = splitOn "," input

--splits on '['
bracketSplit input = splitOn "[" input

--splits on a closing bracket
closeSplit input = splitOn "]" input 

--splits on a newline character
newlineSplit input = splitOn "/n" input


--Some functions to help me 'clean up' the text by removing punctuation and whitespace
--removes square brackets
removeBothBracket = removeLeftBracket . removeRightBracket
 where removeRightBracket = filter(/=']')
       removeLeftBracket = filter(/='[')

--removes curved brackets
removeBracket = filter(/=')')

--removes commas
removeComma = filter(/=',')

--combines removing commas and brackets.
cleanUp []            = [] 
cleanUp (string:list) = removeComma (removeBothBracket string) : cleanUp list

--removes whitespace
removeWhitespace = map removeSpace
 where removeSpace input = (unwords (words input))


--Some functions to combine all the functions defined above to separate the input text into individual items
--gets the individual propositions from a list of propositions
getProp input = removeWhitespace (cleanUp (commaSplit input))

--gets the argument identifier from an argument input text
getArg input = head(removeWhitespace (bracketSplit input))

--removes the argument identifier
removeArg input = drop 1 (bracketSplit input)

--gets the list of prepositions
getPrems input = getProp (head (removeArg input))

--removes the list of prepositions and the argument identifier
removePrems input = drop 1 (removeArg input)

--gets the list of exceptions
getEx input = getProp (findEx input)
 where findEx input = head (closeSplit (head (removePrems input)))

--removes the exceptions, prepositions and argument identifier
removeEx input = drop 1 (closeSplit (head (removePrems input)))
 
--gets the conclusion from the argument
getCon input = getConAux (removeEx input)
 where getConAux input = takeWhile (not .  isSpace) (head (removeWhitespace input))

--removes the conclusion from the argument
removeCon input = removeConAux (removeEx input)
 where removeConAux input = dropWhile (not .  isSpace) (head (removeWhitespace input))

--gets the weight from the argument input text
getWeight input = dropWhile isSpace (removeCon input)

getStandard input = head (removeWhitespace (commaSplit input)) 

getProofStandard input = head (tail (removeWhitespace (commaSplit input)))

getStandardSet input = map getStandard (getArgSet input)

getProofStandardSet input = map getProofStandard (getArgSet input)

--getStandard3 input = takeWhile (isSpace) (head (removeWhitespace (getArgSet (input))))
--gets the second argument from the standard
--getStandard input = dropWhile isSpace (head (getStandardAux input))
 --where getStandardAux input = drop 1 (commaSplit (removeBracket input))

--separates the list of input arguments into separate arguments
getArgSet input = newlineSplit input

--Some testing inputs
--test argument. getArg should return "a1". getPrem should return ["prem1","prem2", "prem3"]. getEx should return ["ex1","ex2"]. getCon should return conclusion and getWeight should return "weight"
argtest = "a1 [-prem1, prem2,prem3] [ex1, ex2] conclusion 0.8"
proptest = "[-prop1, prop2, prop3]"
standardtest = "(_, intent)"
argsettest ="a1 [-prem1, prem2,prem3] [ex1, ex2] conclusion 4.2 /n a2 [-prem1, prem2,prem3] [ex1, ex2] conclusion 0.8"
standardset = "intent, beyond_reasonable_doubt"
