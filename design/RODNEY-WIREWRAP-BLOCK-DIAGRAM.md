# Rodney Wire-Wrap Block Diagram

Block-based layout sketch for the `3 x Vector 8801-6` bench-first Rodney build.

This is intentionally coarse. It is meant to help us iterate on:

- board partitioning
- major chip grouping
- bus flow
- operator access

before we commit to exact socket coordinates.

Companion docs:

- [RODNEY-WIREWRAP-DESIGN-SPEC.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-DESIGN-SPEC.md:1)
- [RODNEY-WIREWRAP-SIGNAL-LIST.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-SIGNAL-LIST.md:1)
- [RODNEY-WIREWRAP-DECODE-TABLE.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-DECODE-TABLE.md:1)
- [RODNEY-WIREWRAP-PLACEMENT-PLAN.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-PLACEMENT-PLAN.md:1)

## Overall Stack

```text
                      Rodney Wire-Wrap Stack

         +-------------------+     +-------------------+
         |   Board A         |====>|   Board B         |
         |   CPU / Bus       |====>|   Memory / Decode |
         +-------------------+     +-------------------+
                  ||
                  || shared address / data / control
                  \/
         +-------------------+
         |   Board C         |
         |   Bench I/O       |
         +-------------------+
```

## Bus-Level Functional Diagram

```text
   +---------+    +-------------+    +-------------+    +-------------+
   | 8085A   |--->| Addr Latch  |--->| Memory Bd   |<-->| Main Memory |
   | CPU     |    | 74LS373     |    | Decode      |    | + MMA/MMD   |
   +---------+    +-------------+    +-------------+    +-------------+
        |                 |
        |                 +-------------------------------+
        |                                                 |
        v                                                 v
   +-------------+                                 +-------------+
   | Data Buffer |<------------------------------->| Bench I/O   |
   | 74LS245     |                                 | ENVL/ACTL   |
   +-------------+                                 | TSWR/LEDs   |
                                                   +-------------+
```

## Vector 8801-6 Orientation

Assumed orientation for all three boards:

```text
        Top edge
   +--------------------------------------+
   |                                      |
   |         component area               |
   |                                      |
   |                                      |
   +--------------------------------------+
   | 100-pin edge connector / backplane   |
   +--------------------------------------+
        Bottom edge
```

## Board A: CPU / Bus Board

```text
        Top edge
   +------------------------------------------------------+
   | [TP CLK] [TP ALE] [TP RD] [TP WR] [TP IO/M] [RESET]  |
   |                                                      |
   | [XTAL] [74LS04]                         [74LS138]    |
   |                                                      |
   | [74LS373]           [8085A CPU]        [74LS245]    |
   |                                                      |
   | [PWR BULK]                            [BUS HEADER]   |
   +------------------------------------------------------+
   |                edge connector / bus out              |
   +------------------------------------------------------+
        Bottom edge
```

### Board A Intent

- `8085A` stays central.
- `74LS373` stays physically close to the multiplexed low bus.
- `74LS245` sits on the shared data side.
- clock/reset parts stay away from dense LED or switch wiring.
- test points stay on the top edge for probing.

## Board B: Memory / Decode Board

```text
        Top edge
   +------------------------------------------------------+
   | [TP PRG] [TP ROM] [TP MMA-L] [TP MMA-H] [TP MMD]    |
   |                                                      |
   |                 [62256 MAIN MEMORY]                  |
   |                                                      |
   | [74LS138] [74LS139]   [MMA LATCHES]   [MMD PATH]    |
   |                                                      |
   | [6264 PROGRAM RAM]        [EEPROM / MONITOR ROM]    |
   |                                                      |
   | [PWR BULK]                            [BUS HEADER]   |
   +------------------------------------------------------+
   |                edge connector / bus in               |
   +------------------------------------------------------+
        Bottom edge
```

### Board B Intent

- decode sits between the incoming bus and the memory devices.
- `62256` is the dominant block because it holds learned state.
- `6264` and EEPROM stay lower and easier to isolate during bring-up.
- `MMA` and `MMD` blocks stay close to main memory because they are the self-programming path.

## Board C: Bench I/O Board

```text
        Top edge
   +------------------------------------------------------+
   | [TP ENVL] [TP TSWR] [TP ACTL]   [MODE/JUMPERS]      |
   |                                                      |
   | [TSWR LFSR]                         [DEBUG LEDs]     |
   |                                                      |
   | [ENVL DIP] [INPUT BUF] [OUTPUT LATCH] [ACTL LEDs]   |
   |                                                      |
   | [ENVH DIP] [LOCAL DECODE]            [ACTH LEDs]    |
   |                                                      |
   | [PWR BULK]                            [BUS HEADER]   |
   +------------------------------------------------------+
   |                edge connector / bus in               |
   +------------------------------------------------------+
        Bottom edge
```

### Board C Intent

- switches stay human-accessible.
- LEDs stay readable during debugging.
- the random source is visible and isolated from the switch area.
- decode stays local to the register functions on this board.

## Inter-Board Wiring View

```text
                      Address A0-A15
                +------------------------+
                |                        |
                v                        v
   +-------------------+         +-------------------+
   | Board A           |         | Board B           |
   | CPU / Bus         |-------->| Memory / Decode   |
   |                   |         |                   |
   | D0-D7 <---------->|---------| D0-D7             |
   | RD WR IO/M ------>|---------| control in        |
   +-------------------+         +-------------------+
                |
                | Address / Data / Control
                v
   +-------------------+
   | Board C           |
   | Bench I/O         |
   | ENVL / TSWR /     |
   | ACTL / LEDs       |
   +-------------------+
```

## Self-Programming Path

This is the path we care most about for Rodney-specific behavior:

```text
 ENVL switches/sensors
        |
        v
   +-----------+
   |  CPU      |
   | 8085A     |
   +-----------+
        |
        | choose learned-state address
        v
   +-----------+        +-----------+
   | MMA low   |------->|           |
   | MMA high  |------->| 62256     |
   +-----------+        | Main Mem  |
        ^               |           |
        |               +-----------+
        |                    |
        |                learned byte
        |                    v
        |               +-----------+
        +---------------| MMD path  |
                        +-----------+
                              |
                              v
                           ACTL LEDs
```

## Suggested Iteration Questions

Before moving to coordinates, these are the right questions to answer:

- Is `3-board` partitioning still the right split?
- Do we want the EEPROM on `Board B`, or should it move to `Board A`?
- Do we want `ENVH` populated on revision 1, or leave the footprint only?
- Do we want a direct debug header for the `MMA` and `MMD` path?
- Do we want the random source on `Board C`, or fold it into `Board B`?

## Next Step After Approval

If this block diagram feels right, the next artifact should be a **socket-level coordinate worksheet** for each board, not yet a full schematic.
