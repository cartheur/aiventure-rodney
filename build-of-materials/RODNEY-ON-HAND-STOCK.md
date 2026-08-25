# Rodney On-Hand Stock

On-hand inventory tracker for the current Rodney bench build and nearby expansion experiments.

Use this page to track what is physically in hand without changing the purchase-oriented BoM files.

Related references:

- [RODNEY-3BOARD-SINGLE-SHEET-BOM.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/RODNEY-3BOARD-SINGLE-SHEET-BOM.md:1)
- [RODNEY-3BOARD-SINGLE-SHEET-BOM.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/RODNEY-3BOARD-SINGLE-SHEET-BOM.csv:1)

Last updated: `2026-08-25`

## Current On-Hand Stock

| Category | Part | Selected / Typical Device | Required For Current Build | On Hand | Delta | Notes |
|---|---|---|---:|---:|---:|---|
| Memory board | main memory SRAM | `AS6C62256-55PIN` | 1 | 10 | +9 | enough for baseline build plus spares and memory experiments |
| Memory board | program RAM SRAM | `AS6C6264-55PCN` | 1 | 6 planned | 5 planned spare | purchase planned; enough for baseline build plus direct-map and swap experiments |
| Memory board | monitor EEPROM | `AT28C64B-15PU` | 1 | 10 planned | 9 planned spare | purchase planned; can support baseline build plus swap and experiment stock |
| Memory board | MMA latches / output latch family | `74LS273` | 3 | 10 planned | 7 planned spare | baseline build uses `2` on Board B and `1` on Board C |
| CPU and memory boards | bus transceiver / data isolation | `74LS245` | 2 | 10 planned | 8 planned spare | baseline build uses `1` on Board A and `1` on Board B |
| CPU and memory boards | region decode | `74LS138` | 2 | 10 planned | 8 planned spare | baseline build uses `1` on Board A and `1` on Board B |
| Memory board | subdecode | `74LS139` | 1 | 10 planned | 9 planned spare | baseline build uses `1` on Board B |
| CPU and memory boards | NAND glue logic | `74LS00` | 2 | 20+ in stock | 18+ spare | baseline build uses `1` on Board A and `1` on Board B |
| CPU board | inverter / clock-reset glue | `74LS04` | 1 | 20+ in stock | 19+ spare | baseline build uses `1` on Board A |
| Sockets | `DIP-28 ZIF` | Board B `U1`, `U7`, `U8` | 3 | 4 purchased | +1 | current plan uses `3` and keeps `1` spare |
| Sockets | `DIP-28` wire-wrap socket | memory devices | 3 | in stock |  | baseline requirement only; expansion spares can be tracked here too |
| Sockets | `DIP-40` wire-wrap socket | `8085A` | 1 | in stock |  | CPU is fixed to a standard wire-wrap socket plan |
| CPU board | CPU | `8085A` | 1 | 4 | +3 | enough for baseline build plus swap and fault-isolation margin |
| CPU board | crystal | `5 MHz` | 1 | 10 in stock | +9 | inventory list now shows strong crystal margin for multiple Rodney units and experiments |
| Memory board | decode glue | `74LS32N` | 1 | 10 purchased | +9 | planned support logic for the improved build; datasheet already in repo |
| I/O board | input buffer | `74LS244` | 1 | 20 | +19 | baseline Board C input-buffer part; strong spare margin already on hand |
| I/O board | pseudo-random source | `74LS164` | 1 | 10 planned | 9 planned spare | baseline shift-register part for the Board C pseudo-random source |
| I/O board | XOR feedback | `74LS86` | 1 | 10 planned | 9 planned spare | baseline part for the pseudo-random source on Board C |
| I/O board | DIP switch | `CTS 195-8MST` | 2 | 10 planned | 8 planned spare | `SW1`, `SW2`; strong margin for alternates and rework |
| Passive | `10k` resistor | `MF1/4DCT52R1002F` | 10 baseline stock target | 100 in stock | +90 | covers reset, pull-ups, and general glue stock for multiple Rodney units |
| Analog preview | quad op-amp | `LM324AN` | 0 baseline | 20 in stock | preview stock | supports light-sensing gain, buffering, and simple active-filter experiments |
| Analog preview | microphone amp breakout | `Adafruit 1713 / Mouser 485-1713` | 0 baseline | 6 in stock | preview stock | MAX9814 electret mic amp breakout for sound-trigger experiments |
| Analog preview | light sensor | `CdS photoresistor` | 0 baseline | 30 in stock | preview stock | inventory list now shows ample stock for light-threshold and beam-break style experiments |
| Tools | soldering iron | `Weller` | 1 | in stock |  | primary soldering iron for the Rodney build |

## Expansion-Oriented Stock

These are not required to assemble the baseline machine, but are worth tracking if they are already on hand.

| Category | Part | Suggested Stock Target | On Hand | Notes |
|---|---|---:|---:|---|
| Memory expansion | extra `6264` SRAM | 1 to 2 spare |  | supports alternate `U7` / `U8` program-memory experiments |
| Memory expansion | extra `DIP-28 ZIF` | 1 spare |  | current purchasing direction suggests total buy of `4` |
| Memory expansion | extra `DIP-28` wire-wrap socket | 1 to 2 spare |  | useful for rework or alternate population |
| Memory expansion | `AT28C256-15PU` EEPROM | 4 planned | 4 planned | optional larger EEPROM stock if we want more room later |
| Memory expansion | `256K`-class memory devices | optional future reserve |  | for post-`GAMMA-1` / `DELTA-1` style experiments |
| Decode experiments | jumper / header strap hardware | 1 small pack |  | useful for alternate chip-select or bank-select work |
| Decision experiments | `74LS85` magnitude comparator | 1 to 2 | 10 planned | purchase planned; strong margin if `4-bit wonder` testing suggests we want hardware compare, threshold, or ranking support |
| Analog preview | `LM324AN` quad op-amp | 1 to 2 | 20 in stock | enough for several light or microphone front-end experiments |
| Analog preview | `Adafruit 1713 / 485-1713` microphone amp breakout | 1 to 2 | 6 in stock | enough for multiple sound-sensing preview builds |
| Analog preview | `CdS` photoresistor | 1 to 2 | 30 in stock | enough for multiple light-sensing preview builds and spares |

## Readiness Snapshot

Current status using the latest `inventory/list.csv` plus the active `basket/basket-items.csv`:

- one complete Rodney unit: fit looks strong
- two complete Rodney units: electronics core looks strong, but the full build is not yet closed out

Main strengths for the two-unit target:

- CPUs, core TTL, memory devices, WW sockets, ZIF sockets, crystals, LEDs, and common resistor or capacitor stock are all in good shape
- wire-wrap wire and basic red or black power wire are now on hand
- analog preview branch for light and sound sensing is well covered

Main remaining blockers for the two-unit target:

- `Vector 8801-6` boards: `4` on hand vs `6` needed
- `R681-2` edge connectors: `2` on hand vs `4` needed

Still worth confirming before calling the two-unit build fully ready:

- exact header-strip plan for service and interconnect
- test-post and harness-anchor allocation per unit
- pushbutton mounting details
- standoffs and final mechanical stack hardware
- final cable-length comfort margin

## Theoretical `6264` Ceiling

If we ignore physical board area and only look at the address/decode model:

- one `6264` provides `8 KB`
- the `8085` exposes `64 KB` of address space total
- pure mathematical direct-map ceiling: `8 x 6264`

In the current Rodney map, one `8 KB` region is used for the `8000h-9FFFh` I/O page, so:

- practical direct-mapped ceiling with I/O preserved: `7 x 6264`
- practical direct-mapped ceiling with both I/O and the current EEPROM / monitor window preserved: `6 x 6264`

These are theory limits for the map only, not recommendations for the first-pass build.

## Banking Theory

Banking means the CPU keeps seeing the same address window, but extra logic decides which physical memory chip is currently active behind that window.

Simple theory:

- without banking, each chip gets its own fixed address range
- with banking, multiple chips share one CPU-visible range
- a bank-select bit or group of bits chooses which chip or chip group is enabled

Example for Rodney:

- keep program space at `0000h-1FFFh`
- connect two or more `6264` devices so only one of them sees `/CS` at a time
- drive that selection from a jumper, latch, flip-flop, or memory-mapped control register

Why banking matters:

- it lets us reuse scarce address space
- it allows multiple program images or experiment sets behind one window
- it increases software and decode complexity compared with direct mapping

Main software rule:

- never switch away from the bank currently executing code unless the switching routine lives in an always-visible region such as EEPROM / monitor ROM or some other non-banked space

Theory scaling:

- direct-mapped memory is capped by the number of distinct address windows
- banked memory scales by `windows x banks-per-window`
- so if `6` or `7` windows are available and each window has `N` banks, the total possible `6264` count becomes roughly `6 x N` or `7 x N`

## Comparator Note

`74LS85` is not part of the current baseline Rodney build, but it is a good candidate for later decision-support experiments.

Possible uses:

- compare two small scores or confidence values
- detect whether one thresholded value is greater than, less than, or equal to another
- support hardware-assisted choice, ranking, or branch conditions

Practical stance:

- keep it out of the first-pass build unless testing shows a clear benefit
- be ready to bring it into the build if the `4-bit wonder` experiments demonstrate a useful decision or predictive primitive

## Tracking Notes

- `Delta` is `On Hand - Required For Current Build`.
- Leave `On Hand` blank until a real count is confirmed.
- If a part has multiple acceptable variants, record the exact stocked part in the `Selected / Typical Device` column or notes.
- Keep this page focused on stock state; use the single-sheet BoM for purchase requirements and planning assumptions.
