# Rodney On-Hand Stock Reference

Copied into `build/6x09` on `2026-08-25` so the `6x09` redesign can reason about current stock without touching the canonical inventory and stock documents.

Canonical source:

- [build-of-materials/RODNEY-ON-HAND-STOCK.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/RODNEY-ON-HAND-STOCK.md:1)
- [inventory/list.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/inventory/list.csv:1)

This is a working reference snapshot.

## Key Stock Relevant To `6x09`

| Category | Part | Current note |
|---|---|---|
| CPU | `EF6809P` | on hand |
| CPU | `MC6809P` | on hand |
| CPU | `HD63C09RP` | on hand in strong quantity |
| Memory | `AS6C62256-55PIN` | on hand with strong margin |
| Memory | `AS6C6264-55PCN` | on hand / planned with margin |
| Memory | `AT28C64B-15PU` | on hand / planned with margin |
| Glue logic | `74LS00` | in strong quantity |
| Glue logic | `74LS04` | in strong quantity |
| Glue logic | `74LS138` | available |
| Glue logic | `74LS139` | available |
| Latches / buffers | `74LS245` | available |
| Latches / buffers | `74LS273` | available |
| I/O | `74LS244` | available |
| I/O | `74LS164` | available |
| I/O | `74LS86` | available |
| Baseline-only extra | `74LS373` | on hand, though likely dropped for `6x09` |
| Boards | `Vector 8801-6` | on hand |
| Connectors | `R681-2` edge connectors | on hand |
| Sockets | `DIP-40`, `DIP-28`, `DIP-20`, `DIP-16`, `DIP-14` | generally covered well |
| Wiring | `30 AWG` Kynar | on hand |
| Wiring | red and black hookup wire | on hand |

## `6x09` Readout

What this stock snapshot says:

- the redesign is not blocked by lack of `6809` / `6309` CPUs
- the memory plan is already well covered
- most of the likely glue and support logic is already present
- the remaining uncertainty is architectural, not mainly procurement-based

## Important Caveat

This reference does **not** mean the `6x09` BOM is finished.

It means:

- the likely parts are broadly in hand
- the final `Board A` device list still depends on the `6x09` clock, reset, and control-glue schematic
