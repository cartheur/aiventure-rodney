# `8085` To `6x09` Board A Signal Substitutions

This note focuses on the biggest redesign area: `Board A`.

The current Rodney wire-wrap plan assumes an `8085A` with:

- multiplexed `AD0-AD7`
- `ALE`
- `/RD`
- `/WR`
- `IO/M`
- `READY`
- Intel-flavored reset and interrupt handling

A `6809` or `6309` changes that shape materially.

## Core Architectural Difference

The `8085` exports a multiplexed low address/data bus, so the current design needs:

- a `74LS373` address latch
- `ALE` routing
- extra thought around bus phase timing

The `6809` exports:

- separate address bus
- separate data bus
- different control and bus-state signals

That means the current low-address latch can likely be removed from the baseline `6x09` board.

## Direct Signal Mapping

This is not pin-for-pin. It is a design-intent mapping.

| Current `8085` signal/block | `6x09` equivalent role | Redesign note |
|---|---|---|
| `AD0-AD7` | `A0-A7` plus `D0-D7` | split buses, no multiplex latch |
| `A8-A15` | `A8-A15` | conceptually unchanged |
| `ALE` | none required for low address latch | remove latch-driven timing path |
| `74LS373` low-address latch | usually not needed | can reclaim board area |
| `/RD` | `R/W` plus decode gating | derive read strobes in glue logic |
| `/WR` | `R/W` plus decode gating | derive write strobes in glue logic |
| `IO/M` | `BA`, `BS`, or pure memory-map strategy | easiest path is memory-mapped I/O only |
| `READY` | `MRDY` or wait-state glue if used | optional in first pass |
| `/RESET_OUT` fanout | reset distribution | still required, but timing differs |
| `CLK` | `E` and `Q` clocks | requires new oscillator/divider approach |
| `HOLD` / `HLDA` | `BUSY`/bus-arbitration family as needed | likely omit from rev 1 |

## Recommended First-Pass Philosophy

Keep the first `6x09` board simple:

- no DMA
- no bus mastering
- no complicated wait-state system
- no split I/O space
- memory-map everything

That points to a board with:

- `6809` or `6309` in the CPU socket
- straight-through `A0-A15`
- straight-through `D0-D7`
- read/write strobes generated from `R/W` and address decode
- a small amount of glue for reset, clock, and chip-select timing

## Board A Device-Level Changes

### Likely removable

- `74LS373` low-address latch

### Likely retained

- data buffering or transceiver if the inter-board bus is long
- coarse decode support
- reset glue
- clock support logic

### Likely replaced or rethought

- `74LS245` direction/control logic
- all `ALE`-dependent routing
- `IO/M`-qualified decode logic
- oscillator network

## Clocking

This is one of the non-trivial parts.

An `8085` crystal arrangement does not directly translate into a `6809` bring-up design.

For the first pass, prefer:

- a known-good canned oscillator or divider approach
- conservative clock speed
- explicit probing of `E` and `Q`

Bring-up priority:

1. stable reset
2. valid `E` / `Q`
3. clean address bus activity after reset
4. ROM fetch at the reset vector

## Reset And Interrupts

A `6809` reset path is vector-driven, so the memory system has to be ready at reset fetch time.

Rev 1 recommendations:

- wire reset conservatively
- expose reset at a top-edge test point
- keep `NMI`, `IRQ`, and `FIRQ` pulled inactive unless intentionally used
- defer advanced interrupt usage until after ROM and RAM bring-up

## Strong Recommendation

Do not try to preserve the current `Board A` placement literally.

Preserve:

- top-edge test points
- bottom-edge bus egress
- central CPU placement

But redraw the rest around the `6x09` bus rather than forcing the `8085` topology to fit.
