(define (domain Dungeon)

    (:requirements
        :typing
        :negative-preconditions
        :conditional-effects
    )

    ; Do not modify the types
    (:types
        location colour key corridor
    )

    ; Do not modify the constants
    (:constants
        red yellow green purple rainbow - colour
    )

    ; You may introduce whatever predicates you would like to use
    (:predicates

        ; One predicate given for free!
        (hero-at ?loc - location)
        
        ; IMPLEMENT ME
        (corridor-connect ?cor - corridor ?from - location ?to - location)
        (is-locked ?cor - corridor)
        (locked ?cor - corridor ?col - colour)
        (risky ?cor - corridor)
        (messy ?loc - location)
        (key-at ?k - key ?loc - location) 
        (hero-holding) ; if hero is holding ANY object, this is set to true, there isnt a given arugment for this predicate, so im not sure if this works...
        (key-is-colour ?k - key ?col - colour)
        (hero-holding-key ?k - key) ; this one checks if the hero is holding a specific key
        (is-no-use ?k -key)
        (is-one-use ?k - key) ; checks if the key has only one use left
        (is-two-use ?k - key) ; checks if the key has two uses left
        (is-multi-use ?k - key) ; checks if the key has more than two uses left


    )


    ; IMPORTANT: You should not change/add/remove the action names or parameters

    ;Hero can move if the
    ;    - hero is at current location ?from,
    ;    - hero will move to location ?to,
    ;    - corridor ?cor exists between the ?from and ?to locations
    ;    - there isn't a locked door in corridor ?cor
    ;Effects move the hero, and collapse the corridor if it's "risky" (also causing a mess in the ?to location)
    (:action move

        :parameters (?from ?to - location ?cor - corridor)

        :precondition (and

            ; IMPLEMENT ME
            (hero-at ?from)
            (corridor-connect ?cor ?from ?to)
            (not (is-locked ?cor))
            
        )

        :effect (and

            ; IMPLEMENT ME
            (not (hero-at ?from))                         ; Hero is no longer at the starting location
            (hero-at ?to)                                 ; Hero is now at the destination
            (when (risky ?cor)                            ; If the corridor is risky
                (and
                    (not (corridor-connect ?cor ?from ?to))       ; The corridor collapses
                    (messy ?to)                           ; The destination becomes messy
                )
            )
        )
    )

    ;Hero can pick up a key if the
    ;    - hero is at current location ?loc,
    ;    - there is a key ?k at location ?loc,
    ;    - the hero's arm is free,
    ;    - the location is not messy
    ;Effect will have the hero holding the key and their arm no longer being free
    (:action pick-up

        :parameters (?loc - location ?k - key)

        :precondition (and

            ; IMPLEMENT ME
            (hero-at ?loc)
            (key-at ?k ?loc)
            (not (hero-holding)) ; this should be hero holding anything, not hero holding the key
            (not (messy ?loc))

        )

        :effect (and

            ; IMPLEMENT ME
            (hero-holding)
            (hero-holding-key ?k)
            (not (key-at ?k ?loc))
            
        )
    )

    ;Hero can drop a key if the
    ;    - hero is holding a key ?k,
    ;    - the hero is at location ?loc
    ;Effect will be that the hero is no longer holding the key
    (:action drop

        :parameters (?loc - location ?k - key)

        :precondition (and

            ; IMPLEMENT ME
            (hero-holding-key ?k)
            (hero-at ?loc)
        )

        :effect (and

            ; IMPLEMENT ME
            (not (hero-holding))
            (not (hero-holding-key ?k))
            (key-at ?k ?loc)
        )
    )


    ;Hero can use a key for a corridor if
    ;    - the hero is holding a key ?k,
    ;    - the key still has some uses left,
    ;    - the corridor ?cor is locked with colour ?col,
    ;    - the key ?k is if the right colour ?col,
    ;    - the hero is at location ?loc
    ;    - the corridor is connected to the location ?loc
    ;Effect will be that the corridor is unlocked and the key usage will be updated if necessary
    (:action unlock

        :parameters (?loc - location ?cor - corridor ?col - colour ?k - key)

        :precondition (and

            ; IMPLEMENT ME
            (hero-holding-key ?k)
            (locked ?cor ?col)
            (key-is-colour ?k ?col)
            (hero-at ?loc)
            (not (is-no-use ?k))

        )

        :effect (and

            ; IMPLEMENT ME
            ; unlock door
            ; key use decrease
            (not (locked ?cor ?col))
            (not (is-locked ?cor))
            (when (is-one-use ?k)
                (and
                    (not (is-one-use ?k))
                    (is-no-use ?k)
                )
            )
            (when (is-two-use ?k)
                (and
                    (not (is-two-use ?k))
                    (is-one-use ?k)
                )
            )
            (when (is-multi-use ?k)
                (and
                    (is-multi-use ?k)
                )
            )

        )    
    )

    ;Hero can clean a location if
    ;    - the hero is at location ?loc,
    ;    - the location is messy
    ;Effect will be that the location is no longer messy
    (:action clean

        :parameters (?loc - location)

        :precondition (and

            ; IMPLEMENT ME
            (hero-at ?loc)
            (messy ?loc)

        )

        :effect (and

            ; IMPLEMENT ME
            (not (messy ?loc))

        )
    )

    )
