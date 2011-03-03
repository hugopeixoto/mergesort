(defun list-head (lst n) (if (eq n 0) '() (cons (car lst) (list-head (cdr lst) (- n 1)))))
(defun list-tail (lst n) (if (eq n 0) lst (list-tail (cdr lst) (- n 1))))

(defun _merge (lst-a lst-b)
  (cond ((not lst-a) lst-b)
        ((not lst-b) lst-a)
        ((< (car lst-a) (car lst-b)) (cons (car lst-a) (_merge (cdr lst-a) lst-b)))
        (T (cons (car lst-b) (_merge lst-a (cdr lst-b))))))

(defun mergesort (lst)
  (if (eq (length lst) 1)
    lst
    (_merge (mergesort (list-head lst (truncate (length lst) 2)))
            (mergesort (list-tail lst (truncate (length lst) 2))))))

