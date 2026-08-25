# Rodney `6x09` BOM Delta

This document defines the parts delta between the current `8085` Rodney bench build and the proposed `6809` / `6309` redesign track.

It does **not** modify the original `8085` BOM documents.

Local reference copies used by this folder:

- [RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.md:1)
- [RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.csv:1)
- [RODNEY-ON-HAND-STOCK-REFERENCE.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-ON-HAND-STOCK-REFERENCE.md:1)

Related `6x09` design notes:

- [BOARD-A-SIGNAL-SUBSTITUTIONS.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/BOARD-A-SIGNAL-SUBSTITUTIONS.md:1)
- [MEMORY-AND-DECODE-PROPOSAL.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/MEMORY-AND-DECODE-PROPOSAL.md:1)
- [BRING-UP-PLAN.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/BRING-UP-PLAN.md:1)

## Summary

The `6x09` redesign reuses most of:

- the physical `3-board` structure
- all `Board B` memory devices
- nearly all `Board C` bench I/O devices
- most sockets, wiring, headers, passives, and bench tooling

The main BOM impact is concentrated on `Board A`.

In practical terms:

- `Board B` is mostly unchanged
- `Board C` is effectively unchanged
- `Board A` is partly reusable and partly a respin

## Keep As-Is

These parts remain directly useful with no design change implied.

### Core and mechanical

- `Vector 8801-6` boards
- `100-pin` edge connectors
- `0.1"` header strips
- test posts / turret posts
- harness anchor hardware
- standoffs / supports

### Memory board

- `62256` SRAM
- `6264` SRAM
- `AT28C64B-15PU` EEPROM
- `74LS138`
- `74LS139`
- `74LS273` for `MMA_L` and `MMA_H`
- `74LS245` for `MMD` path isolation
- `74LS00`
- `74LS32`

### I/O board

- `74LS244`
- `74LS273`
- `74LS164`
- `74LS86`
- `8-position` DIP switches
- LEDs
- LED resistors
- momentary switches
- pull-ups / resistor networks

### Shared stock

- `DIP-28` wire-wrap sockets
- `DIP-20` wire-wrap sockets
- `DIP-16` wire-wrap sockets
- `DIP-14` wire-wrap sockets
- `DIP-28 ZIF` sockets
- `0.1uF` decouplers
- bulk capacitors
- `10k`, `1k`, `330R` resistor stock
- `30 AWG` Kynar
- red and black hookup wire
- ribbon cable / grouped cable
- USB bench power concept
- clip leads
- soldering and wire-wrap tools

## Drop From The `6x09` Variant

These items are specific to the `8085` baseline and should not appear in the `6x09` BOM unless a later schematic creates a new reason for them.

- `8085A`
- `74LS373` low-address latch used for `AD0-AD7` de-multiplexing

Why:

- the `6809` / `6309` present separate address and data buses
- the `ALE`-driven latch path is no longer the board's defining feature

## Replace

These baseline BOM items need explicit replacement or reclassification in the `6x09` BOM.

| `8085` baseline item | `6x09` action | Current recommendation |
|---|---|---|
| `8085A` CPU | replace | use `6809` for bring-up, validate `6309` later |
| `DIP-40` CPU socket tagged `8085A` | retain but relabel | still a `DIP-40` CPU socket if final package stays `6809P` / `6309RP` |
| `5 MHz` crystal plan | replace or mark provisional | final `6x09` clock source must follow the chosen `E/Q` strategy |
| `74LS04` clock/reset glue | retain but redesign role | still likely useful, but not as a copied `8085` clock network |
| `74LS00` glue logic on `Board A` | retain but redesign role | still likely useful, but exact gates depend on `R/W`, reset, and ROM timing |
| `74LS245` `Board A` transceiver | retain provisionally | likely still useful for inter-board bus buffering, but direction logic must be redone |

## Add Or Promote For The `6x09` BOM

These are not guaranteed new purchases, but they need to be explicit in the `6x09` BOM rather than left implied by the `8085` design.

- `6809` CPU entry
- `6309` compatibility note
- `Board A` `E` / `Q` clock-generation block
- `Board A` reset and vector-fetch timing notes
- pull-ups for `NMI`, `IRQ`, and `FIRQ`
- any wait-state or `MRDY` support if the final board needs it

## Board-By-Board Delta

### Board A

Keep:

- `DIP-40` CPU socket footprint class
- reset pushbutton
- `10k` reset-network resistors
- reset timing capacitor
- top-edge test-point strategy
- optional `74LS245`
- optional `74LS138`
- likely `74LS04`
- likely `74LS00`

Drop:

- `8085A`
- `74LS373`
- any `ALE`-specific routing assumption

Rework:

- clock source
- reset timing details
- ROM / RAM read-write timing assumptions
- `R/W`-derived control strobes

### Board B

Keep almost unchanged:

- `62256`
- `6264`
- EEPROM
- `74LS138`
- `74LS139`
- `74LS273`
- `74LS245`
- `74LS00`
- `74LS32`

Main `6x09` change:

- ROM decoding must satisfy high-memory vector fetch at `FFF0-FFFF`

### Board C

Keep unchanged in first pass:

- input buffer
- output latch
- pseudo-random source
- switches
- LEDs
- pull-ups

## Inventory Fit

Using [inventory/list.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/inventory/list.csv:1) and the current on-hand summary:

Already covered well:

- `6809` CPUs
- `6309` CPUs
- `62256`
- `6264`
- `AT28C64B`
- `74LS00`
- `74LS04`
- `74LS373` even though the `6x09` variant likely drops it
- `DIP-40`, `DIP-28`, `DIP-16`, and `DIP-14` sockets
- boards, connectors, wire, and memory stock

Covered but still schematic-dependent:

- whether the existing `5 MHz` crystals are the right fit for the final `6x09` clock method
- whether `74LS245` remains the preferred `Board A` buffer part
- whether one `74LS138` is enough on `Board A` or if decode shifts more heavily to `Board B`

## Current Readiness Verdict

For a first `6809` prototype, the stock situation looks promising.

For a final `6x09` BOM, the unresolved items are not general availability problems. They are mostly:

- exact `Board A` clock design
- exact `Board A` control-glue design
- whether the first pass should be `6809`-only or explicitly `6809` / `6309` dual-qualified

## Recommended Next BOM Step

Before declaring the `6x09` parts list finished, add one more artifact:

- a `Board A` device-level draft schematic or socket map

Once that exists, the open BOM questions should collapse quickly into:

- confirmed keep items
- confirmed deletions
- a very short list of truly new parts, if any
