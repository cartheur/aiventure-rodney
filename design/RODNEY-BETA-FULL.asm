; Rodney fuller Beta-style RAM runtime
;
; Load at 0100H in program RAM.
;
; This file extends RODNEY-BETA-SEED.asm without replacing it.
; It preserves the same indirect learned-state model:
; - ENVL selects a learned-state address
; - MMD holds one learned byte
; - low nibble = action code
; - upper two bits = confidence
; - confidence 0 means unknown
;
; Confidence encoding:
; - 00xxxxxx = unknown
; - 01xxxxxx = confidence 1
; - 10xxxxxx = confidence 2
; - 11xxxxxx = confidence 3
;
; Bench-first validity model:
; - action 0 is treated as "stop" and undesirable when FEED is low
; - action non-zero is treated as usable in non-feed situations
; - when FEED is high, action 0 becomes the preferred response
;
; This is still a simplification of the original book logic, but it adds:
; - confidence increment
; - confidence decrement
; - write-back of revised learned state
; - explicit response selection policy

        ORG     0100H

READ_ENVL        EQU     2020H
READ_TSWR        EQU     2028H
WRITE_ACTL       EQU     202EH
SET_MMA_FROM_A   EQU     2036H
READ_MMD         EQU     204CH
WRITE_MMD        EQU     2050H

CONF_MASK        EQU     0C0H
ACT_MASK         EQU     0FH
FEED_MASK        EQU     40H

CONF1            EQU     40H
CONF2            EQU     80H
CONF3            EQU     0C0H

START:
        CALL    READ_ENVL
        MOV     C,A
        CALL    SET_MMA_FROM_A
        CALL    READ_MMD
        MOV     B,A
        ANI     CONF_MASK
        JZ      UNKNOWN

        MOV     A,B
        ANI     ACT_MASK
        MOV     D,A
        MOV     A,C
        ANI     FEED_MASK
        JZ      NOT_FEED

FEED_CASE:
        MOV     A,D
        ORA     A
        JZ      SUCCESS_FEED
        JMP     FAILURE

NOT_FEED:
        MOV     A,D
        ORA     A
        JZ      FAILURE
        JMP     SUCCESS_RUN

UNKNOWN:
        CALL    SELECT_RANDOM_ACTION
        MOV     D,A
        CALL    STORE_ACTION_CONF1
        MOV     A,D
        CALL    WRITE_ACTL
        JMP     START

SUCCESS_FEED:
        XRA     A
        CALL    WRITE_ACTL
        MOV     A,B
        CALL    INCREMENT_CONFIDENCE
        CALL    WRITE_MMD
        JMP     START

SUCCESS_RUN:
        MOV     A,D
        CALL    WRITE_ACTL
        MOV     A,B
        CALL    INCREMENT_CONFIDENCE
        CALL    WRITE_MMD
        JMP     START

FAILURE:
        MOV     A,B
        CALL    DECREMENT_CONFIDENCE
        MOV     B,A
        ANI     CONF_MASK
        JZ      REPLACE_WITH_RANDOM
        MOV     A,B
        CALL    WRITE_MMD
        JMP     START

REPLACE_WITH_RANDOM:
        CALL    SELECT_RANDOM_ACTION
        MOV     D,A
        CALL    STORE_ACTION_CONF1
        MOV     A,D
        CALL    WRITE_ACTL
        JMP     START

; ----------------------------------------------------------------------
; Helpers
; ----------------------------------------------------------------------

SELECT_RANDOM_ACTION:
        CALL    READ_TSWR
        ANI     ACT_MASK
        JNZ     RAND_OK
        MVI     A,01H
RAND_OK:
        RET

STORE_ACTION_CONF1:
        ANI     ACT_MASK
        ORI     CONF1
        CALL    WRITE_MMD
        RET

INCREMENT_CONFIDENCE:
        MOV     E,A
        ANI     CONF_MASK
        CPI     CONF1
        JZ      INC_TO_2
        CPI     CONF2
        JZ      INC_TO_3
        CPI     CONF3
        JZ      INC_DONE
        MOV     A,E
        ANI     ACT_MASK
        ORI     CONF1
        RET

INC_TO_2:
        MOV     A,E
        ANI     ACT_MASK
        ORI     CONF2
        RET

INC_TO_3:
        MOV     A,E
        ANI     ACT_MASK
        ORI     CONF3
        RET

INC_DONE:
        MOV     A,E
        RET

DECREMENT_CONFIDENCE:
        MOV     E,A
        ANI     CONF_MASK
        CPI     CONF3
        JZ      DEC_TO_2
        CPI     CONF2
        JZ      DEC_TO_1
        CPI     CONF1
        JZ      DEC_TO_0
        XRA     A
        RET

DEC_TO_2:
        MOV     A,E
        ANI     ACT_MASK
        ORI     CONF2
        RET

DEC_TO_1:
        MOV     A,E
        ANI     ACT_MASK
        ORI     CONF1
        RET

DEC_TO_0:
        XRA     A
        RET

        END
