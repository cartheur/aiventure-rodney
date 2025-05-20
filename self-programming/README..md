# Modified 8085 Self-Modifying Program with LED Indicators

To indicate when the 8085 assembly program performs self-programming, the original example is modified to use the Serial Output Data (SOD) pin to control an LED, lighting it during the self-modification process. This leverages the 8085’s serial output, aligns with the program’s purpose, and highlights risks Intel cautioned against, such as unpredictability and debugging challenges.

## Original Program Recap
The original program:
- Reads an input value at `2000H` (e.g., sensor data).
- Compares it to a threshold (50).
- Modifies a `JMP` instruction at `JMP_MOD` to point to `HIGH_ROUTINE` (input ≥ 50) or `LOW_ROUTINE` (input < 50).
- Executes the modified `JMP` to output ‘H’ or ‘L’ at `2001H`.

Self-modification occurs in the `MODIFY_LOW` and `MODIFY_HIGH` routines, writing the `JMP` opcode (`0C3H`) and a 16-bit address to `JMP_MOD`, `JMP_MOD+1`, and `JMP_MOD+2`.

## Modification Goals
- **Indicate Self-Programming**: Light an LED during `MODIFY_LOW` or `MODIFY_HIGH` to signal self-modification.
- **Circuit Design**: Use the 8085’s SOD pin (pin 4) to drive the LED.
- **Program Changes**: Add `SIM` instructions to control SOD, setting the LED on before and off after self-modification.

## Circuit Design
The SOD pin drives an LED to indicate self-programming, a common approach for 8085 LED interfacing.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)

### Components
- **LED1**: Signals self-programming (on during modification).
- **Resistor**: 330Ω–470Ω current-limiting resistor.
- **8085 Microprocessor**: Provides SOD output.
- **5V Power Supply**: Powers the circuit.
- **Optional Transistor**: BC548 or 2N3904 for brighter LEDs if needed.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)[](https://www.circuitstoday.com/blinking-led-using-8051)

### Circuit Connections
1. **SOD Pin to LED**:
   - LED anode to 5V, cathode to a 330Ω–470Ω resistor, resistor to SOD (pin 4).
   - **Logic**: SOD low (via `SIM`) turns the LED on (current sinks to SOD); SOD high turns it off.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)
2. **Alternative (with Transistor)**:
   - SOD to transistor base via 1kΩ resistor, emitter to ground, LED cathode to collector, anode to 5V via 330Ω resistor.
   - **Logic**: SOD high turns the LED on; SOD low turns it off.
3. **Grounding Unused Pins**:
   - Tie TRAP, RST 5.5–7.5, and INTR to ground to prevent interrupts.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)
4. **Clock and Reset**:
   - 6 MHz crystal across X1/X2 (pins 1–2) with 22pF capacitors.
   - Reset circuit: 10µF capacitor to 5V, 10kΩ resistor to ground at RESET IN (pin 36).

### Notes
- **SOD Current**: Sinks ~1–2mA, sufficient for standard LEDs. Use a transistor for brighter LEDs.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)
- **Single LED**: One LED indicates all self-modification. Multiple LEDs require an 8255 PPI, adding complexity.[](https://www.tutorialspoint.com/8085-program-to-perform-on-off-desired-output-leds-connected-at-the-output-port-b)[](https://technobyte.org/8085-8255-interfacing-tutorial/)
- **Safety**: Verify LED polarity and resistor to protect SOD.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)

## Program Modifications
The program is updated to:
- Set SOD high (LED off) at the start.
- Set SOD low (LED on) before self-modification in `MODIFY_LOW` or `MODIFY_HIGH`.
- Set SOD high (LED off) after modification, before the modified `JMP`.
- Use `SIM` with bit 7 (SOD value) and bit 6 (SOE = 1) for control.

### Key Changes
1. **Initialize SOD**: Set SOD high (LED off) at program start.
2. **LED On**: Set SOD low (LED on) before modifying `JMP_MOD`.
3. **LED Off**: Set SOD high (LED off) after modification.
4. **Preserve Functionality**: Core self-modification and output logic unchanged.

## How It Indicates Self-Programming
- **LED Behavior**:
  - **Off**: During input reading/comparison.
  - **On**: During self-modification (`MODIFY_LOW` or `MODIFY_HIGH`).
  - **Off**: During `HIGH_ROUTINE` or `LOW_ROUTINE`.
- **Visual Cue**: The LED lights briefly (~20–30 µs at 3 MHz), indicating the risky self-modification phase.
- **Risk Highlight**: The flicker underscores fetch-execute timing issues.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)

## Why This Addresses Intel’s Concerns
- **Visibility**: The LED highlights self-modification’s transient nature, aligning with Intel’s warnings.
- **Minimal Hardware**: SOD usage keeps the circuit simple, emphasizing reliability.
- **Educational Value**: Makes self-modification explicit, aiding learning.

## Testing the Circuit
- **Setup**:
  - Use an 8085 trainer kit or emulator (e.g., GNUSim8085).[](https://github.com/ashwek/8085)[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)
  - Set input at `2000H` (e.g., 60 or 40).
  - Connect the LED to SOD.
- **Observation**:
  - LED lights during self-modification, then turns off.
  - Verify `2001H` for ‘H’ or ‘L’.
- **Debugging**:
  - Check `SIM` instructions and SOD connections if the LED misbehaves.
  - Ground interrupts to avoid disruptions.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)
- **Timing**: Add a delay loop for longer LED visibility if needed.

### Notes
- **SOD Limitation**: One LED due to single SOD output.[](https://technobyte.org/8085-8255-interfacing-tutorial/)
- **Brightness**: Use a transistor for brighter LEDs.[](https://forum.allaboutcircuits.com/threads/8085-sod-light-a-led-assembly-language-code-question-resolved.191591/)
- **Emulator**: SOD may be visualized in simulators.[](https://github.com/ashwek/8085)
- **Safety**: Ensure stable clock/reset circuits.[](https://tomnisbet.github.io/Simple8085/docs/build)