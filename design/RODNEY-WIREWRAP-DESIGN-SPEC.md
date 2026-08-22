# Rodney Self-Programming Core

Design spec for a new wire-wrap implementation on `Vector 8801-6` plugboards.

## Purpose

This spec defines a **bench-first** hardware build that preserves the book's actual self-programming mechanism:

- environment-indexed main memory
- Beta confidence update loop
- Gamma generalization pass

It does **not** attempt a museum-faithful chip-for-chip recreation of every 1979 board. The goal is a buildable, debuggable system that can run the same class of learning behavior on new wire-wrapped hardware.

## Scope

This design covers the minimum viable self-programming core:

- `8085A` CPU
- writable program memory
- writable main memory
- simple environment inputs
- simple action outputs
- random source
- bench I/O for bring-up
- optional expansion path to motors and sensors later

This first build is intended to validate the self-programming claim on the bench before integrating with a mobile robot chassis.

## Design Principles

- Keep the logical model from the book, even when parts change.
- Prefer parts that are still obtainable in DIP packages.
- Reduce wire-wrap risk by using fewer chips and clearer decode boundaries.
- Make the first system observable: LEDs, DIP switches, test headers, single-step-friendly reset and halt controls.
- Preserve the separation between:
  - program store
  - learned main memory
  - environment inputs
  - action outputs

## Assumptions

- We are reproducing the **behavioral architecture**, not every original schematic detail.
- The CPU remains `8085A`.
- The original `2114` and `2147` RAMs may be replaced with newer SRAM where that simplifies the build.
- The first version uses **bench environment simulation** with switches instead of motors and charger sensing.
- A later version can map the same logical ports to real sensors and actuators.

## System Architecture

## Functional Blocks

1. `CPU board`
   - `8085A`
   - clock
   - reset
   - address latch for multiplexed low address bus
   - data bus transceiver/buffering
   - expansion headers

2. `memory board`
   - program RAM
   - optional monitor/bootstrap EEPROM
   - main memory
   - decode logic

3. `I/O board`
   - `ENVL` input
   - optional `ENVH` input
   - `ACTL` output
   - optional `ACTH` output
   - random source
   - status LEDs
   - bench control inputs

## Recommended Board Partition

Use `3 x Vector 8801-6` boards.

- `Board A`: CPU and bus support
- `Board B`: memory and decode
- `Board C`: bench I/O and observability

This keeps the wire-wrap density reasonable and follows the spirit of the repo's existing split-board work.

## Logical Memory and I/O Map

Suggested initial map:

- `0000h-1FFFh` program RAM, `8 KB`
- `2000h-3FFFh` monitor/EEPROM window, optional, `8 KB`
- `4000h-7FFFh` main memory, `16 KB`
- `8000h` `ENVL`
- `8001h` `ENVH`, optional
- `8002h` random source
- `8004h` main-memory address low register
- `8005h` main-memory address high register
- `8006h` main-memory data register
- `8008h` `ACTL`
- `8009h` `ACTH`, optional

Notes:

- This is not a claim about the exact original book map.
- It is a clean memory-mapped organization that preserves the same concepts.
- If desired, the port labels can later be aliased in source to match book terminology more closely.

## Data Model

## Environment

Minimum first-pass environment:

- `ENVL`, `8 bits`
  - reserve bits for:
    - left run state
    - left stall
    - right run state
    - right stall
    - feed/contact
    - hungry or internal need
    - spare 2 bits

Optional:

- `ENVH`, `8 bits`
  - additional sensor growth

## Action

Minimum first-pass action:

- `ACTL`, `8 bits`
  - lower nibble for motion or symbolic response code
  - upper bits reserved for flags, lamps, or later actuator expansion

Optional:

- `ACTH`, `8 bits`

## Learned Main-Memory Word

Store one byte per environment state in the first system:

- lower nibble: action code
- upper 2 bits: confidence
- remaining bits: reserved

This matches the Beta/Gamma evidence well enough to prototype the learning mechanism cleanly.

## Bring-Up Strategy

Phase 1:

- build the CPU board
- prove reset, clock, address latch, and RAM execution

Phase 2:

- add bench `ENVL` switches and `ACTL` LEDs
- run Alpha/Beta routines with random source

Phase 3:

- add main-memory board and validate confidence update behavior

Phase 4:

- enable Gamma generalization pass

Phase 5:

- only after bench validation, map `ENV` and `ACT` lines to real robot electronics

## Recommended IC Choices

## CPU and bus

- `8085A` DIP-40
- `74LS373` or `74HCT373` for AD0-AD7 latch
- `74LS245` or `74HCT245` for data bus buffering
- `74LS138` for decode
- `74LS00` and `74LS04` for glue logic

Rationale:

- These are easier to source than some original parts.
- `74LS245` is a practical substitute for older bus-interface parts in a fresh build.

## Memory

- `6264` SRAM, `8 KB x 8`, for program RAM
- `62256` SRAM, `32 KB x 8`, for main memory
- `28C16` or `28C64` EEPROM for bootstrap or monitor ROM

Rationale:

- Fewer chips
- easier wire-wrap routing
- simpler power and troubleshooting

## Random source

Use one of these:

1. `74LS164` or `74HC164` pseudo-random LFSR
2. `74LS93` plus XOR feedback
3. noise source plus Schmitt trigger if later needed

Recommendation:

- start with a synchronous pseudo-random generator using TTL

## Bench I/O

- `74LS273` or `74HCT273` latch for LED output register
- DIP switch packs for `ENVL` and `ENVH`
- LED bar or discrete LEDs for `ACTL` and debug signals

## Electrical Requirements

- `+5V` logic rail, regulated
- separate bench `+12V` only if later actuator hardware is attached
- local `0.1uF` decoupler per IC
- one bulk capacitor per board, `47uF` to `470uF`
- star-ish grounding between boards
- short bus runs between board connectors where possible

## Wire-Wrap Construction Rules

- Use machine-pin wire-wrap sockets only.
- Put one `0.1uF` capacitor physically adjacent to each IC power pair.
- Reserve one edge of each board for bus ingress and egress.
- Keep the address and data buses straight and color-coded.
- Run power and ground first, then clock/reset, then bus, then decode, then local signals.
- Use heavier insulated wire for power rails and `30 AWG` Kynar for logic wraps.
- Add test posts for:
  - `CLK`
  - `RESET`
  - `/RD`
  - `/WR`
  - `ALE`
  - `IO/M`
  - `A0`
  - `A15`
  - `D0`
  - `D7`

## Bill of Materials

## Core Boards

| Item | Qty | Notes |
|---|---:|---|
| Vector `8801-6` wire-wrap plugboard | 3 | CPU, memory, I/O |
| 100-pin wire-wrap edge connector | 2 | use on `Board A` and `Board B`; hard-wire `Board C` in the stack |
| Vector wire-wrap terminals or equivalent | 300+ | optional depending on board strategy |

## CPU Board BoM

| Item | Qty | Notes |
|---|---:|---|
| `8085A` DIP-40 | 1 | CPU |
| `74LS373` or `74HCT373` DIP-20 | 1 | multiplexed address latch |
| `74LS245` or `74HCT245` DIP-20 | 1 | data bus transceiver |
| `74LS138` DIP-16 | 1 | decode |
| `74LS00` DIP-14 | 1 | glue logic |
| `74LS04` DIP-14 | 1 | invert/reset shaping |
| crystal `6.144 MHz` or `5 MHz` | 1 | choose one standard and code to it |
| crystal load capacitors `22pF` | 2 | if crystal circuit requires |
| reset pushbutton | 1 | front-edge or off-board |
| `10k` resistor | 2 | reset pull-up/pull-down as needed |
| `1uF` to `10uF` capacitor | 1 | reset timing |
| `0.1uF` ceramic capacitors | 6 | decoupling |
| `47uF` electrolytic | 1 | board bulk |
| DIP-40 wire-wrap socket | 1 | CPU |
| DIP-20 wire-wrap socket | 2 | latch, transceiver |
| DIP-16 wire-wrap socket | 1 | decoder |
| DIP-14 wire-wrap socket | 2 | glue logic |
| 0.1" male header strips | as needed | debug and board interconnect |

## Memory Board BoM

| Item | Qty | Notes |
|---|---:|---|
| `6264` SRAM DIP-28 | 1 | program RAM |
| `62256` SRAM DIP-28 | 1 | main memory |
| `28C16` or `28C64` EEPROM DIP-24/28 | 1 | optional monitor/bootstrap |
| `74LS138` DIP-16 | 1 | memory select |
| `74LS139` DIP-16 | 1 | extra decode |
| `74LS32` DIP-14 | 1 | decode glue, optional |
| `74LS00` DIP-14 | 1 | decode glue |
| `74LS273` or `74HCT273` DIP-20 | 2 | MA low/high latches if using explicit MMA registers |
| `74LS245` DIP-20 | 1 | optional data-path isolation |
| `0.1uF` ceramic capacitors | 8 | decoupling |
| `47uF` electrolytic | 1 | board bulk |
| DIP-28 wire-wrap socket | 3 | SRAM and EEPROM |
| DIP-20 wire-wrap socket | 3 | latches/buffer |
| DIP-16 wire-wrap socket | 2 | decoders |
| DIP-14 wire-wrap socket | 2 | glue |

## I/O Board BoM

| Item | Qty | Notes |
|---|---:|---|
| `74LS244` or `74HCT244` DIP-20 | 1 | input buffering |
| `74LS273` or `74HCT273` DIP-20 | 1 | output latch |
| `74LS165` or switch-direct input path | 1 | optional switch capture |
| `74LS164` or `74HC164` DIP-14 | 1 | random/LFSR basis |
| `74LS86` DIP-14 | 1 | XOR feedback for PRNG |
| DIP switch, `8-position` | 2 | `ENVL`, optional `ENVH` |
| LEDs, `5mm` | 16 | `ACTL`, debug, status |
| LED resistors `330R` | 16 | one per LED |
| momentary switches | 2 | step/test or mode control |
| `10k` resistor network or discrete | 2 | switch pull resistors |
| `0.1uF` ceramic capacitors | 6 | decoupling |
| `47uF` electrolytic | 1 | board bulk |
| DIP-20 wire-wrap socket | 2 | buffer/latch |
| DIP-14 wire-wrap socket | 2 | PRNG glue |

## Construction Materials

| Item | Qty | Notes |
|---|---:|---|
| `30 AWG` Kynar wire-wrap wire | 3 to 5 spools | use multiple colors |
| heavier hookup wire for power, `22-24 AWG` | 1 spool each | red and black minimum |
| wire-wrap tool, manual or electric | 1 | required |
| unwrap tool | 1 | required |
| temperature-controlled soldering iron | 1 | for connectors, regulators, headers |
| logic probe | 1 | highly recommended |
| oscilloscope | 1 | strongly recommended |
| bench `+5V` supply | 1 | current-limited |

## Optional Expansion BoM

These are not required for the first bench validation:

| Item | Qty | Notes |
|---|---:|---|
| `8255` PPI DIP-40 | 1 | if wider I/O is preferred over discrete logic |
| UART or serial monitor hardware | 1 | optional debug convenience |
| NVRAM or battery backup circuit | 1 | preserve learned memory |
| relay or transistor motor driver stage | later | for mobile Rodney |
| analog sensor front-end hardware | later | for richer environment bits |

## Preferred Part Strategy

- Use genuine or tested `8085A` parts.
- Use `LS` TTL where timing compatibility matters.
- Use `HCT` only where substitution is harmless and availability is better.
- Use new-old-stock or modern SRAM in DIP packages to reduce the chip count.
- Do not optimize for historical purity on the first wire-wrap pass.

## Software Expectations

The software stack should be brought up in this order:

1. RAM test and bus test
2. simple monitor or loader
3. Alpha behavior
4. Beta confidence update loop
5. Gamma generalization

The assembly should abstract hardware with symbols for:

- `ENVL`
- `ENVH`
- `ACTL`
- `ACTH`
- `TSWR`
- `MMAL`
- `MMAH`
- `MMDL`

## Risks

- Wire-wrap density around the memory board can get messy quickly.
- Clock and reset faults will masquerade as software faults.
- Using too many historical small RAM chips will multiply failure points.
- Gamma verification is behavioral, so poor observability will slow debugging.
- Bench-first validation is essential before motors or charging hardware are added.

## Acceptance Criteria

The build is successful when it can:

1. execute a RAM-resident 8085 program reliably after repeated resets
2. read bench `ENVL` inputs and drive `ACTL` LEDs
3. store learned response bytes in main memory
4. increment and decrement confidence
5. trigger Gamma on confidence transitions
6. write generalized responses back into low-confidence entries

## Recommended Next Artifacts

- board-to-board signal list
- address decode truth table
- wire-wrap placement plan per board
- symbolic 8085 hardware include file
- Gamma-oriented bench test plan

## File Placement

This spec is intentionally high-level enough to guide:

- schematic capture later
- wire-wrap placement drawings
- source code porting of Beta/Gamma routines
- purchasing and staging of parts
