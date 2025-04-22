module Prj4Sol (
  toSingletonLists,
  listMap,
  member,
  selectNApart,
  evalIntExpr, IntExpr(..),
  evalIdExpr, IdExpr(..),
  evalMaybeExpr, MaybeExpr(..),
  postfixExpr, PostfixExpr(..)
  ) where

import Data.List (lookup)


{-
  YOU WILL RECEIVE A SUBSTANTIAL PENALTY (INCLUDING POSSIBLY A ZERO
  FOR THE ENTIRE PROJECT) IF YOU DO NOT MEET THE FOLLOWING
  RESTRICTIONS:

    + You may not use any Haskell builtins or features not covered in
      class or mentioned explicitly in this project.  Note that a
      builtin function fn is regarded as covered in class if it has
      been used in class with the same name fn or defined in class
      with name myFn or my_fn.

    + You should not define any top-level functions other than
      those listed below.

    + If an exercise specifies a restriction on the implementation,
      then your implementation must meet that restriction.

    + Your submission must not contain garbage files.  Specifically,
      it should unpack into a prj4-sol directory and contain only this
      file and your README.      

  Note that a function is allowed to call a function defined earlier.
-}

---------------------------- toSingletonLists ---------------------------

-- #1: 5-points

-- toSingletonLists list: Given a list of elements e, return a list containing
-- of singleton lists [e].
-- *Restriction*: must use map with a section.
toSingletonLists :: [e] -> [[e]]
toSingletonLists list = [] -- TODO

--------------------------------- listMap -------------------------------

-- #2: 5-points

-- listMap fn x list: Given a binary function fn:: (a -> b -> c) and
-- a x::a and a list::[b], return a list containing the results of
-- fn x e, for every element e in list.
-- *Restriction*: cannot use explicit recursion
-- Hint: use the map function or a list comprehension
listMap :: (a -> b -> c) -> a -> [b] -> [c]
listMap f a list =  [] -- TODO

---------------------------------- member -------------------------------

-- #3: 10-points

-- member e list: return True iff e is a member of list.
-- *Restriction*: must use foldl, cannot use elem.
-- Hint: define folding function using a lambda or local let/where definition;
-- also see recursive definition of member in slides.
member :: Eq e => e -> [e] -> Bool
member e list = False -- TODO


------------------------------- selectNApart ----------------------------

-- #4: 10-points

-- selectNApart n list: given an Int n and a list of elements e,
-- return a list containing the elements of the list at index 0,
-- n, 2n, 3n, 4n, ... .
-- Hint: use drop
selectNApart :: Int -> [e] -> [e]
selectNApart n list = [] -- TODO

------------------------------ evalIntExpr ------------------------------

-- #5: 15-points

-- an IntExpr is an expression-tree over integers
data IntExpr =
  IntLeaf Int |
  IntAdd IntExpr IntExpr |
  IntSub IntExpr IntExpr |
  IntMul IntExpr IntExpr |
  IntUminus IntExpr
  deriving (Eq, Show)


-- evalIntExpr expr: returns the Int result of evaluating the IntExpr
-- expression-tree given by its argument expr.
-- Hint: use a simple recursive traversal
evalIntExpr :: IntExpr -> Int
evalIntExpr expr = 0 -- TODO


------------------------------ evalIdExpr -------------------------------

-- #6: 15-points
                         
-- an IdExpr is an expression-tree over integers and string identifiers
data IdExpr =
  IdId String |
  IdLeaf Int |
  IdAdd IdExpr IdExpr |
  IdSub IdExpr IdExpr |
  IdMul IdExpr IdExpr |
  IdUminus IdExpr
  deriving (Eq, Show)

-- Assoc is a list of pairs mapping identifier strings to their values v.
type Assoc v = [ (String, v) ]

-- evalIdExpr expr assoc: returns evaluation of the IdExpr
-- expression-tree given by its first argument expr, looking up the
-- values of id's in the second assoc::Assoc argument.  If an id is
-- not found in assoc, then its value should default to 0.
-- Hint: use Data.List.lookup imported above.
evalIdExpr :: IdExpr -> Assoc Int -> Int
evalIdExpr expr assoc = 0 -- TODO

  
----------------------------- evalMaybeExpr -----------------------------

-- #7: 15-points

data MaybeExpr =
  MaybeId String |
  MaybeLeaf Int |
  MaybeAdd MaybeExpr MaybeExpr |
  MaybeSub MaybeExpr MaybeExpr |
  MaybeMul MaybeExpr MaybeExpr |
  MaybeUminus MaybeExpr
  deriving (Eq, Show)


-- evalMaybeExpr expr assoc: return a Maybe wrapping the results of
-- evaluating expr, looking up id's in assoc.  If an id is not found
-- in assoc, then the function should return Nothing.
-- Hint: use do notation.
evalMaybeExpr :: MaybeExpr -> Assoc Int -> Maybe Int
evalMaybeExpr expr assoc = Just 0  -- TODO
  

---------------------------- evalPostfixExpr ----------------------------

-- #8: 25-points

-- a PostFixExpr is an expression tree over integers
data PostfixExpr =
  PostfixLeaf Int |
  PostfixAdd PostfixExpr PostfixExpr |
  PostfixSub PostfixExpr PostfixExpr |
  PostfixMul PostfixExpr PostfixExpr |
  PostfixUminus PostfixExpr
  deriving (Eq, Show)


-- postfixExpr postfixStr: Given a String postfixStr containing a
-- postfix expression involving integers, the usual binary arithmetic
-- operators "+", "-", "*" as well as "uminus" separated by
-- whitespace, return the corresponding PostfixExpr.  You may
-- disregard errors.
--
-- Hints:
--
--   + Use the Haskell function (words postfix) to split the
--     postfix string into String tokens.
--
--   + Iterate through the tokens using a [PostfixExpr] stack to track
--     the currently unprocessed PostfixExpr's.
--
--   + At each step of the iteration, look at the first
--     unprocessed token:
--
--       + If it is a string representing an operator, then replace
--         its operands from the head of the stack with the
--         PostfixExpr corresponding to the operator combined with its
--         operands from the stack.
--
--       + If the current unprocessed token is not an operator, assume
--         it is an Int and use (read token) to build it into a
--         PostfixLeaf.
--
--    + Use pattern matching to match different types of tokens and to
--      extract PostfixExpr operands from the head of the stack.
--
--    + Use a local auxiliary function to perform each step of the
--      iteration.
--
--    + You can use a recursive implementation of the top-level
--      function.  But what is recommended is to set up your auxiliary
--      function so that you can use it to foldl the token list into
--      an accumulator representing the stack of unprocessed
--      PostfixExpr's.
--
--    + When there are no unprocessed tokens, the stack should contain
--      a single PostfixExpr containing the value to be returned.
postfixExpr :: String -> PostfixExpr
postfixExpr str = PostfixLeaf 0 -- TODO



  

