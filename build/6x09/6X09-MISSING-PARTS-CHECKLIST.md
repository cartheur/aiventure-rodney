# Rodney `6x09` Missing Parts Checklist

Working checklist for the current `6x09` BOM against the tracked inventory.

This file is intentionally pragmatic. It separates:

- parts that appear genuinely missing from `inventory/list.csv`
- parts that appear short in quantity
- parts that may already exist physically but are not tracked cleanly enough yet

Primary references:

- [RODNEY-3BOARD-SINGLE-SHEET-BOM-6X09.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-6X09.md:1)
- [inventory/list.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/inventory/list.csv:1)
- [RODNEY-ON-HAND-STOCK-REFERENCE.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-ON-HAND-STOCK-REFERENCE.md:1)
- [build-of-materials/RODNEY-ON-HAND-STOCK.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/RODNEY-ON-HAND-STOCK.md:1)

Date basis:

- checked against repo state on `2026-08-25`

## 1. Missing From `inventory/list.csv`

These parts are required by the current `6x09` BOM but do not appear explicitly in `inventory/list.csv`.

### TTL and logic support

- `[ ]` `74LS245` x2 total
- `[ ]` `74LS138` x2 total
- `[ ]` `74LS139` x1
- `[ ]` `74LS273` x3 total
- `[ ]` `74LS244` x1
- `[ ]` `74LS164` x1
- `[ ]` `74LS86` x1
- `[ ]` `74LS32N` x1

### Operator / panel parts

- `[ ]` `8-position` DIP switch x2
- `[ ]` reset / momentary pushbuttons x3 total

### Socket and service items

- `[ ]` `DIP-28 ZIF` socket x3 required
- `[ ]` `0.1"` header strips x4
- `[ ]` test posts / turret posts x18
- `[ ]` hard-wire harness anchor hardware x1 set

### Passives and support stock

- `[ ]` `1k` resistors x4
- `[ ]` `0.1uF` decoupling capacitors x15
- `[ ]` bulk electrolytics `47uF` to `470uF` x3

### Mechanical and bring-up items

- `[ ]` standoffs / board supports x1 set
- `[ ]` labels / tape flags x1 pack
- `[ ]` `+5V` USB power bank x1
- `[ ]` HP `5004A` clip leads x2
- `[ ]` logic probe x1
- `[ ]` oscilloscope x1

### `Board A` provisional clock block

- `[ ]` canned oscillator or conservative clock-source module x1
- `[ ]` clock-support passives x1 set

## 2. Quantity Shortfalls In `inventory/list.csv`

These parts do exist in `inventory/list.csv`, but the recorded quantity is below the current `6x09` BOM need.

- `[ ]` `330R` resistor: need `16`, inventory lists `10`, short by `6`

## 3. Probably On Hand But Not Tracked Cleanly

These items are described as available, planned, or purchased in the stock notes, but are not represented clearly enough in `inventory/list.csv` to trust as inventory truth.

### TTL and memory support likely covered by stock notes

- `[ ]` `74LS245`
- `[ ]` `74LS138`
- `[ ]` `74LS139`
- `[ ]` `74LS273`
- `[ ]` `74LS244`
- `[ ]` `74LS164`
- `[ ]` `74LS86`
- `[ ]` `74LS32N`
- `[ ]` `AT28C64B-15PU` status should be confirmed as truly on hand vs planned
- `[ ]` `AS6C6264-55PCN` status should be confirmed as truly on hand vs planned

### Socket and switch stock likely covered outside `inventory/list.csv`

- `[ ]` `DIP-28 ZIF` sockets
- `[ ]` `CTS 195-8MST` DIP switches

### Bench and build accessories likely untracked

- `[ ]` test posts / turret posts
- `[ ]` header-strip stock
- `[ ]` pushbutton stock
- `[ ]` standoff / support hardware
- `[ ]` labels / cable-marking supplies
- `[ ]` clip leads
- `[ ]` logic probe
- `[ ]` oscilloscope

## 4. Not Missing

These parts appear adequately covered for one `6x09` unit.

- `[x]` `6809` CPU family
- `[x]` `6309` later validation CPU family
- `[x]` `62256` SRAM
- `[x]` `DIP-40` wire-wrap socket
- `[x]` `DIP-28` wire-wrap sockets
- `[x]` `DIP-16` wire-wrap sockets
- `[x]` `DIP-14` wire-wrap sockets
- `[x]` `10k` resistors
- `[x]` `Vector 8801-6` boards for one unit
- `[x]` `R681-2` edge connectors for one unit
- `[x]` `30 AWG` Kynar wire
- `[x]` red power wire
- `[x]` black power wire

## 5. Important Interpretation Notes

- This checklist is intentionally conservative and uses `inventory/list.csv` as the strongest evidence.
- The stock summary documents suggest several of the "missing" TTL parts may actually already be present, but that has not been normalized into the inventory CSV.
- The `Board A` clock block is still architecturally unresolved, so its exact missing part number is not yet knowable.

## 6. Recommended Cleanup Order

1. Confirm and normalize all TTL stock into `inventory/list.csv`.
2. Correct the `6x09` BOM counting errors for sockets and decouplers.
3. Decide the `Board A` clock scheme.
4. Re-run the gap check once the clock part and the inventory normalization are complete.
