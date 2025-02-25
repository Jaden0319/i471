#!/usr/bin/env racket

;; If loading into the REPL, comment out the #lang line and provide
;; expressions.  MAKE SURE YOU UNCOMMENT BEFORE SUBMISSION.
#lang racket

(provide list-prod list-fn quadratic-roots lists-quadratic-roots
	 sum-lengths prod-lengths eval-poly
)

;; to trace function fn, add (trace fn) after fn's definition
(require racket/trace)  


;;Given two number lists `ls1` and `ls2` having the same length,
;;`list-prod` should return the list containing
;;the product of the corresponding elements of `ls1` and `ls2`.
;;The function must be implemented by cdr'ing down lists `ls1` and `ls2`.
(define (list-prod ls1 ls2)
  'TODO)

;; Given two number lists `ls1` and `ls2` having the same length and a
;; binary function `fn`, `list-fn` should return the list containing
;; the result of applying `fn` to the corresponding elements of `ls1`
;; and `ls2`.  The function must be implemented by cdr'ing down lists
;; `ls1` and `ls2`.
(define (list-fn fn ls1 ls2)
  'TODO)

;;  Return a 2-element list containing the roots of the quadratic
;;  equation a*x^2 + b*x + c = 0.  The first element of the returned
;;  list should be the root with the positive discriminant and the
;;  second element of the returned list the root with the negative
;;  discriminant.
(define (quadratic-roots a b c)
  'TODO)

;; Given `list-as`, `list-bs` and `list-cs` giving the coefficients of
;; the quadratic equation `a*x^2 + b*x + c`, return a list of pairs
;; giving the roots of the quadratic equation corresponding to each
;; triple of coefficients.
(define (lists-quadratic-roots list-as list-bs list-cs)
  'TODO)

;; Given a list `ls` of lists, return the sum of the lengths of the
;; lists in `ls`.  Must be implemented by cdr'ing down `ls`.
(define (sum-lengths ls)
  'TODO)

;; Given a list `ls` of lists, return the products of the lengths of the
;; lists in `ls`.  Implementation must be tail-recursive.
(define (prod-lengths ls) (aux-prod-lengths ls 1))
(define (aux-prod-lengths ls sum)
  'TODO)

;; given a number `x` and list `coeff-power-list` of 2-element lists
;; `(coeff pow)`, return the sum over all list elements of
;; `coeff*x^pow`.
(define (eval-poly x coeff-power-list)
  'TODO)

