#!/usr/bin/env racket

;; If loading into the REPL, comment out the #lang line and provide
;; expressions.  MAKE SURE YOU UNCOMMENT BEFORE SUBMISSION.
lang racket

(provide list-prod list-fn quadratic-roots lists-quadratic-roots
	 sum-lengths prod-lengths eval-poly
)

;; to trace function fn, add (trace fn) after fn's definition
(require racket/trace)  



(define (list-prod ls1 ls2)
  (if (or (null? ls1) (null? ls2))
      '()
      (cons (* (car ls1) (car ls2)) (list-prod (cdr ls1) (cdr ls2)))))


(define (list-fn fn ls1 ls2)
  (if (or (null? ls1) (null? ls2))
      '()
      (cons (fn (car ls1) (car ls2)) (list-fn fn (cdr ls1) (cdr ls2)))))

(define (quadratic-roots a b c)
  (let* ((discriminant (- (* b b) (* 4 a c)))
         (sqrt-disc (sqrt discriminant))
         (root1 (/ (+ (- b) sqrt-disc) (* 2 a)))
         (root2 (/ (- (- b) sqrt-disc) (* 2 a))))
    (list root1 root2)))

(define (lists-quadratic-roots list-as list-bs list-cs)
  (if (or (null? list-as) (null? list-bs) (null? list-cs))
      '()
      (cons (quadratic-roots (car list-as) (car list-bs) (car list-cs))
            (lists-quadratic-roots (cdr list-as) (cdr list-bs) (cdr list-cs)))))

(define (sum-lengths ls)
  (if (null? ls)
      0
      (+ (length (car ls)) (sum-lengths (cdr ls)))))

(define (prod-lengths ls)
  (aux-prod-lengths ls 1))  

(define (aux-prod-lengths ls product)
  (if (null? ls)
      product  
      (aux-prod-lengths (cdr ls) (* product (length (car ls))))))

(define (eval-poly x coeff-power-list)
  (if (null? coeff-power-list)
      0
      (+ (* (caar coeff-power-list) (expt x (cadar coeff-power-list)))
         (eval-poly x (cdr coeff-power-list)))))


