; Rodney RAM-resident Beta seed
;
; Load this into program RAM at 0100H.
;
; This is a deliberately small first-pass learning loop:
; - read ENVL
; - use ENVL as the learned-state address
; - fetch the learned byte
; - if confidence is zero, choose a random action nibble and store it
;   with confidence level 1
; - otherwise drive ACTL from the stored action nibble
;
; This is not the full Beta/Gamma reconstruction from the book.
; It is the smallest plausible RAM program that exercises the same core
; idea: writable learned state indexed by environmental condition.

        ORG     0100H

READ_ENVL        EQU     2020H
READ_TSWR        EQU     2028H
WRITE_ACTL       EQU     202EH
SET_MMA_FROM_A   EQU     2036H
READ_MMD         EQU     204CH
WRITE_MMD        EQU     2050H

START:
        CALL    READ_ENVL
        CALL    SET_MMA_FROM_A
        CALL    READ_MMD
        MOV     B,A
        ANI     0C0H
        JZ      UNKNOWN

KNOWN:
        MOV     A,B
        ANI     0FH
        CALL    WRITE_ACTL
        JMP     START

UNKNOWN:
        CALL    READ_TSWR
        ANI     0FH
        MOV     B,A
        ORI     40H
        CALL    WRITE_MMD
        MOV     A,B
        CALL    WRITE_ACTL
        JMP     START

        END
