# Concrete BOM: `4`-Board Rodney With `8085` And `6x09`

Concrete parts plan for building:

- `Board A-8085`
- `Board A-6x09`
- `Board B`
- `Board C`

This assumes you want one shared `Board B` and one shared `Board C`, with two alternate CPU boards built in parallel.

This file intentionally de-emphasizes the edge-connector strategy because you already have a specific physical plan for that area.

Companion references:

- [RODNEY-3BOARD-SINGLE-SHEET-BOM-6X09.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-6X09.md:1)
- [RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.md:1)
- [6X09-BOM-DELTA.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/6X09-BOM-DELTA.md:1)
- [6X09-MISSING-PARTS-CHECKLIST.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/6X09-MISSING-PARTS-CHECKLIST.md:1)
- [AN002-GA144-CRYSTAL-BOUNDARY.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/AN002-GA144-CRYSTAL-BOUNDARY.md:1)

## Build Intent

The point of this plan is:

- keep the current Rodney memory and I/O architecture stable
- preserve the `8085` path
- add a separate `6x09` CPU board for direct comparison
- avoid rebuilding `Board B` and `Board C` twice

## Boundary Marker

This document marks the hardware boundary before any introduction of a `GA144`.

Scope of this BOM:

- conventional socketed CPU boards
- one `Board A-8085`
- one `Board A-6x09`
- shared `Board B`
- shared `Board C`

Out of scope for this BOM:

- any `GA144` board
- any `GA144` support circuitry
- any mixed `6x09` / `GA144` hybrid backplane or handoff scheme

If a `GA144` path is pursued, it should be treated as the next architectural layer after this concrete CPU-board boundary.

More exact interpretation:

- this BOM ends at the conventional crystal-clocked CPU boundary
- the `GA144` path begins at the resonant frequency of that crystal

So the crystal is the handoff point between:

- conventional socketed CPU timing and support logic
- the next `GA144` architectural regime

Branch note:

- just before establishing that boundary, the `Board A-6x09` concept was about to use a `74LS74` as part of a more conventional clock-divider / phase-generation scheme
- that approach remains documented here as the near-term conventional option, but it is now explicitly de-emphasized relative to the crystal-boundary interpretation
- see `AN002`

## Board Set

- `1 x Board A-8085`
- `1 x Board A-6x09`
- `1 x Board B`
- `1 x Board C`

Total boards:

- `4 x Vector 8801-6`

## Edge / Interconnect Note

Use your existing connector and interconnect plan.

This BOM therefore treats the following as planning placeholders only:

- board-to-board edge connectors
- fixed harness details
- cable-end hardware selection

The real focus here is the electronics population.

## `Board A-8085`

### ICs

- `1 x 8085A`
- `1 x SN74LS373N`
- `1 x SN74LS245N`
- `1 x SN74LS138N`
- `1 x SN74LS04N`
- `1 x SN74LS00N`

### Clock / reset

- `1 x 5 MHz crystal`
- `2 x 22pF` capacitors
- `1 x` reset pushbutton
- `2 x 10k` resistors
- `1 x 1uF to 10uF` reset capacitor

### Sockets

- `1 x DIP-40` wire-wrap socket
- `1 x DIP-20` wire-wrap socket
- `1 x DIP-16` wire-wrap socket
- `2 x DIP-14` wire-wrap sockets

### Board-local passives

- `6 x 0.1uF` decoupling capacitors minimum
- `1 x 47uF to 470uF` bulk capacitor

## `Board A-6x09`

First-pass target CPU:

- `1 x MC6809P` or `1 x EF6809P`

Later validation CPU:

- `1 x HD63C09RP` drop-in test on the same board

### ICs

- `1 x 6809` CPU
- `1 x SN74LS245N`
- `1 x SN74LS138N`
- `1 x SN74LS04N`
- `1 x SN74LS00N`
- `1 x SN74LS74N` optional / de-emphasized
- `1 x SN74LS14N`

### Clock / reset

- `1 x` canned oscillator module
- `1 x` optional external clock header or jumper block
- `1 x` reset pushbutton
- `5 x 10k` resistors
- `1 x 1uF to 10uF` reset capacitor

### Sockets

- `1 x DIP-40` wire-wrap socket
- `1 x DIP-20` wire-wrap socket
- `1 x DIP-16` wire-wrap socket
- `3 x DIP-14` wire-wrap sockets

### Board-local passives

- `7 x 0.1uF` decoupling capacitors minimum
- `1 x 47uF to 470uF` bulk capacitor
- small clock-support passive set as required by final `E/Q` implementation

Clock note:

- the `SN74LS74N` remains listed only because the conventional `6x09` branch was about to use it for a less elegant divider / phase-generation path
- if the crystal boundary is now treated as the start of the `GA144` phase, this part should be considered provisional rather than foundational

### `6309` Hardware Note

No mandatory extra support hardware is required just to run a `6309` in a `6809`-compatible first pass.

Recommended stance:

- design `Board A-6x09` for `6809` bring-up
- validate `6309` as a drop-in second step
- only revisit timing if you later push clock speed or use `6309`-specific software aggressively

## `Board B`

### ICs

- `1 x AS6C62256-55PIN`
- `1 x AS6C6264-55PCN`
- `1 x AT28C64B-15PU`
- `1 x SN74LS138N`
- `1 x SN74LS139AN`
- `2 x SN74LS273N`
- `1 x SN74LS245N`
- `1 x SN74LS00N`
- `1 x SN74LS32N`

### Sockets

- `3 x DIP-28` wire-wrap sockets
- `3 x DIP-28 ZIF` sockets if you want the current swap-friendly plan
- `3 x DIP-20` wire-wrap sockets
- `1 x DIP-16` wire-wrap socket
- `2 x DIP-14` wire-wrap sockets

### Board-local passives

- `9 x 0.1uF` decoupling capacitors minimum
- `1 x 47uF to 470uF` bulk capacitor

## `Board C`

### ICs

- `1 x SN74LS244N`
- `1 x SN74LS273N`
- `1 x SN74LS164N`
- `1 x SN74LS86AN`

### Operator and display parts

- `2 x 8-position` DIP switches
- `16 x 5mm` LEDs
- `16 x 330R` resistors
- `2 x` momentary pushbuttons
- `2 x` pull-up resistor networks or equivalent discrete pull-ups

### Sockets

- `2 x DIP-20` wire-wrap sockets
- `2 x DIP-14` wire-wrap sockets

### Board-local passives

- `4 x 0.1uF` decoupling capacitors minimum
- `1 x 47uF to 470uF` bulk capacitor

## Combined Electronics Totals

### CPUs

- `1 x 8085A`
- `1 x 6809`
- `1 x 6309` reserved for validation, not simultaneous installation

### Memory

- `1 x AS6C62256-55PIN`
- `1 x AS6C6264-55PCN`
- `1 x AT28C64B-15PU`

### TTL and glue

- `1 x SN74LS373N`
- `3 x SN74LS245N`
- `3 x SN74LS138N`
- `1 x SN74LS139AN`
- `3 x SN74LS273N`
- `3 x SN74LS00N`
- `1 x SN74LS32N`
- `2 x SN74LS04N`
- `1 x SN74LS244N`
- `1 x SN74LS164N`
- `1 x SN74LS86AN`
- `1 x SN74LS74N`
- `1 x SN74LS14N`

### Clock and reset

- `1 x 5 MHz crystal`
- `2 x 22pF`
- `1 x` canned oscillator module
- `2 x` reset pushbuttons total
- `7 x 10k` resistors minimum on the two CPU boards
- `2 x 1uF to 10uF` reset capacitors

### Sockets

- `2 x DIP-40` wire-wrap sockets
- `7 x DIP-20` wire-wrap sockets
- `3 x DIP-16` wire-wrap sockets
- `6 x DIP-14` wire-wrap sockets
- `3 x DIP-28` wire-wrap sockets
- `3 x DIP-28 ZIF` sockets

### Shared passives and indicators

- `26 x 0.1uF` decoupling capacitors minimum
- `4 x` bulk electrolytics
- `16 x 330R`
- `16 x LEDs`
- `2 x` DIP switch packs

## Stock Fit Notes

This concrete plan fits the current repo stock fairly well in concept, but several parts are still not tracked cleanly in `inventory/list.csv`.

Most likely strong fits:

- CPUs
- memory devices
- `DIP-40`, `DIP-28`, `DIP-16`, and `DIP-14` sockets
- wire-wrap wire
- board stock for one `4-board` set

Most likely weak or untracked areas:

- some TTL entries not normalized into the inventory CSV
- `330R` quantity if the CSV is treated as strict truth
- `DIP-20` socket quantity if the CSV is treated as strict truth
- canned oscillator module choice
- operator switches, test posts, and small bench accessories

## `6309` Versus `6809`

### No additional mandatory hardware for first-pass compatibility

If you use the `6309` as a drop-in test CPU on the same conservative board:

- no extra memory hardware
- no extra decode hardware
- no extra I/O hardware

### Additional support only if you pursue higher-performance use

Potential later support work:

- revalidate ROM and bus timing at higher clock rates
- possibly revisit wait-state strategy if you drive the board faster
- consider software changes only if you want native `6309` instructions or modes

### Practical recommendation

- build and debug `Board A-6x09` with a `6809`
- confirm ROM fetch, RAM handoff, `MMA/MMD`, and Beta seed behavior
- only then test the `6309`

## Suggested Next Artifact

The next high-value document would be:

- a socket-level `Board A-6x09` population and clock note

That would let the provisional oscillator entry collapse into a final part choice and tighten the `6x09` inventory gap analysis.
