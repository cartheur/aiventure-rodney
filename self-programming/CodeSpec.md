# Revised 8085 Self-Modifying Program with LED Indicators

The Intel 8085 assembly program is modified to use the Serial Output Data (SOD) pin to control an LED, indicating when self-programming occurs. It retains the original functionality—reading an input at `2000H`, comparing it to 50, and modifying a `JMP` to point to `HIGH_ROUTINE` or `LOW_ROUTINE`—while adding `SIM` instructions to light the LED during self-modification.

## Revised Program Description
- **Purpose**: Reads an input at `2000H`. If ≥ 50, modifies a `JMP` to `HIGH_ROUTINE` (outputs ‘H’ at `2001H`). If < 50, to `LOW_ROUTINE` (outputs ‘L’).
- **Self-Modification**: Overwrites the `JMP` at `JMP_MOD` with opcode `0C3H` and the routine’s address.
- **LED Indicator**: SOD controls an LED, on (SOD low) during self-modification, off (SOD high) otherwise.
- **Changes**:
  - Initializes SOD high (LED off) at start.
  - Sets SOD low (LED on) before self-modification.
  - Sets SOD high (LED off) after self-modification.

## Key Modifications
1. **SOD Initialization**: Sets SOD high (LED off) at program start.
2. **LED On**: Sets SOD low (LED on) before modifying `JMP_MOD`.
3. **LED Off**: Sets SOD high (LED off) after modification.
4. **Unchanged Logic**: Self-modification and output logic remain identical.

## Circuit Reminder
- **LED Connection**:
  - LED anode to 5V, cathode to 330Ω–470Ω resistor, resistor to SOD (pin 4).
  - SOD low turns LED on; SOD high turns it off.
  - For brighter LEDs, use a BC548 transistor: SOD to base via 1kΩ resistor, emitter to ground, LED cathode to collector, anode to 5V via 330Ω resistor.
- **Other Connections**:
  - Ground TRAP, RST 5.5–7.5, and INTR.
  - Use a 6 MHz crystal and reset circuit (10µF capacitor, 10kΩ resistor).

## Testing
- **Setup**:
  - Use an 8085 trainer kit or emulator (e.g., GNUSim8085).
  - Set input at `2000H` (e.g., 60 or 40).
  - Connect LED to SOD.
- **Expected Behavior**:
  - LED off during input reading/comparison.
  - LED on briefly (~20–30 µs at 3 MHz) during self-modification.
  - LED off during routines.
  - `2001H` shows ‘H’ or ‘L’.
- **Visibility**: LED on-time is short; add a delay loop for better visibility if needed.
- **Debugging**:
  - Verify `SIM` instructions and SOD connections.
  - Ground interrupts.

## Notes
- **SOD Control**: `SIM` uses SOE (bit 6 = 1). Values `40H` (SOD low) and `C0H` (SOD high) control the LED.
- **Timing**: Self-modification takes ~20–30 µs; repeated runs may be needed to see LED.
- **Safety**: Check LED polarity, resistor, and clock/reset stability.