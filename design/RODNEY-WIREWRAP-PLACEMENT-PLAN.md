# Rodney Wire-Wrap Placement Plan

Suggested physical placement plan for a `3-board Vector 8801-6` wire-wrap Rodney core.

Board dimensions come from [design/README.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/README.md:1): `10.5" x 5.3"` `Vector 8801-6`.

This plan is meant to reduce wrap density and make probing practical. It is not a photographic reconstruction of the original Rodney boards.

## Orientation Convention

For each board in this document:

- `edge connector` is at the bottom
- `top` means the board edge opposite the connector
- `left` and `right` are as viewed from the component side

## Rack Order

Recommended left-to-right or front-to-back logical order:

1. `Board A` CPU
2. `Board B` memory
3. `Board C` I/O

Reason:

- CPU sits centrally in the logical design.
- Memory gets shortest heavy bus usage.
- I/O board stays accessible for switches, LEDs, and observation.

## Global Placement Rules

- Put bus-facing devices nearest the connector side.
- Put human-facing devices nearest the outer edges.
- Keep oscillators and reset circuitry away from dense LED wiring.
- Put decoders near the middle of the board, not at the extremes.
- Reserve one full vertical lane on each board for power distribution.
- Reserve one header strip per board for debug posts.

## Board A: CPU and Bus Support

## Primary Functions

- `8085A`
- address latch
- bus transceiver
- reset
- clock
- bus export headers

## Recommended Zones

### Bottom zone, near edge connector

- board interconnect headers
- power entry
- main bus breakout points

Reason:

- shortest path from connector to bus spine

### Center zone

- `8085A`

Reason:

- centralizes fan-out to address, data, and control lines

### Upper-left zone

- `74LS373` address latch

Reason:

- very short runs from `AD0-AD7` and `ALE`

### Upper-right zone

- `74LS245`
- `74LS138`

Reason:

- keeps bus and coarse decode grouped

### Far-right or top edge

- crystal
- load capacitors
- `74LS04` clock/reset glue
- reset pushbutton

Reason:

- keep oscillator physically separate from wider bus bundles and LED noise

### Top edge

- test posts for:
  - `CLK`
  - `ALE`
  - `/RD`
  - `/WR`
  - `IO/M`
  - `/RESET_OUT`

## Board A Placement Sketch

```text
Top
+--------------------------------------------------+
| TP TP TP TP TP TP   XTAL RESET   74LS04         |
|                                                  |
| 74LS373                8085A             74LS245 |
|                                                  |
|                           74LS138               |
|                                                  |
| PWR lane                            BUS headers  |
|                                                  |
| Edge connector / board-to-board breakout         |
+--------------------------------------------------+
Bottom
```

## Board B: Memory and Decode

## Primary Functions

- program RAM
- EEPROM
- main memory
- MMA low latch
- MMA high latch
- MMD path
- memory decode

## Recommended Zones

### Bottom zone

- incoming bus header from `Board A`
- outgoing service header if needed

### Center-left

- `6264` program RAM

### Center-right

- EEPROM / monitor ROM

### Upper center

- `62256` main memory

Reason:

- main memory is the board’s focal device and should get the clearest routing

### Left-middle

- `74LS138` and `74LS139`

Reason:

- decode should sit between bus ingress and the controlled devices

### Right-middle

- `MMA low` and `MMA high` latches
- optional MMD gating transceiver or latch

Reason:

- these form the indirect access path to main memory and should sit close to the `62256`

### Top edge

- test posts:
  - `/PRG_RAM_CS`
  - `/ROM_CS`
  - `/MMA_L_CS`
  - `/MMA_H_CS`
  - `/MMD_CS`
  - `MMA0`
  - `MMA8`
  - `D0`

## Board B Placement Sketch

```text
Top
+--------------------------------------------------+
| TP TP TP TP TP TP TP TP                          |
|                                                  |
|                  62256 MAIN MEMORY               |
|                                                  |
| 74LS138 74LS139     MMA L/H      MMD GATE        |
|                                                  |
| 6264 PROGRAM RAM           EEPROM / MONITOR      |
|                                                  |
| PWR lane                            BUS lane      |
|                                                  |
| Edge connector / bus in                          |
+--------------------------------------------------+
Bottom
```

## Board C: Bench I/O and Observability

## Primary Functions

- `ENVL` switch input
- optional `ENVH` switch input
- `TSWR` pseudo-random source
- `ACTL` LED output
- optional `ACTH`
- bench status indicators

## Recommended Zones

### Bottom zone

- bus ingress from `Board A`
- decode header

### Left side

- DIP switch packs for `ENVL`
- optional second pack for `ENVH`

Reason:

- easy operator access

### Center

- input buffer
- output latch
- local decode

### Right side

- LED row for `ACTL`
- second LED row for debug or `ACTH`

Reason:

- direct visual observation during Beta/Gamma runs

### Upper center

- `TSWR` pseudo-random source

Reason:

- keeps it distinct from manual switch inputs

### Top edge

- debug posts
- optional mode jumpers

## Board C Placement Sketch

```text
Top
+--------------------------------------------------+
| TP TP TP TP      TSWR / LFSR        MODE JUMPERS |
|                                                  |
| ENVL SW1      INPUT BUF   OUTPUT LATCH   ACTL LEDs|
|                                                  |
| ENVH SW2      LOCAL DECODE              DBG LEDs |
|                                                  |
| PWR lane                            BUS lane      |
|                                                  |
| Edge connector / bus in                          |
+--------------------------------------------------+
Bottom
```

## Power Routing Plan

On every board:

- one vertical `+5V` rail lane
- one vertical `GND` rail lane
- local decoupling at every IC
- one bulk capacitor close to power entry

Preferred color convention:

- red: `+5V`
- black: `GND`
- blue: data bus
- yellow: address bus
- green: control
- white: local board signals

## Wrap Density Guidance

## Board A

Highest-risk areas:

- around `8085A`
- around `74LS373`
- around `74LS245`

Mitigation:

- orient `74LS373` and `74LS245` so their bus-side pins face the CPU
- keep decode outputs pointed away from the bus spine

## Board B

Highest-risk areas:

- `62256` plus `MMA` latches
- decode fan-out

Mitigation:

- place `MMA` latches directly adjacent to the main-memory address side
- keep program RAM and EEPROM on the opposite side of the board from `MMD` path logic

## Board C

Highest-risk areas:

- LED resistor wiring
- switch pull networks

Mitigation:

- use resistor networks where possible
- keep LED wiring to one edge to avoid crossing the data bus repeatedly

## Serviceability Rules

- leave at least one empty hole row between major DIP packages where practical
- place all sockets in the same orientation per board unless routing strongly argues otherwise
- never bury reset or clock parts under dense wrap bundles
- leave enough space near test points for clip probes

## Suggested Build Sequence By Board

### Board A

1. sockets
2. power and ground
3. reset and clock
4. CPU-to-latch wiring
5. CPU-to-transceiver wiring
6. export bus headers

### Board B

1. sockets
2. power and ground
3. decode
4. program RAM and ROM
5. MMA latches
6. main memory path

### Board C

1. sockets
2. power and ground
3. input switches
4. output LEDs
5. random source
6. local decode

## Mechanical Fit Notes

Using the repo’s rack assumptions:

- allow generous side access for wrap tool rotation
- keep the I/O board on the most accessible side of the rack
- avoid placing frequently changed jumpers toward the rack interior

## Recommended Next Step

Translate this plan into a per-board hole-grid worksheet before starting wrap. A simple coordinate sheet with socket origins will prevent a lot of rework.
