# Rodney `8085` Baseline BOM Reference

Copied into `build/6x09` on `2026-08-25` so the `6x09` redesign can work against a local BOM snapshot without altering the source `8085` documents.

Canonical source:

- [build-of-materials/RODNEY-3BOARD-SINGLE-SHEET-BOM.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/RODNEY-3BOARD-SINGLE-SHEET-BOM.md:1)

This is a trimmed working reference rather than a new canonical BOM.

## Baseline Core

| Category | Item | Qty | Board / Use |
|---|---|---:|---|
| Core | Vector `8801-6` wire-wrap plugboard | 3 | `A, B, C` |
| Core | `100-pin` wire-wrap edge connector | 2 | `Board A`, `Board B` |
| Core | `0.1"` male header strips | 4 | all boards |
| Core | test posts / turret posts | 18 | all boards |
| Core | hard-wire interboard harness anchor points | 1 set | `Board C` |

## Baseline `Board A`

| Item | Qty | Notes |
|---|---:|---|
| `8085A` | 1 | CPU |
| `74LS373` | 1 | address latch |
| `74LS245` | 1 | data transceiver |
| `74LS138` | 1 | coarse decode |
| `74LS04` | 1 | clock/reset glue |
| `74LS00` | 1 | glue logic |
| crystal `5 MHz` | 1 | selected standard |
| `22pF` crystal load capacitors | 2 | if crystal circuit uses them |
| reset pushbutton | 1 | service area |
| `10k` resistor | 2 | reset network |
| `1uF` to `10uF` capacitor | 1 | reset timing |

## Baseline `Board B`

| Item | Qty | Notes |
|---|---:|---|
| `62256` SRAM | 1 | main memory |
| `6264` SRAM | 1 | program RAM |
| `AT28C64B-15PU` EEPROM | 1 | monitor / bootstrap |
| `74LS138` | 1 | region decode |
| `74LS139` | 1 | subdecode |
| `74LS273` | 2 | `MMA low`, `MMA high` |
| `74LS245` | 1 | `MMD` path |
| `74LS00` | 1 | decode glue |
| `74LS32N` | 1 | planned glue flexibility |

## Baseline `Board C`

| Item | Qty | Notes |
|---|---:|---|
| `74LS244` | 1 | input buffer |
| `74LS273` | 1 | output latch |
| `74LS164` | 1 | pseudo-random source |
| `74LS86` | 1 | XOR feedback |
| `8-position` DIP switch | 2 | `ENVL`, `ENVH` |
| `5mm` LEDs | 16 | `ACTL` plus debug / `ACTH` |
| `330R` LED resistor | 16 | one per LED |
| momentary switches | 2 | mode / test |
| `10k` resistor network or discrete pull-ups | 2 | switch pulls |

## Baseline Sockets And Shared Stock

| Item | Qty |
|---|---:|
| `DIP-40` wire-wrap socket | 1 |
| `DIP-28` wire-wrap socket | 3 |
| `DIP-20` wire-wrap socket | 6 |
| `DIP-16` wire-wrap socket | 3 |
| `DIP-14` wire-wrap socket | 5 |
| `DIP-28 ZIF` socket | 3 required |
| `0.1uF` ceramic decoupling capacitors | 17 |
| bulk electrolytic `47uF` to `470uF` | 3 |
| extra `10k` resistors | 8 |
| extra `1k` resistors | 4 |
| `30 AWG` Kynar wire-wrap wire | `3 to 5` spools |
| red hookup wire | 1 spool |
| black hookup wire | 1 spool |
| ribbon or grouped cable | 2 lengths |

## Why This Copy Exists

This file is here so the `6x09` redesign documents can:

- reference the baseline directly
- annotate deltas locally
- avoid accidental edits to the original `8085` BOM
