#lang racket/base
(provide hamming-distance)
(define (hamming-distance a b)
  (if (= (string-length a) (string-length b))
      (for/sum ([ca (in-string a)] [cb (in-string b)]) (if (char=? ca cb) 0 1))
      -1))
