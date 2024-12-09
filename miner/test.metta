
(Inheritance Dog Mammal)
(Inheritance Mammal Animal)
(Inheritance Animal Living)
(Inheritance Square Shape)
(Inheritance Bamboo Wood)


!(= (sup) (2))

! (add-reduct &self (= (pattern-space) (new-space)))



(= (pattern $x $y)
   (match &self (Inheritance $x $y)
         (Inheritance $x $y)))

! (pattern $x $y)


(= (count $x $val)
   (
    if(== $x ()) $val
    (count (cdr-atom $x) (+ $val 1))))

! (count (collapse (pattern $x $y)) 0)

(= (checkSup $count )
        (if(>= $count sup)
            (Supported)
            (Error Below Support)))

! (checkSup (count (collapse (pattern $x $y)) 0))

(= (matchX)(
    match &self (Inheritance $x $y)
         $x )
)

(= (matchY)(
 match &self (Inheritance $x $y)
         $y )
 )


! (matchX)
! (matchY)

(= (valuation $x $y)
   (let* (($patternX (matchX))
          ($patternY (matchY))
        ( $valX (cons-atom x-> $patternX))
        ( $valY (cons-atom y-> $patternY)))
        (cons-atom $valX ($valY))))

;! (valuation $x $y)



(= (shab)
   (let* (
          ($shabX ( matchX))
          ($shabY ( matchY))
        ( $mshabX (cons-atom $shabX (Variable y)))
        ( $mshabX| (cons-atom $mshabX (|))))
        ;(cons-atom $mshabX| $shabY)
(superpose(
(xShab $shabX)
($shabY)
))
))


!(shab)

!(------------------------------------------------------------------------------)
!(------------------------------------------------------------------------------)
!(------------------------------------------------------------------------------)
!(------------------------------------------------------------------------------)
!(------------------------------------------------------------------------------)


(= (specializeX $x)
   (let $exists (match pattern-space (= (pattern $y)
                                       (Inheritance $x $y))$x)
        (if (isNotEmpty $exists)
            (empty)
            (add-atom pattern-space
                      (= (pattern $y)
                         (Inheritance $x $y))))))


(= (specializeY $y)
   (let $exists (match pattern-space (= (pattern $x)
                                       (Inheritance $x $y)) $y)
        (if (isNotEmpty $exists)
            (empty)
            (add-atom pattern-space
                      (= (pattern $x)
                         (Inheritance $x $y))))))

;; we have to use the let block before making car-atom inside the Expression.
;; that have to be fixed in order to specialize the given shallow abstraction.
(= (specialize $shab)
   (let $shabV ($shab)
     (if (== $shabV ())
         (specializeY variable-Y)
         (if (== (get-metatype (car-atom $shabV)) Expression)
             (let $s (car-atom $shabV)
                  (specializeX (cdr-atom ($s))))
             ((specializeY (car-atom ($shabV)))
              (specialize (cdr-atom ($shabV))))))))

;!(specialize shab)

!(match pattern-space (=(pattern $x) (Inheritance $x $y)) (Inheritance $x $y) )





