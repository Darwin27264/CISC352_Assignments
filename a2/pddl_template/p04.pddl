(define (problem p4-dungeon)
  (:domain Dungeon)

  ; Come up with your own problem instance (see assignment for details)
  ; NOTE: You _may_ use new objects for this problem only.

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-1-1 loc-1-2 loc-2-1 loc-2-2 loc-3-1 loc-3-2 loc-4-1 loc-4-2 - location
    key1 key2 key3 key4 key5 - key
    c1112 c1121 c2122 c2212 c3132 c3231 c4142 c4241 c1122 c2211 c3132 c3231 c4142 c4241 c1221 c2112 - corridor
  )

  (:init

    ; Hero starts at loc-1-1
    (hero-at loc-1-1)
    (not (hero-holding))

    ; Key locations
    (key-at key1 loc-1-2) ; Let's assume key1 is red
    (key-at key2 loc-2-2) ; key2 is yellow
    (key-at key3 loc-3-1) ; key3 is green
    (key-at key4 loc-4-1) ; key4 is purple
    (key-at key5 loc-3-2) ; key5 is rainbow

    ; Corridor connections
    (corridor-connect c1112 loc-1-1 loc-1-2)
    (corridor-connect c1121 loc-1-2 loc-2-1)
    (corridor-connect c2122 loc-2-1 loc-2-2)
    (corridor-connect c2212 loc-2-2 loc-1-2)
    (corridor-connect c3132 loc-3-1 loc-3-2)
    (corridor-connect c3231 loc-3-2 loc-2-1)
    (corridor-connect c4142 loc-4-1 loc-4-2)
    (corridor-connect c4241 loc-4-2 loc-3-1)
    (corridor-connect c1122 loc-1-2 loc-2-2)
    (corridor-connect c2211 loc-2-2 loc-1-1)
    (corridor-connect c1221 loc-1-2 loc-2-1)
    (corridor-connect c2112 loc-2-1 loc-1-2)

    ; Locked corridors with corresponding colors
    (is-locked c1112)
    (locked c1112 red)
    (is-locked c2122)
    (locked c2122 yellow)
    (is-locked c3132)
    (locked c3132 green)
    (is-locked c4142)
    (locked c4142 purple)
    (is-locked c1122)
    (locked c1122 rainbow)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-4-2)
    )
  )

)
