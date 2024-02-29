(define (problem p1-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-3-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 loc-3-3 loc-2-4 loc-3-4 loc-4-4 - location
    key1 key2 key3 key4 - key
    c3132 c1222 c2232 c3242 c2223 c3233 c2333 c2324 c3334 c2434 c3444 - corridor
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-1-2)
    (not (hero-holding))

    ; Location <> Corridor Connections
    (corridor-connect c3132 loc-3-1 loc-3-2)
    (corridor-connect c3132 loc-3-2 loc-3-1)

    (corridor-connect c1222 loc-1-2 loc-2-2)
    (corridor-connect c1222 loc-2-2 loc-1-2)

    (corridor-connect c2232 loc-2-2 loc-3-2)
    (corridor-connect c2232 loc-3-2 loc-2-2)

    (corridor-connect c3242 loc-3-2 loc-4-2)
    (corridor-connect c3242 loc-4-2 loc-3-2)

    (corridor-connect c2223 loc-2-2 loc-2-3)
    (corridor-connect c2223 loc-2-3 loc-2-2)

    (corridor-connect c3233 loc-3-2 loc-3-3)
    (corridor-connect c3233 loc-3-3 loc-3-2)

    (corridor-connect c2333 loc-2-3 loc-3-3)
    (corridor-connect c2333 loc-3-3 loc-2-3)

    (corridor-connect c2324 loc-2-3 loc-2-4)
    (corridor-connect c2324 loc-2-4 loc-2-3)

    (corridor-connect c3334 loc-3-3 loc-3-4)
    (corridor-connect c3334 loc-3-4 loc-3-3)

    (corridor-connect c2434 loc-2-4 loc-3-4)
    (corridor-connect c2434 loc-3-4 loc-2-4)

    (corridor-connect c3444 loc-3-4 loc-4-4)
    (corridor-connect c3444 loc-4-4 loc-3-4)

    
    ; Key locations
    (key-at key1 loc-2-2)
    (key-at key2 loc-2-4)
    (key-at key3 loc-4-2)
    (key-at key4 loc-4-4)
    

    ; Locked corridors
    (locked c2324 red)
    (locked c2434 red)
    (locked c3444 yellow)
    (locked c3242 purple)
    (locked c3132 rainbow)
    (is-locked c2324)
    (is-locked c2434)
    (is-locked c3444)
    (is-locked c3242)
    (is-locked c3132)

    ; Risky corridors
    (risky c2324)
    (risky c2434)

    ; Key colours
    (key-is-colour key1 red)
    (key-is-colour key2 yellow)
    (key-is-colour key3 rainbow)
    (key-is-colour key4 purple)

    ; Key usage properties (one use, two use, etc)
    (is-multi-use key1)
    (is-two-use key2)
    (is-one-use key3)
    (is-one-use key4)


  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-3-1)
    )
  )

)
