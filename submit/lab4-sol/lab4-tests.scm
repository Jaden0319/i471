#!/usr/bin/env racket

;; comment out following line to load and run in repl
;; MAKE SURE YOU UNCOMMENT BEFORE SUBMISSION.
#lang racket

(require rackunit)

(require "lab4-sol.scm")


(define-syntax-rule (check-equal? actual expected)
  (if (equal? actual expected)
      (display (format "okay: ~v: has expected value ~v~%" 'actual 'expected))
      (display (format "fail: ~v: has value ~v not equal to expected value ~v~%"
		       'actual actual 'expected))))
      
(define (list-prod-tests)
  (check-equal? (list-prod '(1 2 3) '(4 5 6)) '(4 10 18))
  (check-equal? (list-prod '(7) '(3)) '(21))
  (check-equal? (list-prod '(4 5 1 2 3) '(7 9 4 5 6)) '(28 45 4 10 18))
  (check-equal? (list-prod '() '()) '())
)
;(list-prod-tests)


(define (list-fn-tests)
  (check-equal? (list-fn (lambda (a b) (- b a)) '(2 4 5) '(6 7 8))
		'(4 3 3))
  (check-equal? (list-fn + '(2 4 5) '(6 7 8)) '(8 11 13))
  (check-equal? (list-fn * '() '()) '())
  (check-equal? (list-fn (lambda (a b) (- (* 5 a) (* 2 b)))
			 '(2 4 5) '(6 7 8))
		'(-2 6 9))				   
)
;(list-fn-tests)


(define (quadratic-roots-tests)
  (check-equal? (quadratic-roots 1 -5 6) '(3 2))
  (check-equal? (quadratic-roots 2 0 -18) '(3 -3))
  (check-equal? (quadratic-roots 2 0 18) '(0+3i 0-3i))
)
;(quadratic-roots-tests)

(define (lists-quadratic-roots-tests)
  (check-equal?
   (lists-quadratic-roots '(1 2 2) '(-5 0 0) '(6 -18 18))
     '((3 2) (3 -3) (0+3i 0-3i)))
)
;(lists-quadratic-roots-tests)

(define (sum-lengths-tests)
  (check-equal? (sum-lengths '((1 (2)) (c d e) ())) 5)
  (check-equal? (sum-lengths '(((1 a)) (2))) 2)
  (check-equal? (sum-lengths '()) 0)
)
;(sum-lengths-tests)

(define (prod-lengths-tests)
  (check-equal? (prod-lengths '((1 (2)) (c d e) ())) 0)
  (check-equal? (prod-lengths '((1 (2)) (c d e))) 6)
  (check-equal? (prod-lengths '(((1 a)) (2))) 1)
  (check-equal? (prod-lengths '()) 1)
)
;(prod-lengths-tests)


(define (eval-poly-tests)
  (check-equal? (eval-poly 2 '((1 0) (1 1) (1 2) (1 3))) 15)
  (check-equal? (eval-poly 1 '((1 0) (1 1) (1 2) (1 3))) 4)
  (check-equal? (eval-poly 1 '((1 0) (4 1) (5 2) (7 3))) 17)
  (check-equal? (eval-poly 2 '((3 2) (4 1) (5 3) (7 0))) 67)
  (check-equal? (eval-poly 2 '((3 2) (4 1) (5 3) (7 0) (3 1))) 73)
  (check-equal? (eval-poly 0 '((3 2) (4 1) (5 3) (7 0))) 7)
  (check-equal? (eval-poly 0 '((3 2) (4 1) (5 3) (7 2))) 0)
  (check-equal? (eval-poly 3 '()) 0)
)
;(eval-poly-tests)
