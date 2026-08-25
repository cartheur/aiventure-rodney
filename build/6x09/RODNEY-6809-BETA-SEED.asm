; Rodney RAM-resident Beta seed for a first-pass 6809 redesign
;
; Load this into program RAM at $0100.
;
; This mirrors the existing 8085 Beta seed:
; - read ENVL
; - use ENVL as the learned-state address
; - fetch the learned byte
; - if confidence is zero, choose a random action nibble and store it
;   with confidence level 1
; - otherwise drive ACTL from the stored action nibble
;
; This is intentionally small and conservative. It is the first software
; target after the support ROM comes up cleanly.

        ORG     $0100

READ_ENVL        EQU     $E020
READ_TSWR        EQU     $E028
WRITE_ACTL       EQU     $E02E
SET_MMA_FROM_A   EQU     $E036
READ_MMD         EQU     $E04C
WRITE_MMD        EQU     $E050

CONF_MASK        EQU     $C0
ACT_MASK         EQU     $0F
CONF1            EQU     $40

START:
        JSR     READ_ENVL
        JSR     SET_MMA_FROM_A
        JSR     READ_MMD
        TFR     A,B
        ANDB    #CONF_MASK
        BEQ     UNKNOWN

KNOWN:
        TFR     A,B
        ANDB    #ACT_MASK
        TFR     B,A
        JSR     WRITE_ACTL
        JMP     START

UNKNOWN:
        JSR     READ_TSWR
        ANDA    #ACT_MASK
        TFR     A,B
        ORA     #CONF1
        JSR     WRITE_MMD
        TFR     B,A
        JSR     WRITE_ACTL
        JMP     START

        END
