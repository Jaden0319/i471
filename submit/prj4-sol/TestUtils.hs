module TestUtils (onlyTests, runTests, SuiteStatus(..), ioTest, propTest) where

import Test.QuickCheck

type SuiteFn = IO ()

data SuiteStatus =
  Run SuiteFn |
  Skip SuiteFn |
  Only SuiteFn

onlyTests [] = []
onlyTests ((Only t):tests) = t : onlyTests tests
onlyTests (_:tests) = onlyTests tests

runTests [] = []
runTests ((Run t):tests) = t : runTests tests
runTests (_:tests) = runTests tests

testLinePrefix = "*** "

ioTest descr actual expected = do
  putStr (testLinePrefix ++ descr ++ " ")
  quickCheck (withMaxSuccess 1 $ actual == expected)

propTest descr prop = do
    putStr (testLinePrefix ++ descr ++ " ")
    quickCheck prop


