#!/usr/bin/env racket

;; comment out following line to load and run in repl
;; MAKE SURE YOU UNCOMMENT BEFORE SUBMISSION.
#lang racket

;; to trace function fn, add (trace fn) after fn's definition
(require racket/trace)  

(provide simple-interest compound-interest poly-eval )

;;(simple-interest balance interest-rate): return the balance
;;after a single simple interest payment at interest-rate %.
(define (simple-interest balance interest-rate)
  'TODO
)

;;return the amount resulting of an investment of an initial principal p,
;;invested at interest rate r% which is compounded n times per time period
;;for a total of t time periods. 
;;<https://www.nerdwallet.com/calculator/compound-interest-calculator>
(define (compound-interest p r n t)
  'TODO
)

;;return 3*x**3 + -2*x**2 + 4*x -1
(define (poly-eval x)
  'TODO
)

(provide append-tails first-elements first-longest line-length)


;;(append-tails list1 list2): given two non-empty lists `list1` and
;;`list2` returns the result of appending the tail of `list2` to the
;;tail of `list1`.
(define (append-tails list1 list2)
  'TODO
)

;;(first-elements list1 list2): given two non-empty lists `list1` and
;;`list2` returns the two-element list containing the heads of `list1`
;;and `list2`.
(define (first-elements list1 list2)
  'TODO
)

;;(first-longest list1 list2): given two non-empty lists
;;`list1` and `list2` returns the first element of `list1` if its
;;length is greater than that of `list2`, else it returns the first
;;element of `list2`.
(define (first-longest list1 list2)
  'TODO
)

;;(line-length pt0 pt1): return the length of a line between 2D-points
;;`pt0` and `pt1` where each point is represented as a two-element
;;list `(x y)` containing its coordinates `x` and `y`.
(define (line-length pt0 pt1)
  'TODO
)
