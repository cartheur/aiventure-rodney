# Building an 8085 Trainer Kit for the Self-Modifying Code

This guide details how to build a minimal 8085 trainer kit to deploy the self-modifying 8085 assembly code, which modifies a `JMP` instruction and uses an LED on the SOD pin to indicate self-programming. The trainer supports program execution at `0000H`, memory-mapped I/O at `2000H` (input) and `2001H` (output), and debugging, using common components for educational use.

## Step 1: Gather Components
The trainer requires components for the microprocessor, memory, clock, reset, I/O, and debugging.

### Components
1. **Microprocessor**: Intel 8085A (40-pin DIP).
2. **Memory**:
   - 6264 SRAM (8 KB, 28-pin DIP) for program and I/O.
   - Optional 2764 EPROM (8 KB) for permanent storage.
3. **Clock**: 6 MHz crystal, two 22 pF capacitors.
4. **Reset**: 10 µF capacitor, 10 kΩ resistor, push-button switch.
5. **LED Indicator**: LED, 330Ω–470Ω resistor, optional BC548 transistor, 1 kΩ resistor.
6. **I/O**:
   - 8-bit DIP switch or ADC0804 with potentiometer for `2000H`.
   - Output at `2001H` via RAM.
   - Optional 7-segment display/LCD (requires 8255 PPI).
7. **Debugging**: MAX232, DB9 for serial; optional LCD/7-segment.
8. **Breadboard/PCB**: Prototyping board, 40/28-pin sockets, jumper wires, soldering kit.
9. **Power**: 5V (7805 regulator, 9V input), 100 µF/0.1 µF capacitors.
10. **Miscellaneous**: 74LS373 (latch), 74LS138 (decoder), 10 kΩ resistors, logic probe.

### Sourcing Notes
- Available from DigiKey, Mouser, or eBay (vintage ICs).
- Cost: $50–$100.
- Substitutes: 80C85, 62256 RAM.

## Step 2: Design the Circuit
The circuit integrates the 8085 with memory, I/O, and SOD LED, ensuring code compatibility.

### 1. 8085 Connections
- **Power**: Vcc (pin 40) to 5V, Vss (pin 20) to ground, 0.1 µF capacitor.
- **Clock**: 6 MHz crystal between X1/X2 (pins 1–2), 22 pF capacitors to ground.
- **Reset**: RESET IN (pin 36) to 5V via 10 µF, ground via 10 kΩ, push-button.
- **Interrupts**: Ground TRAP (pin 6), RST 5.5–7.5 (pins 7–9), INTR (pin 12) via 10 kΩ.
- **SOD LED**: SOD (pin 4) to 330Ω resistor, to LED cathode, anode to 5V. SOD low = LED on.
- **Alternative**: SOD to BC548 base via 1 kΩ, emitter to ground, collector to LED cathode.

### 2. Address/Data Demultiplexing
- **74LS373**:
  - D0–D7 to AD0–AD7 (pins 12–19), Q0–Q7 to A0–A7, G to ALE (pin 30), OE to ground.
  - A8–A15 (pins 21–28) to memory.

### 3. Memory
- **6264 SRAM**:
  - A0–A12 to A0–A12 (A0–A7 from 74LS373, A8–A12 from 8085), D0–D7 to AD0–AD7.
  - OE to RD (pin 32), WE to WR (pin 31), CS via 74LS138.
  - Vcc to 5V, 0.1 µF capacitor.

### 4. Decoding
- **74LS138**:
  - A, B, C to A13–A15 (pins 26–28), G1 to IO/M (pin 34, inverted), G2A/G2B to ground.
  - Y0 to 6264 CS (`0000H`–`1FFFH`, includes `2000H`–`2001H`).

### 5. I/O
- **Input**: DIP switch to D0–D7, enabled at `2000H` (74LS138 Y1 or NAND gate). Alternative: ADC0804 with potentiometer.
- **Output**: Handled by RAM at `2001H`.

### 6. Serial Interface
- **MAX232**: SOD (buffered) to T1IN, SID (pin 5) to R1OUT, DB9 for PC. 1 µF capacitors.

### 7. Power
- **7805**: 9–12V input, 5V output, 100 µF/0.1 µF capacitors.

## Step 3: Assemble the Trainer
1. Install IC sockets (40-pin for 8085, 28-pin for 6264).
2. Wire power/ground rails, add decoupling capacitors.
3. Connect 8085 clock, reset, interrupts, SOD LED.
4. Wire 74LS373 for demultiplexing.
5. Connect 6264 RAM.
6. Wire 74LS138 for decoding.
7. Add DIP switch for input.
8. Connect MAX232 for serial.
9. Wire 7805 power supply.
10. Solder or secure connections, verify with multimeter.

## Step 4: Test the Trainer
1. **Power-On**: Check 5V, 3 MHz at CLK OUT (pin 37).
2. **Reset**: Press button, verify RESET OUT (pin 3).
3. **Memory**: Write/read `0000H`, `2000H`.
4. **SOD LED**: Test with `MVI A, 40H; SIM` (on), `C0H` (off).
5. **Serial**: Send/receive test byte via PC.
6. **Debug**: Check connections, IC orientation, clock.

## Step 5: Deploy the Code
1. Assemble `selfmod.asm` to `selfmod.hex` (e.g., A85).
2. Load via:
   - Monitor program (serial upload to RAM).
   - Manual entry (keypad).
   - EPROM (burn to 2764).
3. Set `2000H` to 60 or 40 (DIP switch or monitor).
4. Reset, run (`G 0000`).
5. Observe LED flicker during self-modification, check `2001H` (‘H’/’L’).

## Step 6: Finalize and Debug
- Add monitor program in EPROM (`8000H`–`FFFFH`).
- Optional: 7-segment/LCD via 8255.
- Debug: Check reset, clock, RAM CS, SOD, interrupts.
- Document: Label ICs, keep schematic/listing.

### Notes
- **Minimal Design**: Omits advanced peripherals for simplicity.
- **LED Timing**: Add delay loop for visibility.
- **Safety**: Verify pin assignments, LED polarity, power stability.
- **Resources**: 8085, 6264, 2764 datasheets; trainer manuals.