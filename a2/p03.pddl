(define (problem p3-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-3-4 loc-4-5 loc-1-2 loc-2-2 loc-3-2 loc-3-3 loc-2-5 loc-1-3 loc-2-1 loc-1-4 loc-3-5 loc-2-4 loc-4-4 loc-2-3 loc-4-3 - location
    c2122 c1222 c2232 c1213 c1223 c2223 c3223 c3233 c1323 c2333 c1314 c2314 c2324 c2334 c3334 c1424 c2434 c2425 c2535 c3545 c4544 c4443 - corridor
    key1 key2 key3 key4 key5 key6 - key
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-2-1)
    (not(hero-holding))

    ; Locationg <> Corridor Connections
    (corridor-connect c2122 loc-2-1 loc-2-2)
    (corridor-connect c2122 loc-2-2 loc-2-1)

    (corridor-connect c1222 loc-1-2 loc-2-2)
    (corridor-connect c1222 loc-2-2 loc-1-2)

    (corridor-connect c2232 loc-2-2 loc-3-2)
    (corridor-connect c2232 loc-3-2 loc-2-2)

    (corridor-connect c1213 loc-1-2 loc-1-3)
    (corridor-connect c1213 loc-1-3 loc-1-2)

    (corridor-connect c1223 loc-1-2 loc-2-3)
    (corridor-connect c1223 loc-2-3 loc-1-2)

    (corridor-connect c2223 loc-2-2 loc-2-3)
    (corridor-connect c2223 loc-2-3 loc-2-2)

    (corridor-connect c3223 loc-3-2 loc-2-3)
    (corridor-connect c3223 loc-2-3 loc-3-2)

    (corridor-connect c3233 loc-3-2 loc-3-3)
    (corridor-connect c3233 loc-3-3 loc-3-2)

    (corridor-connect c1323 loc-1-3 loc-3-3)
    (corridor-connect c1323 loc-3-3 loc-1-3)

    (corridor-connect c2333 loc-2-3 loc-3-3)
    (corridor-connect c2333 loc-3-3 loc-2-3)
    
    (corridor-connect c1314 loc-1-3 loc-1-4)
    (corridor-connect c1314 loc-1-4 loc-1-3)

    (corridor-connect c2314 loc-2-3 loc-1-4)
    (corridor-connect c2314 loc-1-4 loc-2-3)

    (corridor-connect c2324 loc-2-3 loc-2-4)
    (corridor-connect c2324 loc-2-4 loc-2-3)

    (corridor-connect c2334 loc-2-3 loc-3-4)
    (corridor-connect c2334 loc-3-4 loc-2-3)

    (corridor-connect c3334 loc-3-3 loc-3-4)
    (corridor-connect c3334 loc-3-4 loc-3-3)

    (corridor-connect c1424 loc-1-4 loc-2-4)
    (corridor-connect c1424 loc-2-4 loc-1-4)

    (corridor-connect c2434 loc-2-4 loc-3-4)
    (corridor-connect c2434 loc-3-4 loc-2-4)

    (corridor-connect c2425 loc-2-4 loc-2-5)
    (corridor-connect c2425 loc-2-5 loc-2-4)

    (corridor-connect c2535 loc-2-5 loc-3-5)
    (corridor-connect c2535 loc-3-5 loc-2-5)

    (corridor-connect c3545 loc-3-5 loc-4-5)
    (corridor-connect c3545 loc-4-5 loc-3-5)

    (corridor-connect c4544 loc-4-5 loc-4-4)
    (corridor-connect c4544 loc-4-4 loc-4-5)

    (corridor-connect c4443 loc-4-4 loc-4-3)
    (corridor-connect c4443 loc-4-3 loc-4-4)



    ; Key locations
    (key-at key1 loc-2-1)
    (key-at key2 loc-2-3)
    (key-at key3 loc-2-3)
    (key-at key4 loc-2-3)
    (key-at key5 loc-2-3)
    (key-at key6 loc-4-4)

    ; Locked corridors
    (is-locked c1223)
    (is-locked c2223)
    (is-locked c3223)
    (is-locked c1323)
    (is-locked c2314)
    (is-locked c2333)
    (is-locked c2334)
    (is-locked c2324)

    (is-locked c2425)
    (is-locked c2535)
    (is-locked c3545)
    (is-locked c4544)
    (is-locked c4443)

    (locked c1223 red)
    (locked c2223 red)
    (locked c3223 red)
    (locked c1323 red)
    (locked c2314 red)
    (locked c2333 red)
    (locked c2334 red)
    (locked c2324 red)

    (locked c2425 purple)
    (locked c2535 green)
    (locked c3545 purple)
    (locked c4544 green)
    (locked c4443 rainbow)

    ; Risky corridors
    (risky c1223)
    (risky c2223)
    (risky c3223)
    (risky c1323)
    (risky c2314)
    (risky c2333)
    (risky c2334)
    (risky c2324)

    ; Key colours
    (key-is-colour key1 red)
    (key-is-colour key2 green)
    (key-is-colour key3 green)
    (key-is-colour key4 purple)
    (key-is-colour key5 purple)
    (key-is-colour key6 rainbow)

    ; Key usage properties (one use, two use, etc)
    (is-multi-use key1)
    (is-one-use key2)
    (is-one-use key3)
    (is-one-use key4)
    (is-one-use key5)
    (is-one-use key6)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-4-3)
    )
  )

)
