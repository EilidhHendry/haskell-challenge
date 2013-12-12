module Main where
import CarneadesDSL
import Cyclic
import Parser
import System.IO


main = do
 putStrLn "Enter name of arguments file"    
 argfilename <- getLine
 putStrLn "Enter name of assumptions file"
 assfilename <- getLine
 putStrLn "Enter name of standard file"
 standfilename <- getLine
 putStrLn "What do you want to test for?"
 finaltest <- getLine
-- let argfilename = "argtest.txt"
-- let assfilename = "assumptionstest.txt"
-- let standfilename = "standardtest.txt"
 argfile <- readFile argfilename      --read the given files and store 
 assfile <- readFile assfilename 
 standfile <- readFile standfilename 
 let assumptions = stringToAssumption assfile   -- create assumptions
 let arguments = stringToArgSet argfile         -- create ArgSet
 let findargweight argument = findWeight argument (argWeightTuple argfile)  --function for finding argWeight
 let graph = stringToArgGraph argfile           -- create Graph
 let standards prop = findStandard prop (propStringTuple standfile) 
 let audience = (assumptions, findargweight)    -- create audience
 let caes = CAES (graph, audience, standards) -- create CAES
 let testAcceptable = acceptable (mkProp finaltest) caes
 putStr "Acceptable: " 
 putStrLn (show testAcceptable)