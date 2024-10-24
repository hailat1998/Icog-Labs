(: List type)
(: Nil List)
(: Cons (-> Number List List))

!(get-type (Cons 1 Nil))    ; List
!(Cons 1 (Cons 2 (Cons 3 Nil))) ; [1,2,3]
(= (head $list)
    (case $list
         (
            (Nil Nil)
            ((Cons $x $xs) $x)
        )
    )
)
!(head (Cons 1 (Cons 2 (Cons 3 Nil))))


(: ListNum type)
(: NilNum ListNum)
(: ConsNum (-> Number ListNum ListNum))
!  (ConsNum 1 (ConsNum 2 (ConsNum 3 NilNum))) ; ListNum

(= (head $list)
   (case $list
    (
    (NilNum NilNum)
    ((ConsNum $x $xs) $x)
    )
))
!(head (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))))

(= (foldr $list $initial)(
    (case $list 
        (
        (NilNum $initial)
        ((ConsNum $x $xs) ((foldr $xs (+ $initial $x))))
        )
      )
    ;  $initial
    ) 
)

(= (factorial $x)
   (case $x
     ((0 1)
      ($_ (* $x (factorial (- $x 1)))))
   )
)


!(foldr (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) 0 )

(= (sum-multiple $num $sum)
    (if (> $num 0)
        (if (or (== 0 (% $num 3)) (== 0 (% $num 5)))
            (sum-multiple (- $num 1) (+ $sum $num))
            (sum-multiple (- $num 1) $sum)
        )
        $sum
    )
)
; Sum of multiples of 3 and 5 upto 10
!(sum-multiple 15 0)

