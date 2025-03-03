#!/usr/bin/env racket

;; If loading into the REPL, comment out the #lang line and provide
;; expressions.  MAKE SURE YOU UNCOMMENT BEFORE SUBMISSION.
#lang racket

(provide search-bst insert-bst list-quadratic-roots
	 sum-fn-in-range eval-poly coeffs-poly make-poly dynamic-coeffs-poly)

;; to trace function fn, add (trace fn) after fn's definition
(require racket/trace)  

;; *RESTRICTIONS*:
;; YOU WILL RECEIVE A ZERO FOR THIS PROJECT IF YOU VIOLATE THE FOLLOWING
;; RESTRICTIONS:
;;
;; You cannot use any destructive operations.
;;
;; You cannot use named-let.
;;
;; You may only use the built-in Scheme functions mentioned in
;; class or in this project, including the following:
;;   The arithmetic operators +, -, *, /.
;;   The relational operators on numbers: <, >, <=, >= and =.
;;   The exponentiation function (expt a n) = a^n; (expt 2 5) = 32.
;;   The equality function 'eqv? to check primitve equality.
;;   The symbols comparison predicate symbol<?
;; 

;; *TESTS*:
;; Initially, calls to all the test functions have been commented out.
;; Activate each call as you implement the corresponding function.
;;
;; If a particular function is going into an infinite loop on any
;; test, submit your attempted code for that function under a
;; different function name so that it is not run as part of the
;; automated tests but your looping code can still be evaluated.
;; Submit the original function in its 'TODO state. This will stop the
;; looping test from preventing subsequent tests from running.  Add a
;; comment specifying which test causes your code to loop.

;; A binary search tree BST is either empty and represented as '(), or
;; non-empty and represented as a 4-element list `(key value left
;; right)`, where `key` is a Scheme symbol, `value` is any Scheme
;; datum, `left` and `right` are binary trees where all keys in `left`
;; are less-than `key` and all keys in `right` are greater-than `key`.
;;
;; Symbols can be compared for equality using `eq?` and for ordering
;; using `symbol<?`.

;; #1: 15-points
;;
;; If key `k` exists in binary search tree `t`, return its value; otherwise
;; return the symbol 'not-found.
;;
;; Your implementation *must* use the fact that a binary search tree is
;; ordered.
(define (search-bst k t)
  'TODO
)

;; #2: 20-points
;;
;; Return the binary search tree which is just like `t` except that
;; key `k` has value `v`.
;;
;; The key `k` should be inserted into `t` without any attempt to
;; balance `t`.
(define (insert-bst k v t)
  'TODO
)

;; Insert definition for quadratic-roots from Lab 4.
(define (quadratic-roots a b c)
  'TODO
)

;; #3: 10-points
;;
;; Given a list `triples` of elements having the form `(a b c)` (where
;; each triple provides the coefficients of the quadratic equation
;; a*x^2 + b*x + c = 0), return a list of pairs `(root1 root2)` where
;; `root1 and `root2` are the roots of the quadratic equation for the
;; corresponding triple.  `root1` must be the root for the positive
;; discriminant and `root2` the root for the negative discriminant.
;;
;; Your solution is not allowed to use recursion.
;;
;; Hint: Use `map` with a function which calls `quadratic-roots`
;; with its arguments extracted from a triple.
(define (list-quadratic-roots triples)
  'TODO
)

;; The racket utility (range n) which returns (0 1 2 ... (- n 1))
;; may be useful. 

;; #4: 10-points
;;
;; Return (+ (fn 0) (fn 1) ...  (fn (- n 1)))
;;
;; Cannot use recursion.
;;
;; Hint: Use map and foldl.
(define (sum-fn-in-range fn n)
  'TODO
)

;; #5: 15-points
;;
;; Given a number x and a list of coefficients coeffs for a polynomial
;; in order of increasing powers, return the value of the polynomial
;; at x; i.e. return the value of
;;
;; coeffs[0] + coeffs[1]*x^1 + coeffs[2]*x^2 + ... + coeffs[n-1]*x^(n-1)
;;
;; where coeffs[i] denotes the i'th element of coeffs (starting at index 0).
;; and x^i denotes x to the power-of-i.
;;
;; Cannot use recursion.
;;
;; Hint: use map and foldl
(define (eval-poly x coeffs)
  'TODO
)

;; #6: 5-points
;; Given coeffs as in the previous exercise, return a function
;; of one argument, such that calling the returned function with
;; `x` passed as its argument, returns the value of the polynomial
;; at `x`.
;;
;; *Hint*: adapt your solution to the previous exercise.
(define (coeffs-poly coeffs)
  'TODO
)
  
;; #7: 20-points
;;
;; Given a symbol x and a list  coeffs of n coefficients for a
;; polynomial in order of increasing powers, return a expression
;;
;; ( + (* coeffs[0] (expt x 0)) (* coeffs[1] (expt x 1)) ...
;;     (* coeffs[n - 1] (expt x (- n 1))))
;;
;; where coeffs[i] denotes the i'th element of coeffs (starting at index 0).
;;
;; Cannot use recursion.
(define (make-poly x coeffs)
  'TODO
)
		   



;; #8: 5-points
;;
;; Like `coeffs-poly`, but must build function dynamically using
;; `make-poly`.
;;
;; Hint: use make-fn from slides.
;;
(define (dynamic-coeffs-poly coeffs)
  'TODO
)










