#!/usr/bin/env racket

;; comment out following line to load and run in repl
;; MAKE SURE YOU UNCOMMENT BEFORE SUBMISSION.
#lang racket

(require rackunit)

(require "prj2-sol.scm")


(define-syntax-rule (check-equal? actual expected)
  (if (equal? actual expected)
      (display (format "okay: ~v: has expected value ~v~%" 'actual 'expected))
      (display (format "fail: ~v: has value ~v not equal to expected value ~v~%"
		       'actual actual 'expected))))
      
(define (round-n v (n 2))
  (/ (round (* v (expt 10 n))) (expt 10 n)))

(define (search-bst-tests)
  (let ([t1 '(m 12 (h 4 (b 3 () ()) (k 21 () ())) (s 22 (p 43 () ()) ()))])
    (check-equal? (search-bst 'm t1) 12)
    (check-equal? (search-bst 'h t1) 4)
    (check-equal? (search-bst 'b t1) 3)
    (check-equal? (search-bst 'k t1) 21)
    (check-equal? (search-bst 's t1) 22)
    (check-equal? (search-bst 'p t1) 43)
    (check-equal? (search-bst 'a t1) 'not-found) 
    (check-equal? (search-bst 'a '()) 'not-found) 
   ))
(search-bst-tests)

(define (inorder-visit t)
  (if (null? t)
      '()
      (append (inorder-visit (caddr t))
	      (cons (list (car t) (cadr t)) (inorder-visit (cadddr t))))))
(define (make-bst pairs)
  (foldl (lambda (p acc) (insert-bst (car p) (cadr p) acc)) '() pairs))
(define (sort-pairs pairs) (sort pairs #:key car symbol<?))

(define (insert-bst-tests)
  (let* ([pairs1 '((x 33) (d 44))]
	 [t1 (make-bst pairs1)]
	 [t1-pairs (inorder-visit t1)]
	 [sort-pairs1 (sort-pairs pairs1)])
    (check-equal? t1-pairs sort-pairs1))
  (let* ([pairs2 '((x 33) (a 99) (d 44) (b 33) (c 55))]
	 [t2 (make-bst pairs2)]
	 [t2-pairs (inorder-visit t2)]
	 [sort-pairs2 (sort-pairs pairs2)])
    (check-equal? t2-pairs sort-pairs2))
  (let* ([pairs3 '((x 33) (d 44) (b 33) (x 99) (c 55))]
	 [t3 (make-bst pairs3)]
	 [t3-pairs (inorder-visit t3)]
	 [sort-pairs3 (sort-pairs (cdr pairs3))])
    (check-equal? t3-pairs sort-pairs3))
  (let* ([pairs4 '((x 33) (x 44) (x 66) (x 11) (c 55))]
	 [t4 (make-bst pairs4)]
	 [t4-pairs (inorder-visit t4)]
	 [sort-pairs4 '((c 55) (x 11))])
    (check-equal? t4-pairs sort-pairs4))
)
(insert-bst-tests)


(define (list-quadratic-roots-tests)
  (check-equal? (list-quadratic-roots '((1 -5 6) (2 0 -18) (2 0 18)))
		'((3 2) (3 -3) (0+3i 0-3i)))
)
(list-quadratic-roots-tests)

(define (sum-fn-in-range-tests)
  (check-equal? (sum-fn-in-range (lambda (i) (+ i 1)) 5) 15)
  (check-equal? (sum-fn-in-range (lambda (i) (* (+ i 1) (+ i 1))) 5) 55)
  (check-equal? (sum-fn-in-range - 6) -15)
  (check-equal? (sum-fn-in-range (lambda (n) (+ n 1)) 0) 0)
  (check-equal? (sum-fn-in-range (lambda (n) (+ n 5)) 1) 5)
  (check-equal? (sum-fn-in-range (lambda (n) (+ n 5)) 5) 35)
)
(sum-fn-in-range-tests)

(define (eval-poly-tests)
  (check-equal? (eval-poly 2 '(1 1 1 1 1)) 31)
  (check-equal? (eval-poly 3 '(1 2 3 4)) 142)
  (check-equal? (eval-poly 1 '(1 2 3 4 5)) 15)
  (check-equal? (eval-poly 5 '(1 2 3 4)) 586)
  (check-equal? (eval-poly 5 '(1 10)) 51)
  (check-equal? (eval-poly 5 '(2)) 2)
  (check-equal? (eval-poly 8 '()) 0)
)
(eval-poly-tests)

(define (coeffs-poly-tests)
  (check-equal? ((coeffs-poly '(1 1 1 1 1)) 2) 31)
  (check-equal? ((coeffs-poly '(1 2 3 4)) 3) 142)
  (check-equal? ((coeffs-poly '(1 2 3 4 5)) 1) 15)
  (check-equal? ((coeffs-poly '(1 2 3 4)) 5) 586)
  (check-equal? ((coeffs-poly '(1 10)) 5) 51)
  (check-equal? ((coeffs-poly '(2)) 5) 2)
  (check-equal? ((coeffs-poly '()) 8) 0)
)
(coeffs-poly-tests)

(define (make-poly-tests)
  (check-equal? (make-poly 'x '(1 1 1 1 1))
		'(+ (* 1 (expt x 0))
		    (* 1 (expt x 1))
		    (* 1 (expt x 2))
		    (* 1 (expt x 3))
		    (* 1 (expt x 4))))
  (check-equal? (make-poly 'x '(1 2 3 4)) 
		'(+ (* 1 (expt x 0))
		    (* 2 (expt x 1))
		    (* 3 (expt x 2))
		    (* 4 (expt x 3))))
  (check-equal? (make-poly 'xx '(22 33 44 55 66 77))
		'(+ (* 22 (expt xx 0))
		    (* 33 (expt xx 1))
		    (* 44 (expt xx 2))
		    (* 55 (expt xx 3))
		    (* 66 (expt xx 4))
		    (* 77 (expt xx 5))))
  (check-equal? (make-poly 'a '(2)) '(+ (* 2 (expt a 0))))
  (check-equal? (make-poly 'x '()) '(+))
)
(make-poly-tests)

(define (dynamic-coeffs-poly-tests)
  (check-equal? ((dynamic-coeffs-poly '(1 1 1 1 1)) 2) 31)
  (check-equal? ((dynamic-coeffs-poly '(1 2 3 4)) 3) 142)
  (check-equal? ((dynamic-coeffs-poly '(1 2 3 4 5)) 1) 15)
  (check-equal? ((dynamic-coeffs-poly '(1 2 3 4)) 5) 586)
  (check-equal? ((dynamic-coeffs-poly '(1 10)) 5) 51)
  (check-equal? ((dynamic-coeffs-poly '(2)) 5) 2)
  (check-equal? ((dynamic-coeffs-poly '()) 8) 0)
)
(dynamic-coeffs-poly-tests)
