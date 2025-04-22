module Tests where

import Prj4Sol

import TestUtils

import Test.QuickCheck

-------------------------- testToSingletonLists -------------------------

testToSingletonLists = do
  print "******* toSingletonLists *******"
  ioTest "ints" (toSingletonLists [ 5, 7, 2 ]) [ [5], [7], [2] ]
  ioTest "chars" (toSingletonLists [ 'a', 'x', 'd' ]) [ "a", "x", "d" ]
  ioTest "empty" (toSingletonLists []) ([] :: [[Int]])

------------------------------- testListMap -----------------------------

testListMap = do
  print "******* listMap *******"
  ioTest "add" (listMap (+) 5 [1, 2, 3]) [6, 7, 8]
  ioTest "sub" (listMap (-) 5 [1, 2, 3]) [4, 3, 2]
  ioTest "mul" (listMap (*) 5 [1, 2, 3]) [5, 10, 15]
  ioTest "empty" (listMap (-) 5 []) []

-------------------------------- testMember -----------------------------

testMember = do
  print "******* member *******"
  ioTest "ints first" (member 5 [ 5, 7, 2 ]) True
  ioTest "ints last" (member 2 [ 5, 7, 2 ]) True
  ioTest "ints mid" (member 7 [ 5, 7, 2 ]) True
  ioTest "ints fail"  (member 4 [ 5, 7, 2 ]) False
  ioTest "empty" (member 4 []) False

----------------------------- testselectNApart --------------------------

testSelectNApart = do
  print "******* selectNApart *******"
  ioTest "2-apart" (selectNApart 2 [0..10])  [0, 2, 4, 6, 8, 10]
  ioTest "2-apart chars" (selectNApart 2 ['a'..'z'])  "acegikmoqsuwy"
  ioTest "3-apart" (selectNApart 3 [0..20]) [0, 3, 6, 9, 12, 15, 18]
  ioTest "5-apart" (selectNApart 5 [0..21]) [0, 5, 10, 15, 20]
  ioTest "empty" (selectNApart 5 ([]::[Int])) []


---------------------------- testEvalIntExpr ----------------------------

testEvalIntExpr = do 
  print "******* test evalIntExpr *******"
  ioTest "Leaf" (evalIntExpr (IntLeaf 42)) 42
  ioTest "Add" (evalIntExpr (IntAdd (IntLeaf 33) (IntLeaf 22))) 55
  ioTest "Sub" (evalIntExpr (IntSub (IntLeaf 33) (IntLeaf 22))) 11
  ioTest "Mul" (evalIntExpr (IntMul (IntLeaf 31) (IntLeaf 4))) 124
  ioTest "Uminus" (evalIntExpr (IntUminus (IntLeaf 33))) (-33)
  ioTest "Complex"
    (evalIntExpr (IntMul (IntLeaf 4)
                         (IntSub (IntAdd (IntLeaf 3) (IntUminus (IntLeaf 33)))
                                 (IntLeaf 20))))
    (-200)

  -- property-based tests
  -- commutativity
  propTest "`e1 + e2 == e2 + e1`"
    (\ e1 e2 -> 
        evalIntExpr (IntAdd (IntLeaf e1) (IntLeaf e2)) ==
        evalIntExpr (IntAdd (IntLeaf e2) (IntLeaf e1)))
  propTest "`e1 * e2 == e2 * e1`"
    (\ e1 e2 -> 
        evalIntExpr (IntMul (IntLeaf e1) (IntLeaf e2)) ==
        evalIntExpr (IntMul (IntLeaf e2) (IntLeaf e1)))
  -- associativity
  propTest "`(e1 + e2) + e3 == e1 + (e2 + e3)`"
    (\ e1 e2 e3 -> 
        evalIntExpr (IntAdd (IntAdd (IntLeaf e1) (IntLeaf e2)) (IntLeaf e3)) ==
        evalIntExpr (IntAdd (IntLeaf e1) (IntAdd (IntLeaf e2) (IntLeaf e3))))
  propTest "`(e1 * e2) * e3 == e1 * (e2 * e3)`"
    (\ e1 e2 e3 ->
        evalIntExpr (IntMul (IntMul (IntLeaf e1) (IntLeaf e2)) (IntLeaf e3)) ==
        evalIntExpr (IntMul (IntLeaf e1) (IntMul (IntLeaf e2) (IntLeaf e3))))

  -- subtraction
  propTest "`e1 - e2 = -1*(e2 - e1)`"
    (\ e1 e2 ->
        evalIntExpr (IntSub (IntLeaf e1) (IntLeaf e2)) ==
        evalIntExpr (IntMul (IntLeaf (-1)) (IntSub (IntLeaf e2) (IntLeaf e1))))

  -- distributivity
  propTest "`e1 * (e2 + e3) == e1*e2 + e1*e3`"
    (\ e1 e2 e3 -> 
        evalIntExpr (IntMul (IntLeaf e1) (IntAdd (IntLeaf e2) (IntLeaf e3))) ==
        evalIntExpr (IntAdd (IntMul (IntLeaf e1) (IntLeaf e2)) 
                      (IntMul (IntLeaf e1) (IntLeaf e3))))
  propTest "`e1 * (e2 - e3) == e1*e2 - e1*e3`"
    (\ e1 e2 e3 -> 
        evalIntExpr (IntMul (IntLeaf e1) (IntSub (IntLeaf e2) (IntLeaf e3))) ==
        evalIntExpr (IntSub (IntMul (IntLeaf e1) (IntLeaf e2)) 
                      (IntMul (IntLeaf e1) (IntLeaf e3))))

---------------------------- testEvalIdExpr -----------------------------


testEvalIdExpr = do
  print "******* test evalIdExpr *******"
  -- unit tests
  ioTest "IdLeaf" (evalIdExpr (IdLeaf 42) []) 42
  ioTest "IdAdd"  (evalIdExpr (IdAdd (IdLeaf 33) (IdLeaf 22)) []) 55
  ioTest "IdSub" (evalIdExpr (IdSub (IdLeaf 33) (IdLeaf 22)) []) 11
  ioTest "IdMul" (evalIdExpr (IdMul (IdLeaf 31) (IdLeaf 4)) []) 124
  ioTest "IdUminus" (evalIdExpr (IdUminus (IdLeaf 33)) []) (-33)
  ioTest "Complex"
    (evalIdExpr (IdMul (IdLeaf 4)
                       (IdSub (IdAdd (IdLeaf 3) (IdUminus (IdLeaf 33)))
                              (IdLeaf 20))) [])
    (-200)

  -- id unit tests
  ioTest "ok id lookup" (evalIdExpr (IdId "a") [("a", 42)])  42
  ioTest "fail id lookup" (evalIdExpr (IdId "a") [("b", 42)]) 0
  ioTest "id lookup: a: ok, b: fail"
    (evalIdExpr (IdAdd (IdId "a") (IdId "b")) [("a", 42)])
    42
  ioTest "id lookup: a: ok, b: ok"
    (evalIdExpr (IdAdd (IdId "a") (IdId "b")) [("a", 42), ("b", 22)])
    64
  ioTest "complex id lookup"
    (evalIdExpr (IdMul (IdId "a")
                       (IdSub (IdAdd (IdId "b") (IdUminus (IdId "c")))
                              (IdId "d")))
                [("a", 4), ("b", 3), ("c", 33), ("d", 20)])
    (-200)

  -- property-based tests
  -- id lookup
  propTest "random id lookup ok"
    (\ id1 val1 -> evalIdExpr (IdId id1) [(id1, val1)] == val1)
  propTest "random id lookup fail"
    (\ id1 val1 -> evalIdExpr (IdId id1) [(id1 ++ "x", val1)] == 0)
  
  -- property-based tests
  -- commutativity
  propTest "`e1 + e2 == e2 + e1`"
    (\ e1 e2 -> 
        evalIdExpr (IdAdd (IdLeaf e1) (IdLeaf e2)) [] ==
        evalIdExpr (IdAdd (IdLeaf e2) (IdLeaf e1)) [])
  propTest "`e1 * e2 == e2 * e1`"
    (\ e1 e2 -> 
        evalIdExpr (IdMul (IdLeaf e1) (IdLeaf e2)) [] ==
        evalIdExpr (IdMul (IdLeaf e2) (IdLeaf e1)) [])
  -- associativity
  propTest "`(e1 + e2) + e3 == e1 + (e2 + e3)`"
    (\ e1 e2 e3 -> 
        evalIdExpr (IdAdd (IdAdd (IdLeaf e1) (IdLeaf e2)) (IdLeaf e3)) [] ==
        evalIdExpr (IdAdd (IdLeaf e1) (IdAdd (IdLeaf e2) (IdLeaf e3))) [])
  propTest "`(e1 * e2) * e3 == e1 * (e2 * e3)`"
    (\ e1 e2 e3 ->
        evalIdExpr (IdMul (IdMul (IdLeaf e1) (IdLeaf e2)) (IdLeaf e3)) [] ==
        evalIdExpr (IdMul (IdLeaf e1) (IdMul (IdLeaf e2) (IdLeaf e3))) [])

  -- subtraction
  propTest "`e1 - e2 = -1*(e2 - e1)`"
    (\ e1 e2 ->
        evalIdExpr (IdSub (IdLeaf e1) (IdLeaf e2)) [] ==
        evalIdExpr (IdMul (IdLeaf (-1)) (IdSub (IdLeaf e2) (IdLeaf e1))) [])

  -- distributivity
  propTest "`e1 * (e2 + e3) == e1*e2 + e1*e3`"
    (\ e1 e2 e3 -> 
        evalIdExpr (IdMul (IdLeaf e1) (IdAdd (IdLeaf e2) (IdLeaf e3))) [] ==
        evalIdExpr (IdAdd (IdMul (IdLeaf e1) (IdLeaf e2)) 
                     (IdMul (IdLeaf e1) (IdLeaf e3))) [])
  propTest "`e1 * (e2 - e3) == e1*e2 - e1*e3`"
    (\ e1 e2 e3 -> 
        evalIdExpr (IdMul (IdLeaf e1) (IdSub (IdLeaf e2) (IdLeaf e3))) [] ==
        evalIdExpr (IdSub (IdMul (IdLeaf e1) (IdLeaf e2))  
                      (IdMul (IdLeaf e1) (IdLeaf e3))) [])

--------------------------- testEvalMaybeExpr ---------------------------

testEvalMaybeExpr = do 
  print "******* test evalMaybeExpr *******"
  -- unit tests
  ioTest "MaybeLeaf" (evalMaybeExpr (MaybeLeaf 42) []) (Just 42)
  ioTest "MaybeAdd"
    (evalMaybeExpr (MaybeAdd (MaybeLeaf 33) (MaybeLeaf 22)) [])
    (Just 55)
  ioTest "MaybeSub"
    (evalMaybeExpr (MaybeSub (MaybeLeaf 33) (MaybeLeaf 22)) [])
    (Just 11)
  ioTest "MaybeMul"
    (evalMaybeExpr (MaybeMul (MaybeLeaf 31) (MaybeLeaf 4)) [])
    (Just 124)
  ioTest "MaybeUminus"
    (evalMaybeExpr (MaybeUminus (MaybeLeaf 33)) [])
    (Just (-33))
  ioTest "Complex"
    (evalMaybeExpr (MaybeMul (MaybeLeaf 4)
                 (MaybeSub (MaybeAdd (MaybeLeaf 3) (MaybeUminus (MaybeLeaf 33)))
                   (MaybeLeaf 20))) [])
    (Just (-200))

  -- id unit tests
  ioTest "ok id lookup"
    (evalMaybeExpr (MaybeId "a") [("a", 42)])
    (Just 42)
  ioTest "fail id lookup"
    (evalMaybeExpr (MaybeId "a") [("b", 42)])
    Nothing
  ioTest "id lookup: a: ok, b: fail"
    (evalMaybeExpr (MaybeAdd (MaybeId "a") (MaybeId "b")) [("a", 42)])
    Nothing
  ioTest "id lookup: a: ok, b: ok"
    (evalMaybeExpr (MaybeAdd (MaybeId "a") (MaybeId "b"))
                   [("a", 42), ("b", 22)])
    (Just 64)
  ioTest "complex id lookup"
    (evalMaybeExpr (MaybeMul (MaybeId "a")
                 (MaybeSub (MaybeAdd (MaybeId "b") (MaybeUminus (MaybeId "c")))
                   (MaybeId "d")))
               [("a", 4), ("b", 3), ("c", 33), ("d", 20)])
    (Just (-200))

  -- property-based tests
  -- id lookup
  propTest "random id lookup ok"
    (\ id1 val1 -> evalMaybeExpr (MaybeId id1) [(id1, val1)] == Just val1)
  propTest "random id lookup fail"
    (\ id1 val1 -> evalMaybeExpr (MaybeId id1) [(id1 ++ "x", val1)] == Nothing)
  
  -- property-based tests
  -- commutativity
  propTest "`e1 + e2 == e2 + e1`"
    (\ e1 e2 -> 
        evalMaybeExpr (MaybeAdd (MaybeLeaf e1) (MaybeLeaf e2)) [] ==
        evalMaybeExpr (MaybeAdd (MaybeLeaf e2) (MaybeLeaf e1)) [])
  propTest "`e1 * e2 == e2 * e1`"
    (\ e1 e2 -> 
        evalMaybeExpr (MaybeMul (MaybeLeaf e1) (MaybeLeaf e2)) [] ==
        evalMaybeExpr (MaybeMul (MaybeLeaf e2) (MaybeLeaf e1)) [])
  -- associativity
  propTest "`(e1 + e2) + e3 == e1 + (e2 + e3)`"
    (\ e1 e2 e3 -> 
        evalMaybeExpr (MaybeAdd (MaybeAdd (MaybeLeaf e1) (MaybeLeaf e2)) (MaybeLeaf e3)) [] ==
        evalMaybeExpr (MaybeAdd (MaybeLeaf e1) (MaybeAdd (MaybeLeaf e2) (MaybeLeaf e3))) [])
  propTest "`(e1 * e2) * e3 == e1 * (e2 * e3)`"
    (\ e1 e2 e3 ->
        evalMaybeExpr (MaybeMul (MaybeMul (MaybeLeaf e1) (MaybeLeaf e2)) (MaybeLeaf e3)) [] ==
        evalMaybeExpr (MaybeMul (MaybeLeaf e1) (MaybeMul (MaybeLeaf e2) (MaybeLeaf e3))) [])

  -- subtraction
  propTest "`e1 - e2 = -1*(e2 - e1)`"
    (\ e1 e2 ->
        evalMaybeExpr (MaybeSub (MaybeLeaf e1) (MaybeLeaf e2)) [] ==
        evalMaybeExpr (MaybeMul (MaybeLeaf (-1)) (MaybeSub (MaybeLeaf e2) (MaybeLeaf e1))) [])

  -- distributivity
  propTest "`e1 * (e2 + e3) == e1*e2 + e1*e3`"
    (\ e1 e2 e3 -> 
        evalMaybeExpr (MaybeMul (MaybeLeaf e1) (MaybeAdd (MaybeLeaf e2) (MaybeLeaf e3))) [] ==
        evalMaybeExpr (MaybeAdd (MaybeMul (MaybeLeaf e1) (MaybeLeaf e2)) 
                     (MaybeMul (MaybeLeaf e1) (MaybeLeaf e3))) [])
  propTest "`e1 * (e2 - e3) == e1*e2 - e1*e3`"
    (\ e1 e2 e3 -> 
        evalMaybeExpr (MaybeMul (MaybeLeaf e1) (MaybeSub (MaybeLeaf e2) (MaybeLeaf e3))) [] ==
        evalMaybeExpr (MaybeSub (MaybeMul (MaybeLeaf e1) (MaybeLeaf e2))  
                      (MaybeMul (MaybeLeaf e1) (MaybeLeaf e3))) [])


---------------------------- testPostfixExpr ----------------------------

testPostfixExpr = do
  print "******* test postfixExpr *******"

  ioTest "Leaf" (postfixExpr "42") (PostfixLeaf 42)
  ioTest "Add"
    (postfixExpr "33 22 +") (PostfixAdd (PostfixLeaf 33) (PostfixLeaf 22))
  ioTest "Sub"
    (postfixExpr "33 22 -") (PostfixSub (PostfixLeaf 33) (PostfixLeaf 22))
  ioTest "Mul"
    (postfixExpr "31 4 *") (PostfixMul (PostfixLeaf 31) (PostfixLeaf 4))
  ioTest "Uminus"
    (postfixExpr "33 uminus") (PostfixUminus (PostfixLeaf 33))
  ioTest "Complex"
    (postfixExpr "4 3 33 uminus + 20 - *")
    (PostfixMul
     (PostfixLeaf 4)
     (PostfixSub (PostfixAdd (PostfixLeaf 3) (PostfixUminus (PostfixLeaf 33)))
                 (PostfixLeaf 20)))
  

--------------------------------- Tests ---------------------------------

-- Can mark test suites with following test statuses:
--   Only:  run only these tests and other tests marked Only.
--   Run:   run these tests when no tests are marked Only.
--   Skip:  skip these tests.
allTests = [
    (Skip testToSingletonLists),
    (Skip testListMap),
    (Skip testMember),
    (Skip testSelectNApart),
    (Skip testEvalIntExpr),
    (Skip testEvalIdExpr),
    (Skip testEvalMaybeExpr),
    (Skip testPostfixExpr)
  ]


main = do
  mapM_ id tests
  where
    only = onlyTests allTests
    tests = if (length only > 0) then only else runTests allTests
  
