#!/usr/bin/env racket

;; comment out following line to load and run in repl
;; MAKE SURE YOU UNCOMMENT BEFORE SUBMISSION.
#lang racket

(require rackunit)

(require "lab3-sol.scm")


(define-syntax-rule (check-equal? actual expected)
  (if (equal? actual expected)
      (display (format "okay: ~v: has expected value ~v~%" 'actual 'expected))
      (display (format "fail: ~v: has value ~v not equal to expected value ~v~%"
		       'actual actual 'expected))))
      
(define (round-n v (n 2))
  (/ (round (* v (expt 10 n))) (expt 10 n)))


(define (simple-interest-tests)
  (check-equal? (round-n (simple-interest 1000.0 5.0)) 1050.0)
  (check-equal? (round-n (simple-interest 1000.0 3.56)) 1035.6)
  (check-equal? (round-n (simple-interest 1234.6 5.0)) 1296.33)
)
(simple-interest-tests)


(define (compound-interest-tests)
  (check-equal? (round-n (compound-interest 1000.0 5 1 5) 2) 1276.28)
  (check-equal? (round-n (compound-interest 1000.0 5 12 5) 2) 1283.36)
  (check-equal? (round-n (compound-interest 1000.0 5 365 5) 2) 1284.00)
)
(compound-interest-tests)


(define (poly-eval-tests)
  (check-equal? (poly-eval 5) 344)
  (check-equal? (poly-eval 4) 175)
  (check-equal? (poly-eval 1) 4)
  (check-equal? (poly-eval 2) 23))
(poly-eval-tests)


(define (append-tails-tests)
  (check-equal? (append-tails '(1 2 3) '(a b c)) '(2 3 b c))
  (check-equal? (append-tails '(1) '(a b c)) '(b c))
  (check-equal? (append-tails '(1) '(a)) '()))
(append-tails-tests)

(define (first-elements-tests)
  (check-equal? (first-elements '(1 2 3) '(a b c)) '(1 a))
  (check-equal? (first-elements '(1) '(a b c)) '(1 a))
  (check-equal? (first-elements '(1) '(a)) '(1 a)))
(first-elements-tests)


(define (first-longest-tests)
  (check-equal? (first-longest '(1 2 3 4) '(a b c)) 1)
  (check-equal? (first-longest '(1 2 3 ) '(a b c d)) 'a)
  (check-equal? (first-longest '(1 2 3 ) '(a b c)) 'a))
(first-longest-tests)

(define (line-length-tests)
  (check-equal? (round-n (line-length '(0.0 0.0) '(3.0 4.0))) 5.0)
  (check-equal? (round-n (line-length '(1.0 1.0) '(13.0 6.0))) 13.0)
)
(line-length-tests)
