; put you code here
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
        ((ConsNum $x $xs) (foldr $xs (+ $initial $x)))
        )
      )
    ;  $initial
    )
)
!(foldr (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) 0 )

(= (isMember $list $y)(
     (case $list 
      (
        (NilNum False)
        ((ConsNum $x $xs)(or (== $x $y) (isMember $xs $y)))
         )
     )
))


!(isMember (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) 23)
!(isMember (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) 20)

(= (length NilNum) 0)
(= (length (ConsNum $x $xs))
   (+ 1 (length $xs)))
! (length (ConsNum 1 (ConsNum 2 (ConsNum 3 NilNum))))

(= (maxValue NilNum $cur ) $cur)
(= (maxValue (ConsNum $x $xs) $cur)(
   if(> $cur $x) (maxValue $xs $cur) (maxValue $xs $x )
   ))
!(maxValue (ConsNum 1 (ConsNum 58 (ConsNum 3 NilNum))) -2)

(= (minValue NilNum $cur ) $cur)
(= (minValue (ConsNum $x $xs) $cur)(
   if(< $cur $x) (minValue $xs $cur) (minValue $xs $x )
   ))
!(minValue (ConsNum 1 (ConsNum 58 (ConsNum 3 NilNum))) 100)


(= (map $f NilNum) ())
(= (map $f (ConsNum $x $xs))(
    ConsNum ($f $x) (map $f $xs) 
))

(= (square $x)(* $x $x))

!(map square (ConsNum 1 (ConsNum 5 (ConsNum 3 NilNum))))

(= (removeElement NilNum) NilNum)
(= (removeElement (ConsNum $x $xs) $y )(
    if(== $y $x)(Cons)
) )
