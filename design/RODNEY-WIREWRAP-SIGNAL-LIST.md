# Rodney Wire-Wrap Signal List

Board-to-board signal list for the `3 x Vector 8801-6` bench-first Rodney self-programming core.

Companion to:

- [RODNEY-WIREWRAP-DESIGN-SPEC.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-DESIGN-SPEC.md:1)
- [RODNEY-WIREWRAP-DECODE-TABLE.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-DECODE-TABLE.md:1)
- [RODNEY-WIREWRAP-PLACEMENT-PLAN.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-PLACEMENT-PLAN.md:1)

## Board Names

- `Board A`: CPU and bus support
- `Board B`: memory and decode
- `Board C`: bench I/O and observability

## Naming Convention

- `Axx` means address line
- `Dxx` means data line
- leading `/` means active-low
- `MMA` means main-memory address register path
- `MMD` means main-memory data path

## Interconnect Philosophy

- `Board A` is the bus source.
- `Board B` is the primary bus consumer for memory.
- `Board C` is the bus consumer for memory-mapped I/O.
- Keep all bus lines straight-through and avoid unnecessary daisy-chained detours.
- Route from `Board A` to `Board B` first, then to `Board C`, unless physical rack placement makes `A -> C -> B` materially shorter.

## System Buses

## Address Bus

These are the de-multiplexed, stable address lines after the `74LS373` latch on `Board A`.

| Signal | Source | Destinations | Notes |
|---|---|---|---|
| `A0` | Board A | Board B, Board C | latched low address |
| `A1` | Board A | Board B, Board C | |
| `A2` | Board A | Board B, Board C | |
| `A3` | Board A | Board B, Board C | |
| `A4` | Board A | Board B, Board C | |
| `A5` | Board A | Board B, Board C | |
| `A6` | Board A | Board B, Board C | |
| `A7` | Board A | Board B, Board C | |
| `A8` | Board A | Board B, Board C | direct from 8085 |
| `A9` | Board A | Board B, Board C | |
| `A10` | Board A | Board B, Board C | |
| `A11` | Board A | Board B, Board C | |
| `A12` | Board A | Board B, Board C | |
| `A13` | Board A | Board B, Board C | |
| `A14` | Board A | Board B, Board C | |
| `A15` | Board A | Board B, Board C | |

## Data Bus

| Signal | Source | Destinations | Notes |
|---|---|---|---|
| `D0` | shared | Board B, Board C | keep stub short |
| `D1` | shared | Board B, Board C | |
| `D2` | shared | Board B, Board C | |
| `D3` | shared | Board B, Board C | |
| `D4` | shared | Board B, Board C | |
| `D5` | shared | Board B, Board C | |
| `D6` | shared | Board B, Board C | |
| `D7` | shared | Board B, Board C | |

## CPU Control Signals

| Signal | Source | Destinations | Notes |
|---|---|---|---|
| `ALE` | Board A | Board A local, Board B optional test | usually only local, but export to test post |
| `/RD` | Board A | Board B, Board C | memory and I/O reads |
| `/WR` | Board A | Board B, Board C | memory and I/O writes |
| `IO/M` | Board A | Board B, Board C | decode qualifier |
| `/RESET_OUT` | Board A | Board B, Board C | fan out to reset tables/latches |
| `CLK` | Board A | Board B optional, Board C optional | only if synchronous logic on remote boards needs it |
| `READY` | Board A | local | optional export if wait-state logic later added |
| `HOLD` | local tie | local | not exported in first build |
| `HLDA` | Board A | test post only | optional |

## Power and Ground

| Signal | Source | Destinations | Notes |
|---|---|---|---|
| `+5V` | power entry | Boards A, B, C | heavier gauge wire |
| `GND` | power entry | Boards A, B, C | multiple returns preferred |
| `+12V` optional | future | Board C / actuator stage | not required for bench-first logic |

## Board A Local Signals

These do not need to leave `Board A` except to test posts.

| Signal | Purpose |
|---|---|
| `AD0-AD7` | raw multiplexed 8085 low address/data bus |
| `CLK_INT` | oscillator output |
| `RESET_RC` | reset timing node |
| `LATCH_EN` | same function as `ALE`, local reference |

## Board B Interface

## Memory Devices

| Logical Function | Suggested Device | Bus Signals |
|---|---|---|
| program RAM | `6264` | `A0-A12`, `D0-D7`, `/PRG_RAM_CS`, `/RD`, `/WR` |
| EEPROM/monitor | `28C16` or `28C64` | `A0-A12`, `D0-D7`, `/ROM_CS`, `/RD`, `/WR` optional |
| main memory | `62256` | CPU-visible via `MMA` and `MMD` register path, not directly linear CPU map unless desired |

## Board B Internal Control Signals

| Signal | Source | Destination | Notes |
|---|---|---|---|
| `/PRG_RAM_CS` | Board B decode | 6264 | `0000h-1FFFh` |
| `/ROM_CS` | Board B decode | EEPROM | `2000h-3FFFh` |
| `/MMA_L_CS` | Board B decode | MMA low latch | `8004h` |
| `/MMA_H_CS` | Board B decode | MMA high latch | `8005h` |
| `/MMD_CS` | Board B decode | MMD data register / main memory data path | `8006h` |
| `/MAIN_RAM_CS` | Board B local | 62256 | generated from MMA path, not CPU address bus directly |
| `MMA0-MMA7` | MMA low latch | 62256 address | lower learned-state address |
| `MMA8-MMA15` | MMA high latch | 62256 address | upper learned-state address |

## Board B Main-Memory Path

Recommended implementation:

- CPU writes `8004h` to load `MMA low`
- CPU writes `8005h` to load `MMA high`
- CPU reads or writes `8006h` to access the byte at `main_memory[MMA]`

Signal detail:

| Signal | Source | Destination | Notes |
|---|---|---|---|
| `MMA_L[7:0]` | low latch | main memory address lines `A0-A7` | |
| `MMA_H[7:0]` | high latch | main memory address lines `A8-A15` | upper unused bits may be tied or reserved |
| `MMD_IN[7:0]` | CPU data bus | 62256 data path during write | |
| `MMD_OUT[7:0]` | 62256 data path | CPU data bus during read | |
| `/MMD_READ_GATE` | decode + `/RD` | data path enable | |
| `/MMD_WRITE_GATE` | decode + `/WR` | data path write enable | |

## Board C Interface

## I/O Registers

| Logical Function | Address | Direction |
|---|---|---|
| `ENVL` | `8000h` | read |
| `ENVH` optional | `8001h` | read |
| `TSWR` pseudo-random source | `8002h` | read |
| `ACTL` | `8008h` | write |
| `ACTH` optional | `8009h` | write |

## Board C Internal Control Signals

| Signal | Source | Destination | Notes |
|---|---|---|---|
| `/ENVL_CS` | Board C decode | input buffer or switch read path | |
| `/ENVH_CS` | Board C decode | optional second input port | |
| `/TSWR_CS` | Board C decode | LFSR/random source | |
| `/ACTL_CS` | Board C decode | output latch | |
| `/ACTH_CS` | Board C decode | optional output latch | |

## Recommended ENVL Bit Assignment

Bench-first assignment:

| Bit | Name | Meaning |
|---:|---|---|
| `D0` | `LMR` | left motor reverse or symbolic action feedback |
| `D1` | `LMF` | left motor forward or left run status |
| `D2` | `RMR` | right motor reverse or symbolic action feedback |
| `D3` | `RMF` | right motor forward or right run status |
| `D4` | `LSTALL` | left-side fault or stall |
| `D5` | `RSTALL` | right-side fault or stall |
| `D6` | `FEED` | charge/feed/contact |
| `D7` | `HUNGRY` or spare | internal need bit or spare |

This keeps later Beta/Gamma mapping close to the book’s naming scheme without forcing exact original hardware.

## Recommended ACTL Bit Assignment

| Bit | Name | Meaning |
|---:|---|---|
| `D0-D3` | action nibble | primary learned response code |
| `D4-D5` | confidence passthrough or debug | optional LED mirror |
| `D6-D7` | spare | future actuator or debug use |

## Cross-Board Cable Groups

## Group 1: main bus cable

Recommended between `Board A` and `Board B`:

- `A0-A15`
- `D0-D7`
- `/RD`
- `/WR`
- `IO/M`
- `/RESET_OUT`
- `+5V`
- `GND`

## Group 2: I/O bus cable

Recommended between `Board A` and `Board C`:

- `A0-A15`
- `D0-D7`
- `/RD`
- `/WR`
- `IO/M`
- `/RESET_OUT`
- `+5V`
- `GND`

## Group 3: optional service cable

Only if physically useful:

- `CLK`
- `ALE`
- `READY`
- spare debug lines

## Test Points

Add these on each board:

### Board A

- `CLK`
- `/RESET_OUT`
- `ALE`
- `/RD`
- `/WR`
- `IO/M`
- `A0`
- `A15`
- `D0`
- `D7`

### Board B

- `/PRG_RAM_CS`
- `/ROM_CS`
- `/MMA_L_CS`
- `/MMA_H_CS`
- `/MMD_CS`
- one `MMA` low bit
- one `MMA` high bit
- one main-memory data bit

### Board C

- `/ENVL_CS`
- `/TSWR_CS`
- `/ACTL_CS`
- `ENVL D0`
- `TSWR D0`
- `ACTL D0`

## Grounding Notes

- Use multiple ground wraps between boards, not a single return.
- Run one dedicated heavier `+5V` feed per board.
- Tie logic grounds first before bringing up the CPU.

## Revision Notes

This signal list is intentionally conservative. It favors simpler routing and clear observability over connector minimization.
