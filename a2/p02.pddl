(define (problem p2-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-2-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 - location
    key1 key2 key3 key4 - key
    c2122 c1222 c2232 c3242 c2223 - corridor
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-2-2)
    (not (hero-holding))

    ; Locationg <> Corridor Connections
    (corridor-connect c2122 loc-2-1 loc-2-2)
    (corridor-connect c2122 loc-2-2 loc-2-1)

    (corridor-connect c1222 loc-1-2 loc-2-2)
    (corridor-connect c1222 loc-2-2 loc-1-2)

    (corridor-connect c2232 loc-2-2 loc-3-2)
    (corridor-connect c2232 loc-3-2 loc-2-2)

    (corridor-connect c3242 loc-3-2 loc-4-2)
    (corridor-connect c3242 loc-4-2 loc-3-2)

    (corridor-connect c2223 loc-2-2 loc-2-3)
    (corridor-connect c2223 loc-2-3 loc-2-2)



    ; Key locations
    (key-at key1 loc-2-1)
    (key-at key2 loc-1-2)
    (key-at key3 loc-2-2)
    (key-at key4 loc-2-3)

    ; Locked corridors
    (is-locked c2122)
    (is-locked c1222)
    (is-locked c2232)
    (is-locked c2223)
    (is-locked c3242)
    (locked c2122 purple)
    (locked c1222 yellow)
    (locked c2232 yellow)
    (locked c2223 green)
    (locked c3242 rainbow)

    ; Risky corridors

    ; Key colours
    (key-is-colour key1 green)
    (key-is-colour key2 rainbow)
    (key-is-colour key3 purple)
    (key-is-colour key4 yellow)

    ; Key usage properties (one use, two use, etc)
    (is-one-use key1)
    (is-one-use key2)
    (is-one-use key3)
    (is-two-use key4)


  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-4-2)
    )
  )

)
