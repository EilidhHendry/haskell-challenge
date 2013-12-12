README


Syntax


In order to create your own test of this argumentative system please create 3 individual text files for the arguments, assumptions and standard. When writing these text files please follow these simple syntax rules:


The Arguments File
All arguments must be of the form:
arg1 [premise1, premise2, etc] [exception1, exception2, etc] conclusion weight
where arg1 is your argument identifier,
where [premise1, premise2, etc] is your list of premises. It is very important that this list is surrounded by a set of square brackets and each item in the list is separated by a comma.
where [exception1, exception2, etc] is your list of exceptions. It is very important that this list is surrounded by a set of square brackets and each item in the list is separated by a comma.
where conclusion is a your conclusion. It is important that this is separated from the weight by a space.
where weight is your weight. It is important this is a numeric value.
To negate any of the premises, exceptions or conclusion terms simply put a “-” before them.


The Assumptions File
All assumptions should be of the form:
[assumption1, assumption2, etc]
This is your list of assumptions. It is important that each individual item in the list is separated by a comma.


The Standard File
The standards should be of the form:
standard, ProofStandard
where standard is the thing you are trying to prove and ProofStandard is your proof standard. It is important that your proof standard is either empty or of the form beyond_reasonable_doubt, clear_and_convincing, preponderance, dialectical_validity. It is important that the standard and ProofStandard are separated by a comma even if you are not entering a proof standard.


How To Test
Then in order to test my implementation using your test files (or the ones provided) simply run the Main module (using the command ./Main), then enter the names of your test files when requested and finally what you want to test for e.g. “-murder”


My Test Files
The folder contains the files “exampleargs.txt”, “exampleassumptions.txt” and “examplestandard.txt”. These are files I made for my own testing purposes to imitate the example given in “Haskell Gets Argumentative” by Bas van Gijzel and Henrik Nilsson. When asked to test for “murder” it should return false. When asked to test for “-murder” it should also return false.


I also created 3 test files which are to evaluate the argument for Scottish Independence. To use my test files enter “argtest.txt” when the arguments file is requested, “assumptionstest.txt” when asked for the assumptions file and “standardtest.txt” when asked for the standard file. When asked what you would like to test for enter “independence” or “-independence.” It should return False when testing for “independence” and False when testing “-independence”.