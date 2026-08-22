; Rodney support ROM for the bench-first wire-wrap build
;
; Purpose:
; - provide reset entry
; - initialize visible outputs and MMA registers
; - verify that a RAM-resident Beta seed exists
; - expose stable ROM-callable primitives for ENVL, TSWR, ACTL, MMA, and MMD
;
; Important:
; - the self-programming behavior itself remains RAM-resident by design
; - this ROM is intended to support that behavior, not replace it
;
; Hardware note:
; - this file assumes a reset overlay or tiny bootstrap mechanism that
;   allows address 0000H to vector to ROM_ENTRY at 2000H
; - the main ROM body is assembled at 2000H

        ORG     0000H
        JMP     ROM_ENTRY

; Memory map from the wire-wrap design spec
PRG_RAM_ENTRY    EQU     0100H
STACK_TOP        EQU     1FF0H

ENVL             EQU     8000H
ENVH             EQU     8001H
TSWR             EQU     8002H
MMA_L            EQU     8004H
MMA_H            EQU     8005H
MMD              EQU     8006H
ACTL             EQU     8008H
ACTH             EQU     8009H

        ORG     2000H
ROM_ENTRY:
        LXI     SP,STACK_TOP
        CALL    ROM_INIT
        CALL    VERIFY_RUNTIME
        JZ      FAIL_MONITOR
        JMP     PRG_RAM_ENTRY

        ORG     2010H
ROM_INIT:
        XRA     A
        STA     ACTL
        STA     ACTH
        STA     MMA_L
        STA     MMA_H
        RET

; ----------------------------------------------------------------------
; ROM utility API
; These entry points are intended to remain stable so RAM code can CALL
; them directly.
; ----------------------------------------------------------------------

        ORG     2020H
READ_ENVL:
        LDA     ENVL
        RET

        ORG     2024H
READ_ENVH:
        LDA     ENVH
        RET

        ORG     2028H
READ_TSWR:
        LDA     TSWR
        ANI     0FH
        RET

        ORG     202EH
WRITE_ACTL:
        STA     ACTL
        RET

        ORG     2032H
WRITE_ACTH:
        STA     ACTH
        RET

        ORG     2036H
SET_MMA_FROM_A:
        STA     MMA_L
        XRA     A
        STA     MMA_H
        RET

        ORG     2040H
SET_MMA_FROM_HL:
        MOV     A,L
        STA     MMA_L
        MOV     A,H
        STA     MMA_H
        RET

        ORG     204CH
READ_MMD:
        LDA     MMD
        RET

        ORG     2050H
WRITE_MMD:
        STA     MMD
        RET

; Clear the 256-entry low-memory learned table used by the first-pass
; ENVL-only Beta seed. This is intentionally separate from ROM_ENTRY so
; learned state is preserved across normal resets unless the caller asks
; to wipe it.
        ORG     2054H
CLEAR_LEARNED_256:
        XRA     A
        STA     MMA_H
        MVI     C,00H
CL256_LOOP:
        MOV     A,C
        STA     MMA_L
        XRA     A
        STA     MMD
        INR     C
        JNZ     CL256_LOOP
        RET

; Very small runtime check:
; the seed program begins with two CALL instructions in sequence.
        ORG     2068H
VERIFY_RUNTIME:
        LDA     PRG_RAM_ENTRY
        CPI     0CDH
        RNZ
        LDA     PRG_RAM_ENTRY+3
        CPI     0CDH
        RET

        ORG     2078H
DELAY_SHORT:
        LXI     B,0FFFH
DS_LOOP:
        DCX     B
        MOV     A,B
        ORA     C
        JNZ     DS_LOOP
        RET

        ORG     2084H
FAIL_MONITOR:
        MVI     A,0FH
        CALL    WRITE_ACTL
        CALL    DELAY_SHORT
        XRA     A
        CALL    WRITE_ACTL
        CALL    DELAY_SHORT
        JMP     FAIL_MONITOR

        END
