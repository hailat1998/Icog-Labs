= (Tree Nil) True)
(= (Tree (Node $value $left $right))
    (and (Tree $left)
         (Tree $right)))
