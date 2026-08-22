; Rodney first-pass Gamma generalization routine
;
; Load at 0300H in program RAM and CALL explicitly from a supervisory
; Beta loop or invoke manually during bench experiments.
;
; This file is separate on purpose:
; - it does not replace the seed runtime
; - it does not replace the fuller Beta runtime
; - it isolates the first added generalization mechanism so behavior
;   changes can be traced cleanly
;
; First-pass scope:
; - operate on the 256-entry ENVL-indexed learned table
; - inspect all entries for high-confidence states
; - count action-bit majorities for one chosen action bit at a time
; - fill unknown states only
; - write generalized responses back at confidence 1
;
; This pass uses a deliberately small relevance rule:
; - group entries by the upper nibble of ENVL
; - infer the low nibble action bit D0 from high-confidence peers
;
; That is much smaller than the book's full Gamma scheme, but it is
; traceable and bench-testable on the new hardware.

        ORG     0300H

SET_MMA_FROM_A   EQU     2036H
READ_MMD         EQU     204CH
WRITE_MMD        EQU     2050H

CONF_MASK        EQU     0C0H
ACT_MASK         EQU     0FH
CONF1            EQU     40H
CONF3            EQU     0C0H

GAMMA1:
        PUSH    B
        PUSH    D
        PUSH    H

        MVI     H,00H          ; H = group selector in upper nibble

GROUP_LOOP:
        MVI     B,00H          ; B = count of action bit 0 results
        MVI     C,00H          ; C = count of action bit 1 results
        MVI     D,00H          ; D = low nibble scan index

SCAN_HIGH:
        MOV     A,H
        RLC
        RLC
        RLC
        RLC
        ANI     0F0H
        ORA     D
        CALL    SET_MMA_FROM_A
        CALL    READ_MMD
        MOV     E,A
        ANI     CONF_MASK
        CPI     CONF3
        JNZ     NEXT_HIGH

        MOV     A,E
        ANI     01H
        JZ      COUNT_ZERO
        INR     C
        JMP     NEXT_HIGH

COUNT_ZERO:
        INR     B

NEXT_HIGH:
        INR     D
        MOV     A,D
        CPI     10H
        JNZ     SCAN_HIGH

        MOV     A,B
        CMP     C
        JZ      NEXT_GROUP
        JC      MAJ_ONE

MAJ_ZERO:
        XRA     A
        JMP     APPLY_GROUP

MAJ_ONE:
        MVI     A,01H

APPLY_GROUP:
        MOV     L,A            ; L = inferred action bit 0 value
        MVI     D,00H

SCAN_LOW:
        MOV     A,H
        RLC
        RLC
        RLC
        RLC
        ANI     0F0H
        ORA     D
        CALL    SET_MMA_FROM_A
        CALL    READ_MMD
        MOV     E,A
        ANI     CONF_MASK
        JNZ     NEXT_LOW

        MOV     A,L
        ORI     CONF1
        CALL    WRITE_MMD

NEXT_LOW:
        INR     D
        MOV     A,D
        CPI     10H
        JNZ     SCAN_LOW

NEXT_GROUP:
        INR     H
        MOV     A,H
        CPI     10H
        JNZ     GROUP_LOOP

        POP     H
        POP     D
        POP     B
        RET

        END
