; Self-modifying code example for Intel 8085 with LED indicator
; Dynamically modifies a JMP instruction's target address based on input
; Uses SOD pin to light LED during self-modification

      ORG 0000H        ; Start at memory address 0000H

; Constants
INPUT_ADDR  EQU 2000H  ; Memory address for input value (e.g., sensor data)
OUTPUT_ADDR EQU 2001H  ; Memory address for output result
THRESHOLD   EQU 50     ; Threshold value for comparison

; Main program
START:
      MVI A, 0C0H       ; Set SOD high (LED off), SOE=1
      SIM               ; Apply SOD setting
      LXI H, INPUT_ADDR ; Load HL with address of input
      MOV A, M          ; Read input value into accumulator
      CPI THRESHOLD     ; Compare input with threshold (50)
      JC MODIFY_LOW     ; If input < 50, modify JMP to LOW_ROUTINE
      JMP MODIFY_HIGH   ; If input >= 50, modify JMP to HIGH_ROUTINE

; Modify JMP instruction to point to LOW_ROUTINE
MODIFY_LOW:
      MVI A, 40H        ; Set SOD low (LED on), SOE=1
      SIM               ; Apply SOD setting
      MVI A, 0C3H       ; Opcode for JMP
      STA JMP_MOD       ; Store at JMP instruction location
      LXI H, LOW_ROUTINE ; Load HL with address of LOW_ROUTINE
      MOV A, L          ; Low byte of address
      STA JMP_MOD+1     ; Store at JMP address low byte
      MOV A, H          ; High byte of address
      STA JMP_MOD+2     ; Store at JMP address high byte
      MVI A, 0C0H       ; Set SOD high (LED off), SOE=1
      SIM               ; Apply SOD setting
      JMP JMP_MOD       ; Execute modified JMP

; Modify JMP instruction to point to HIGH_ROUTINE
MODIFY_HIGH:
      MVI A, 40H        ; Set SOD low (LED on), SOE=1
      SIM               ; Apply SOD setting
      MVI A, 0C3H       ; Opcode for JMP
      STA JMP_MOD       ; Store at JMP instruction location
      LXI H, HIGH_ROUTINE ; Load HL with address of HIGH_ROUTINE
      MOV A, L          ; Low byte of address
      STA JMP_MOD+1     ; Store at JMP address low byte
      MOV A, H          ; High byte of address
      STA JMP_MOD+2     ; Store at JMP address high byte
      MVI A, 0C0H       ; Set SOD high (LED off), SOE=1
      SIM               ; Apply SOD setting
      JMP JMP_MOD       ; Execute modified JMP

; Placeholder for the modifiable JMP instruction
JMP_MOD:
      JMP 0000H         ; Initial JMP (will be overwritten)

; Routine for input < 50
LOW_ROUTINE:
      MVI A, 'L'        ; Simulate output "LOW" (ASCII 'L')
      STA OUTPUT_ADDR   ; Write to output address
      HLT               ; Halt

; Routine for input >= 50
HIGH_ROUTINE:
      MVI A, 'H'        ; Simulate output "HIGH" (ASCII 'H')
      STA OUTPUT_ADDR   ; Write to output address
      HLT               ; Halt

      END