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
(= (foldl NilNum $f $initial) $initial)
(= (foldl (ConsNum $x $xs) $f $initial)(
            foldl $xs $f ($f $initial $x) )
        )



(= (add $x $y)(+ $x $y))
(= (mul $x $y)(* $x $y))

!(foldl (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) add 0 )
!(foldl (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) mul 1 )

(= (isMember NilNum $y) False)
(= (isMember  (ConsNum $x $xs) $y)(
    if(== $x $y) True (isMember $xs $y)
         )
     )
!(isMember (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) 23)
!(isMember (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) 20)

(= (length NilNum) 0)
(= (length (ConsNum $x $xs))
   (+ 1 (length $xs)))
!(length (ConsNum 1 (ConsNum 2 (ConsNum 3 NilNum))))

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

(= (removeElement NilNum  $c $y)  $c)
;(= (removeElement NilNum NilNum $y) NilNum)

(= (removeElement (ConsNum $x $xs) $acc $y)
   (if (== $x $y)
      (removeElement $xs $acc $y)
      (removeElement $xs (ConsNum $x $acc) $y)))

!(removeElement (ConsNum 1 (ConsNum 5 (ConsNum 3 (ConsNum 10 NilNum)))) NilNum 5)


(= (filter NilNum  $c $f $y) $c)
(= (filter (ConsNum $x $xs) $acc $f $y)(
     if($f $x) (filter $xs (ConsNum $x $acc) $f $y)
       (filter $xs $acc $f $y)
))

(= (gr2 $x)(
    > $x 1
))

!(filter (ConsNum 1 (ConsNum 5 (ConsNum 3 (ConsNum 10 NilNum)))) NilNum gr2 $x)

(= (append NilNum $x)
   (ConsNum $x NilNum))

(= (append (ConsNum $x $xs) $y)
   (ConsNum $x (append $xs $y)))

!(append  (ConsNum 1 (ConsNum 5 (ConsNum 3 (ConsNum 10 NilNum)))) 8)

(= (push NilNum $y)
(
    (ConsNum $y NilNum)
))

(= (push $xs $y)
(
 (ConsNum $y $xs)
))

!(push (ConsNum 1 (ConsNum 5 (ConsNum 3 (ConsNum 10 NilNum)))) 12)


(= (pop NilNum) NilNum)

(= (pop (ConsNum $x $xs))
(
 if(== $xs NilNum) $x (pop $xs)
))


!(pop (ConsNum 1 (ConsNum 5 (ConsNum 3 (ConsNum 10 NilNum)))))

(= (reverse NilNum $acc) $acc )
(= (reverse (ConsNum $x $xs) $acc)
(
   reverse $xs (ConsNum $x $acc)
))
!(reverse (ConsNum 1 (ConsNum 5 (ConsNum 3 (ConsNum 10 NilNum)))) NilNum)

(= (foldr NilNum $f $initial) $initial)
(= (foldr (ConsNum $x $xs) $f $initial)(
    foldl (reverse (ConsNum $x $xs) NilNum) $f $initial
))

!(foldr (ConsNum 23 (ConsNum 54 (ConsNum 76 NilNum))) add 0 )

(= (sort NilNum $sorted) $sorted)

(= (sort (ConsNum $x $xs) $sorted)
    (insert $x (sort $xs $sorted)))

(= (insert $x NilNum) (ConsNum $x NilNum))

(= (insert $x (ConsNum $y $ys))
    (if (< $x $y)
        (ConsNum $x (ConsNum $y $ys))
        (ConsNum $y (insert $x $ys))))

!(sort (ConsNum 100 (ConsNum 1000 (ConsNum 76 NilNum))) NilNum)

