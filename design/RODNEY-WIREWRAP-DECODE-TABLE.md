# Rodney Wire-Wrap Decode Table

Address and chip-select planning for the bench-first Rodney self-programming core.

Companion to:

- [RODNEY-WIREWRAP-DESIGN-SPEC.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-DESIGN-SPEC.md:1)
- [RODNEY-WIREWRAP-SIGNAL-LIST.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-SIGNAL-LIST.md:1)
- [RODNEY-WIREWRAP-PLACEMENT-PLAN.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-PLACEMENT-PLAN.md:1)

## Goals

- keep the address map easy to debug
- separate memory and I/O cleanly
- avoid over-complex glue on the first wire-wrap pass
- preserve dedicated paths for learned main-memory access

## Proposed Address Map

| Range | Size | Function |
|---|---:|---|
| `0000h-1FFFh` | `8 KB` | program RAM |
| `2000h-3FFFh` | `8 KB` | optional EEPROM / monitor |
| `4000h-7FFFh` | `16 KB` | reserved or future direct main-memory window |
| `8000h` | 1 byte | `ENVL` |
| `8001h` | 1 byte | `ENVH` optional |
| `8002h` | 1 byte | `TSWR` random source |
| `8004h` | 1 byte | `MMA low` register |
| `8005h` | 1 byte | `MMA high` register |
| `8006h` | 1 byte | `MMD` data register |
| `8008h` | 1 byte | `ACTL` |
| `8009h` | 1 byte | `ACTH` optional |

## Decode Strategy

Use:

- one `74LS138` for coarse block decode
- one `74LS139` for finer decode where needed
- `IO/M`, `/RD`, and `/WR` as qualifiers

This document assumes **memory-mapped I/O** rather than separate 8085 I/O-space instructions, because it matches the repo’s chosen map and keeps software straightforward.

## High-Level Region Decode

These are defined in terms of `A15-A13`.

| `A15 A14 A13` | Range | Select Name | Use |
|---|---|---|---|
| `000` | `0000h-1FFFh` | `REGION0` | program RAM |
| `001` | `2000h-3FFFh` | `REGION1` | EEPROM / monitor |
| `010` | `4000h-5FFFh` | `REGION2` | reserved |
| `011` | `6000h-7FFFh` | `REGION3` | reserved |
| `100` | `8000h-9FFFh` | `REGION4` | bench I/O and MMA/MMD |
| `101` | `A000h-BFFFh` | `REGION5` | reserved |
| `110` | `C000h-DFFFh` | `REGION6` | reserved |
| `111` | `E000h-FFFFh` | `REGION7` | reserved |

Recommended first-pass use:

- connect `REGION0` to `/PRG_RAM_CS`
- connect `REGION1` to `/ROM_CS`
- connect `REGION4` to low-address subdecode

## Program RAM Decode

Program RAM is a `6264`, `8 KB x 8`.

| Condition | Result |
|---|---|
| `A15=0, A14=0, A13=0` and `IO/M=0` | assert `/PRG_RAM_CS` |

Connections:

- RAM `A0-A12` <= CPU `A0-A12`
- RAM `/OE` <= `/RD`
- RAM `/WE` <= `/WR`
- RAM `/CS` <= `/PRG_RAM_CS`

## EEPROM Decode

Optional monitor ROM or EEPROM at `2000h-3FFFh`.

| Condition | Result |
|---|---|
| `A15=0, A14=0, A13=1` and `IO/M=0` | assert `/ROM_CS` |

Connections:

- ROM `A0-A12` <= CPU `A0-A12`
- ROM `/OE` <= `/RD`
- ROM `/WE` optional from write-enable jumper or isolated entirely
- ROM `/CS` <= `/ROM_CS`

## REGION4 Subdecode

Use `A4-A0` inside the `8000h` page to select bench I/O and MMA/MMD registers.

Practical note:

- We do not need to decode every address in `8000h-9FFFh`.
- For first pass, it is enough to decode the low page where:
  - `A15=1`
  - `A14=0`
  - `A13=0`
  - `A12-A5=0`

Then use `A4-A0` for per-register select.

## REGION4 Base Page

| Condition | Result |
|---|---|
| `A15=1, A14=0, A13=0, A12-A5=0, IO/M=0` | assert `IOPAGE_8000` |

## Low-Page Register Map

| Address | `A4 A3 A2 A1 A0` | Register | Direction |
|---|---|---|---|
| `8000h` | `00000` | `ENVL` | read |
| `8001h` | `00001` | `ENVH` | read |
| `8002h` | `00010` | `TSWR` | read |
| `8004h` | `00100` | `MMA low` | write and optional readback |
| `8005h` | `00101` | `MMA high` | write and optional readback |
| `8006h` | `00110` | `MMD` | read/write |
| `8008h` | `01000` | `ACTL` | write and optional readback |
| `8009h` | `01001` | `ACTH` | write and optional readback |

## Register Select Truth Table

All results below assume `IOPAGE_8000` is already true.

| `A4 A3 A2 A1 A0` | `/ENVL_CS` | `/ENVH_CS` | `/TSWR_CS` | `/MMA_L_CS` | `/MMA_H_CS` | `/MMD_CS` | `/ACTL_CS` | `/ACTH_CS` |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `00000` | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| `00001` | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 |
| `00010` | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 |
| `00100` | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 |
| `00101` | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 |
| `00110` | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 1 |
| `01000` | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 1 |
| `01001` | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 |

`0` means asserted because all selects are intended active-low.

## Read/Write Qualifiers

## Read-only sources

| Register | Chip-select rule | Bus enable rule |
|---|---|---|
| `ENVL` | `/ENVL_CS=0` | enable only when `/RD=0` |
| `ENVH` | `/ENVH_CS=0` | enable only when `/RD=0` |
| `TSWR` | `/TSWR_CS=0` | enable only when `/RD=0` |

## Write-only or write-primary sinks

| Register | Load rule |
|---|---|
| `MMA low` | load when `/MMA_L_CS=0` and `/WR=0` |
| `MMA high` | load when `/MMA_H_CS=0` and `/WR=0` |
| `ACTL` | load when `/ACTL_CS=0` and `/WR=0` |
| `ACTH` | load when `/ACTH_CS=0` and `/WR=0` |

## Bidirectional MMD register path

| Operation | Rule |
|---|---|
| CPU reads `8006h` | `/MMD_CS=0`, `/RD=0`, main memory byte drives `D0-D7` |
| CPU writes `8006h` | `/MMD_CS=0`, `/WR=0`, `D0-D7` written into main memory at current `MMA` |

## Main-Memory Internal Decode

The learned state store is deliberately **indirectly addressed**.

Recommended first-pass use of `62256`:

- `A0-A7` <= `MMA low`
- `A8-A14` <= lower 7 bits of `MMA high`
- `A15` equivalent not used on a `62256`

Practical capacity options:

| Used MMA bits | Effective learned entries | Notes |
|---:|---:|---|
| `8` | `256` | simplest Beta/Gamma proof |
| `12` | `4096` | close in spirit to original smaller memories |
| `15` | `32768` | full `62256` reach |

Recommendation:

- start with `12` or `15` bits enabled by jumper or strap option

## Suggested Decode IC Allocation

## `74LS138 #1`

Inputs:

- `A15`
- `A14`
- `A13`

Outputs:

- `Y0` => `REGION0` program RAM
- `Y1` => `REGION1` EEPROM
- `Y4` => `REGION4` I/O base

## `74LS138 #2` or `74LS139`

Use on `REGION4` only, with:

- one stage to confirm `A12-A5=0`
- one stage to decode `A4-A2`
- one small gate stage to qualify `A1-A0`

This is intentionally a little redundant but very easy to troubleshoot on wire-wrap.

## Simplified Gate Equations

Conceptual equations only:

```text
/PRG_RAM_CS = not( IO/M=0 and A15=0 and A14=0 and A13=0 )
/ROM_CS     = not( IO/M=0 and A15=0 and A14=0 and A13=1 )

IOPAGE_8000 =      IO/M=0 and A15=1 and A14=0 and A13=0 and A12..A5=0

/ENVL_CS    = not( IOPAGE_8000 and A4..A0 = 00000 )
/ENVH_CS    = not( IOPAGE_8000 and A4..A0 = 00001 )
/TSWR_CS    = not( IOPAGE_8000 and A4..A0 = 00010 )
/MMA_L_CS   = not( IOPAGE_8000 and A4..A0 = 00100 )
/MMA_H_CS   = not( IOPAGE_8000 and A4..A0 = 00101 )
/MMD_CS     = not( IOPAGE_8000 and A4..A0 = 00110 )
/ACTL_CS    = not( IOPAGE_8000 and A4..A0 = 01000 )
/ACTH_CS    = not( IOPAGE_8000 and A4..A0 = 01001 )
```

## Recommended Bring-Up Order

1. verify `/PRG_RAM_CS`
2. verify `/ROM_CS`
3. verify `IOPAGE_8000`
4. verify `/ENVL_CS`
5. verify `/ACTL_CS`
6. verify `/MMA_L_CS`, `/MMA_H_CS`, `/MMD_CS`
7. only then exercise Beta/Gamma memory transactions

## Known Tradeoff

This decode scheme spends more address space than strictly necessary, but it saves a lot of debugging time on a wire-wrap build. That is the right trade for the first implementation.
