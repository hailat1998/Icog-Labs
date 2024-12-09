! (import! &kb kb)
! (import &utils utils)


!(= (sup) (2))

! (add-reduct &self (= (pattern-space) (new-space)))



(= (pattern $x $y)
   (match &kb (Inheritance $x $y)
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
$shabY
))
))


!(shab)





