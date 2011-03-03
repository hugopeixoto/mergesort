(define list-head
  (lambda (lst n)
    (if (eq? n 0) '() (cons (car lst) (list-head (cdr lst) (- n 1))))))

(define list-tail
  (lambda (lst n)
    (if (eq? n 0) lst (list-tail (cdr lst) (- n 1)))))

(define merge
  (lambda (lst-a lst-b)
    (cond ((null? lst-a) lst-b)
          ((null? lst-b) lst-a)
          (else
           (if (< (car lst-a) (car lst-b))
               (cons (car lst-a) (merge (cdr lst-a) lst-b))
               (cons (car lst-b) (merge lst-a (cdr lst-b)))
                                               )))))

(define mergesort
  (lambda (lst)
    (if (eq? (length lst) 1) lst (merge (mergesort (list-head lst (quotient (length lst) 2)))
                                        (mergesort (list-tail lst (quotient (length lst) 2)))
                                                           ))))

(mergesort '(10 9 8 4 5 6 7 3 2 1))
