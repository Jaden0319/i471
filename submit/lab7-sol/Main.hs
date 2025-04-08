module Main (main) where

import Test.QuickCheck

import TestUtils
import Lab7Sol

---------------------------------- fact ---------------------------------

propFact :: Int -> Property
propFact n = (n >= 0) ==> ((fact n) == (foldl (*) 1 [1..n]))

testFact = do
  ioTest "fact 0" (fact 0) 1
  ioTest "fact 4" (fact 4) 24
  propTest "fact n must equal 1*2*...*n" propFact

---------------------------------- poly2 --------------------------------

propPoly2 :: Int -> Int -> Int -> Bool
propPoly2 x a b = (poly2 x a b) == (x*x - 2 * a * b * x + a*b)

testPoly2 = do
  ioTest "poly2 2 1 1" (poly2 2 1 1) 1
  ioTest "poly2 5 2 3" (poly2 5 2 3) 6
  propTest "poly2 x a b must equal x^2 - 2abx + ab" propFact

----------------------------------- thrd --------------------------------

propThrd :: Int -> Int -> Int -> Bool
propThrd x y z = (thrd (x, y, z)) == z

testThrd = do
  propTest "thrd (x, y, z) must return z" propThrd

--------------------------------- shapes --------------------------------

testShapesArea = do
  ioTest "area Rect 2 3" (area (Rect 2 3)) 6
  ioTest "area Square 4" (area (Square 4)) 16

testShapesPerim = do
  ioTest "perim Rect 2 3" (perim (Rect 2 3)) 10
  ioTest "perim Square 4" (perim (Square 4)) 16

------------------------------ boundedShapes ----------------------------

testBoundedShapes =
  let r1 = Rect 4 5
      r2 = Rect 4 7
      s1 = Square 4
      s2 = Square 2
      ls1 = [r1, r2, s1, s2]
      ls2 = [s2, r1, r2]
  in do
    ioTest "bounded ls1 18" (boundedShapes ls1 18) [ s1, s2 ]
    ioTest "bounded ls2 18" (boundedShapes ls2 18) [ s2 ]

------------------------------- All Tests -------------------------------

-- Can mark test suites with following test statuses:
--   Only:  run only these tests and other tests marked Only.
--   Run:   run these tests when no tests are marked Only.
--   Skip:  skip these tests.
allTests = [
    (Run testFact),
    (Run testPoly2), 
    (Run testThrd), 
    (Run testShapesArea),
    (Run testShapesPerim),
    (Run testBoundedShapes) 
  ]


main = do
  mapM_ id tests
  where
    only = onlyTests allTests
    tests = if (length only > 0) then only else runTests allTests
         


