(define (problem p4-dungeon)
  (:domain Dungeon)

  ; Come up with your own problem instance (see assignment for details)
  ; NOTE: You _may_ use new objects for this problem only.

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-1-1 loc-1-2 loc-2-1 loc-2-2 loc-3-2 loc-1-3 loc-2-3 loc-3-3 loc-1-4 - location
    key1 key2 key3 key4 key5 key6 - key
    c1112 c1121 c2122 c1222 c1213 c1223 c2232 c2223 c3223 c3233 c1323 c2333 c1314 - corridor
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-1-1)
    (not (hero-holding))

    ; Corridor connections
    (corridor-connect c1112 loc-1-1 loc-1-2)
    (corridor-connect c1112 loc-1-2 loc-1-1)

    (corridor-connect c1121 loc-1-1 loc-2-1)
    (corridor-connect c1121 loc-2-1 loc-1-1)

    (corridor-connect c2122 loc-2-1 loc-2-2)
    (corridor-connect c2122 loc-2-2 loc-2-1)

    (corridor-connect c1222 loc-1-2 loc-2-2)
    (corridor-connect c1222 loc-2-2 loc-1-2)

    (corridor-connect c1213 loc-1-2 loc-1-3)
    (corridor-connect c1213 loc-1-3 loc-1-2)

    (corridor-connect c1223 loc-1-2 loc-2-3)
    (corridor-connect c1223 loc-2-3 loc-1-2)

    (corridor-connect c2232 loc-2-2 loc-3-2)
    (corridor-connect c2232 loc-3-2 loc-2-2)

    (corridor-connect c2223 loc-2-2 loc-2-3)
    (corridor-connect c2223 loc-2-3 loc-2-2)

    (corridor-connect c3223 loc-3-2 loc-2-3)
    (corridor-connect c3223 loc-2-3 loc-3-2)

    (corridor-connect c3233 loc-3-2 loc-3-3)
    (corridor-connect c3233 loc-3-3 loc-3-2)

    (corridor-connect c1323 loc-1-3 loc-2-3)
    (corridor-connect c1323 loc-2-3 loc-1-3)

    (corridor-connect c2333 loc-2-3 loc-3-3)
    (corridor-connect c2333 loc-3-3 loc-2-3)

    (corridor-connect c1314 loc-1-3 loc-1-4)
    (corridor-connect c1314 loc-1-4 loc-1-3)

    ; Key placements
    (key-at key1 loc-2-1)
    (key-at key2 loc-3-2)
    (key-at key3 loc-1-3)
    (key-at key4 loc-2-3)
    (key-at key5 loc-3-3)
    (key-at key6 loc-1-2)


    ; Locked corridors
    (is-locked c1112) (locked c1112 red)
    (is-locked c1213) (locked c1213 red)
    (is-locked c2122) (locked c2122 yellow)
    (is-locked c1223) (locked c1223 green)
    (is-locked c1222) (locked c1222 green)
    (is-locked c3223) (locked c3223 red)
    (is-locked c2232) (locked c2232 purple)
    (is-locked c3233) (locked c3233 rainbow)
    (is-locked c1323) (locked c1323 rainbow)
    (is-locked c1314) (locked c1314 rainbow)

    ; Key colors
    (key-is-colour key1 red)
    (key-is-colour key2 yellow)
    (key-is-colour key3 green)
    (key-is-colour key4 purple)
    (key-is-colour key5 rainbow)
    (key-is-colour key6 red)

    ; Key usage
    (is-one-use key1)
    (is-one-use key2)
    (is-one-use key3)
    (is-one-use key4)
    (is-multi-use key5)
    (is-one-use key6)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-1-4)
    )
  )

)
