module Parser where
import CarneadesDSL
import Cyclic
import Preprocess


--Some functions to turn the input text into CarneadesDSL's types
--takes the text containing the weight and converts it to a double
stringToWeight :: String -> Double 
stringToWeight input = read (getWeight input)

standardToProp input = map standardToPropAux (getStandardSet input)
 
standardToPropAux input = mkProp (getStandard input)

--takes a list of strings of the form "[prop1, prop2, prop3]" and outputs a list of PropLiterals
stringToProp input = map mkProp (getPrems input)

--takes a list of strings of exceptions and outputs a list of PropLiterals
stringToEx input = map mkProp (getEx input)

--takes a string of the conclusion and outputs a PropLiteral
stringToCon input = mkProp (getCon input)

--takes the assumption input text and returns the assumptions - a list of PropLiterals
stringToAssumption input = mkAssumptions (getProp input)

--takes text containing the argument and outputs an argument
stringToArg input = mkArg (getPrems(input)) (getEx(input)) (getCon(input))

--takes the input text containing a list of arguments and outputs an list of Arguments
stringToListArgs input = map stringToArg (getArgSet input)

--takes the input text containing a list of arguments and outputs an ArgSet
stringToArgSet input = mkArgSet (stringToListArgs input)

--takes the input text containing a list of arguments and outputs a graph
stringToArgGraph input = mkArgGraph (stringToListArgs input)

--zips the list of arguments and their corresponding weights. This is to make it easier for me to find the ArgWeight later.
argWeightTuple:: [Char] -> [(Argument, Double)]
argWeightTuple argset = zip (stringToListArgs argset) (aux argset)
 where aux argset = map stringToWeight (newlineSplit argset)

--zips the list of standards and their PropStandards. This is to make it easier for me to find the ProofStandard
propStringTuple standardset = zip (standardToProp standardset) (getProofStandardSet standardset)
 
--finds the weight when given a tuple of arguments and their corresponding weights. This is to find the ArgWeight later.
findWeight argument [] = 0
findWeight argument ((a,w):xs)
              | a == argument = w
              | otherwise = findWeight argument xs

--takes a PropLiteral and a list of tuples of PropLiteral and their standards and searches them for the matching standard and returns the ProofStandard
findStandard :: PropLiteral -> [(PropLiteral,String)] -> ProofStandard
findStandard prop [] = scintilla
findStandard prop ((p,s):xs)
             |prop == p && s == "beyond_reasonable_doubt" = beyond_reasonable_doubt
             |prop == p && s == "clear_and_convincing" = clear_and_convincing
             |prop == p && s == "preponderance" = preponderance
             |prop == p && s == "dialectical_validity" = dialectical_validity
             |otherwise = findStandard prop xs
