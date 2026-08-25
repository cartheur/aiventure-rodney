; Rodney support ROM skeleton for a first-pass 6809 redesign
;
; Purpose:
; - provide reset entry via 6809 vectors
; - initialize visible outputs and learned-memory indirect registers
; - verify that a RAM runtime exists
; - expose stable ROM-callable primitives for ENVL, TSWR, ACTL, MMA, and MMD
;
; This file is intentionally conservative:
; - it mirrors the current 8085 support-ROM contract
; - it does not yet assume 6309-only instructions
; - it leaves exact assembler syntax details to the chosen 6809 toolchain
;
; Suggested ROM placement:
; - ROM body in $E000-$FFFF
; - vectors at the top of memory

        ORG     $0000

; ----------------------------------------------------------------------
; Logical memory and I/O contract
; ----------------------------------------------------------------------

PRG_RAM_ENTRY    EQU     $0100
STACK_TOP        EQU     $1FF0

ENVL             EQU     $8000
ENVH             EQU     $8001
TSWR             EQU     $8002
MMA_L            EQU     $8004
MMA_H            EQU     $8005
MMD              EQU     $8006
ACTL             EQU     $8008
ACTH             EQU     $8009

ROM_BASE         EQU     $E000

; Stable service entry points
READ_ENVL        EQU     $E020
READ_ENVH        EQU     $E024
READ_TSWR        EQU     $E028
WRITE_ACTL       EQU     $E02E
WRITE_ACTH       EQU     $E032
SET_MMA_FROM_A   EQU     $E036
SET_MMA_FROM_X   EQU     $E040
READ_MMD         EQU     $E04C
WRITE_MMD        EQU     $E050
CLEAR_LEARNED_256 EQU    $E054
VERIFY_RUNTIME   EQU     $E068
DELAY_SHORT      EQU     $E078
FAIL_MONITOR     EQU     $E084

        ORG     ROM_BASE

ROM_ENTRY:
        LDS     #STACK_TOP
        JSR     ROM_INIT
        JSR     VERIFY_RUNTIME
        BEQ     FAIL_MONITOR
        JMP     PRG_RAM_ENTRY

ROM_INIT:
        CLRA
        STA     ACTL
        STA     ACTH
        STA     MMA_L
        STA     MMA_H
        RTS

; ----------------------------------------------------------------------
; ROM utility API
; ----------------------------------------------------------------------

        ORG     READ_ENVL
READ_ENVL_IMPL:
        LDA     ENVL
        RTS

        ORG     READ_ENVH
READ_ENVH_IMPL:
        LDA     ENVH
        RTS

        ORG     READ_TSWR
READ_TSWR_IMPL:
        LDA     TSWR
        ANDA    #$0F
        RTS

        ORG     WRITE_ACTL
WRITE_ACTL_IMPL:
        STA     ACTL
        RTS

        ORG     WRITE_ACTH
WRITE_ACTH_IMPL:
        STA     ACTH
        RTS

        ORG     SET_MMA_FROM_A
SET_MMA_FROM_A_IMPL:
        STA     MMA_L
        CLRA
        STA     MMA_H
        RTS

        ORG     SET_MMA_FROM_X
SET_MMA_FROM_X_IMPL:
        STX     MMA_L
        RTS

        ORG     READ_MMD
READ_MMD_IMPL:
        LDA     MMD
        RTS

        ORG     WRITE_MMD
WRITE_MMD_IMPL:
        STA     MMD
        RTS

; Clear the 256-entry ENVL-indexed learned table used by the first-pass
; Beta runtime. This assumes the learned-memory indirect path interprets
; MMA_H:MMA_L as the learned-state address and MMD as the data register.
        ORG     CLEAR_LEARNED_256
CLEAR_LEARNED_256_IMPL:
        CLRA
        STA     MMA_H
        CLRB
CL256_LOOP:
        STB     MMA_L
        CLRA
        STA     MMD
        INCB
        BNE     CL256_LOOP
        RTS

; Minimal runtime check:
; verify that program RAM is not blank. This is intentionally weaker than
; the current 8085 opcode check because the exact first instruction stream
; will change during the port.
        ORG     VERIFY_RUNTIME
VERIFY_RUNTIME_IMPL:
        LDA     PRG_RAM_ENTRY
        BEQ     VERIFY_FAIL
        CMPA    #$FF
        BEQ     VERIFY_FAIL
        CLRA
        RTS

VERIFY_FAIL:
        LDA     #$01
        RTS

        ORG     DELAY_SHORT
DELAY_SHORT_IMPL:
        LDX     #$0FFF
DS_LOOP:
        LEAX    -1,X
        BNE     DS_LOOP
        RTS

        ORG     FAIL_MONITOR
FAIL_MONITOR_IMPL:
        LDA     #$0F
        JSR     WRITE_ACTL
        JSR     DELAY_SHORT
        CLRA
        JSR     WRITE_ACTL
        JSR     DELAY_SHORT
        BRA     FAIL_MONITOR_IMPL

; ----------------------------------------------------------------------
; Vectors
; ----------------------------------------------------------------------

        ORG     $FFF0
        FDB     0              ; reserved
        FDB     0              ; SWI3
        FDB     0              ; SWI2
        FDB     0              ; FIRQ
        FDB     0              ; IRQ
        FDB     0              ; SWI
        FDB     0              ; NMI
        FDB     ROM_ENTRY      ; RESET

        END
