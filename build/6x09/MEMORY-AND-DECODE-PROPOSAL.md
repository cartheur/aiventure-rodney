# `6x09` Memory And Decode Proposal

This proposal keeps the current Rodney bench-first software contract as stable as possible while adapting it to a `6809` or `6309`.

## Design Goal

Keep these interfaces intact:

- `ENVL`
- `ENVH`
- `TSWR`
- `MMA_L`
- `MMA_H`
- `MMD`
- `ACTL`
- `ACTH`

That way the learning model stays recognizable even though the CPU and assembly change.

## Recommended Memory Map

Use a single `64 KB` linear map with everything memory-mapped.

| Address range | Function | Notes |
|---|---|---|
| `0000-$1FFF` | program RAM | runtime load area |
| `2000-$7FFF` | scratch / expansion RAM | optional direct CPU-visible work area |
| `8000` | `ENVL` | read-only |
| `8001` | `ENVH` | read-only optional |
| `8002` | `TSWR` | read-only pseudo-random source |
| `8004` | `MMA_L` | write learned-memory low address |
| `8005` | `MMA_H` | write learned-memory high address |
| `8006` | `MMD` | read/write learned-memory data |
| `8008` | `ACTL` | write action latch |
| `8009` | `ACTH` | write optional second action latch |
| `A000-$DFFF` | learned main memory backing decode region | implementation-dependent |
| `E000-$FFEF` | monitor / support ROM | stable service routines |
| `FFF0-$FFFF` | vectors | must be valid at reset |

## Why Keep The Same Logical Addresses

Keeping the same register addresses reduces risk in three places:

- documentation stays aligned with the current design spec
- assembly porting becomes semantic rather than architectural
- `Board B` and `Board C` can remain mostly the same conceptually

## Reset Vector Requirement

This is the biggest map difference from the current `8085` ROM style.

The `6809` reset sequence fetches vectors from the top of memory, so ROM must exist at the high end of the address space.

That means the support ROM should be decoded so that:

- vector space at `FFF0-$FFFF` is always valid
- executable ROM body is reachable nearby, commonly at `E000-$FFFF` or similar

## Preferred ROM Layout

Recommended first pass:

| Address range | Function |
|---|---|
| `E000-$EFFF` | support ROM body |
| `F000-$FFEF` | extra ROM service space |
| `FFF0-$FFFF` | vectors |

This lets the ROM:

- own reset cleanly
- host stable monitor and service calls
- avoid awkward reset overlays

## Decode Strategy

Recommended approach:

- use coarse high-address decode first
- generate sub-selects for `8000` page I/O
- keep `MMA` and `MMD` as explicit decoded registers

First-pass decode goals:

1. deterministic reset fetch
2. simple chip-select visibility on a logic probe
3. minimum glue depth between CPU and memory

## Learned Memory Path

The current Rodney redesign uses indirect access to learned state:

1. write `MMA_L`
2. write `MMA_H`
3. read or write `MMD`

That should remain unchanged on `6x09`.

Why keep it:

- it matches the repo's current Rodney interpretation
- it keeps learned state conceptually separate from program RAM
- it simplifies Beta and Gamma porting

## `6809` Versus `6309` Impact On The Map

Very little should change in the memory map itself.

The difference is mainly software opportunity:

- `6309` can accelerate scanning and table work later
- vectors, I/O layout, and learned-memory addressing can remain identical

## Recommended Rev 1 Rule

Do not spend time on banking in the first `6x09` build.

Keep:

- one linear map
- one ROM region
- one program RAM region
- one learned-memory mechanism

Banking can come later if Gamma or monitor growth genuinely demands it.
