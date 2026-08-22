# Rodney 3-Board Single-Sheet BOM

Single-sheet build of materials for the current `3 x Vector 8801-6` bench-first Rodney wire-wrap build.

This BOM matches the current planning docs:

- [design/RODNEY-WIREWRAP-DESIGN-SPEC.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-DESIGN-SPEC.md:1)
- [design/RODNEY-WIREWRAP-COORDINATE-WORKSHEET.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-COORDINATE-WORKSHEET.md:1)
- [design/RODNEY-WIREWRAP-SILKSCREEN-OVERLAYS.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-SILKSCREEN-OVERLAYS.md:1)

Use this as the bench checklist for whether we have everything needed to start placing sockets and wiring the first-pass machine.

## Assumptions

- This is the **new 3-board bench build**, not a strict reproduction of the original 1979 board set.
- EEPROM is included for the current plan.
- `ENVH` and `ACTH/debug` footprints are included even if you choose not to populate them on rev A.
- The stack uses **2 edge connectors total**, with the third board hard-wired into the stack harness.
- Preferred choice: connectorized `Board A` and `Board B`, hard-wired `Board C`.
- Quantities below are **required build quantities**, not current stock counts.

## Single-Sheet BOM

| Check | Category | Item | Footprint | Qty | Board / Use | Notes |
|---|---|---|---|---:|---|---|
| `[ ]` | Core | Vector `8801-6` wire-wrap plugboard | `S-100 / 100-pin board` | 3 | A, B, C | one board per function |
| `[ ]` | Core | 100-pin wire-wrap edge connector | `100-pin edge connector` | 2 | Board A, Board B | `Board C` is hard-wired |
| `[ ]` | Core | 0.1" male header strips | `0.1" header` | 4 | all boards | bus, service, debug |
| `[ ]` | Core | test posts / turret posts | `turret / post` | 18 | all boards | `6 + 8 + 4` top-edge minimum |
| `[ ]` | Core | hard-wire interboard harness anchor points | `lug / header / clamp` | 1 set | Board C | header, solder lugs, or strain-relieved tie points |
| `[ ]` | CPU board | `8085A` | `DIP-40` | 1 | Board A | CPU |
| `[ ]` | CPU board | `74LS373` | `DIP-20` | 1 | Board A | address latch |
| `[ ]` | CPU board | `74LS245` | `DIP-20` | 1 | Board A | data transceiver |
| `[ ]` | CPU board | `74LS138` | `DIP-16` | 1 | Board A | coarse decode |
| `[ ]` | CPU board | `74LS04` | `DIP-14` | 1 | Board A | clock/reset glue |
| `[ ]` | CPU board | `74LS00` | `DIP-14` | 1 | Board A | glue logic |
| `[ ]` | CPU board | crystal `5 MHz` or `6.144 MHz` | `2-pin crystal` | 1 | Board A | choose one standard |
| `[ ]` | CPU board | crystal load capacitors `22pF` | `radial / ceramic` | 2 | Board A | if crystal circuit uses them |
| `[ ]` | CPU board | reset pushbutton | `panel / PCB switch` | 1 | Board A | top-edge service area |
| `[ ]` | CPU board | `10k` resistor | `axial resistor` | 2 | Board A | reset network |
| `[ ]` | CPU board | `1uF` to `10uF` capacitor | `radial electrolytic` | 1 | Board A | reset timing |
| `[ ]` | Memory board | `62256` SRAM | `DIP-28` | 1 | Board B | main memory; selected part: `Alliance AS6C62256-55PIN`, see [Alliance datasheet](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/datasheets/alliance/AS6C62256_23_March_2016_rev1.2.pdf:1) |
| `[ ]` | Memory board | `6264` SRAM | `DIP-28` | 1 | Board B | program RAM; selected part: `Alliance AS6C6264-55PCN`, see [Alliance datasheet](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/datasheets/alliance/Alliance_Memory_64K_AS6C6264v2.0July2017.pdf:1) |
| `[ ]` | Memory board | `28C16` or `28C64` EEPROM | `DIP-24 or DIP-28` | 1 | Board B | monitor / bootstrap |
| `[ ]` | Memory board | `74LS138` | `DIP-16` | 1 | Board B | region decode |
| `[ ]` | Memory board | `74LS139` | `DIP-16` | 1 | Board B | subdecode |
| `[ ]` | Memory board | `74LS273` | `DIP-20` | 2 | Board B | `MMA low`, `MMA high` |
| `[ ]` | Memory board | `74LS245` | `DIP-20` | 1 | Board B | `MMD` path / data isolation |
| `[ ]` | Memory board | `74LS00` | `DIP-14` | 1 | Board B | decode glue |
| `[ ]` | Memory board | `74LS32` | `DIP-14` | 1 | Board B | optional decode glue |
| `[ ]` | I/O board | `74LS244` | `DIP-20` | 1 | Board C | input buffer |
| `[ ]` | I/O board | `74LS273` | `DIP-20` | 1 | Board C | output latch |
| `[ ]` | I/O board | `74LS164` | `DIP-14` | 1 | Board C | pseudo-random source |
| `[ ]` | I/O board | `74LS86` | `DIP-14` | 1 | Board C | XOR feedback |
| `[ ]` | I/O board | `8-position` DIP switch | `DIP switch, 8-pos` | 2 | Board C | `ENVL`, `ENVH`; selected part: `CTS 195-8MST`, through-hole, piano/top-actuated |
| `[ ]` | I/O board | `5mm` LEDs | `T-1 3/4` | 16 | Board C | `ACTL` plus debug / `ACTH` |
| `[ ]` | I/O board | LED resistors `330R` | `axial resistor` | 16 | Board C | one per LED |
| `[ ]` | I/O board | momentary switches | `panel / PCB switch` | 2 | Board C | mode / test |
| `[ ]` | I/O board | `10k` resistor network or discrete pull-ups | `SIP network or axial` | 2 | Board C | switch pulls |
| `[ ]` | Sockets | DIP-40 wire-wrap socket | `DIP-40 WW socket` | 1 | Board A | `8085A` |
| `[ ]` | Sockets | DIP-28 wire-wrap socket | `DIP-28 WW socket` | 3 | Board B | `62256`, `6264`, EEPROM |
| `[ ]` | Sockets | DIP-20 wire-wrap socket | `DIP-20 WW socket` | 6 | A, B, C | `1 + 3 + 2` |
| `[ ]` | Sockets | DIP-16 wire-wrap socket | `DIP-16 WW socket` | 3 | A, B | `1 + 2` |
| `[ ]` | Sockets | DIP-14 wire-wrap socket | `DIP-14 WW socket` | 5 | A, B, C | `2 + 2 + 1` |
| `[ ]` | Sockets | DIP-28 ZIF socket | `DIP-28 ZIF` | 3 | Board B | plugs into soldered DIP-28 machine-pin WW sockets at `U1`, `U7`, `U8` |
| `[ ]` | Sockets | DIP-40 ZIF socket | `DIP-40 ZIF` | 0 to 1 | Board A | optional for `8085A` swap testing |
| `[ ]` | Passive | `0.1uF` ceramic decoupling capacitors | `radial / ceramic` | 17 | all boards | one per IC minimum |
| `[ ]` | Passive | bulk electrolytic `47uF` to `470uF` | `radial electrolytic` | 3 | A, B, C | one per board |
| `[ ]` | Passive | extra `10k` resistors | `axial resistor` | 8 | general | pull-ups, glue, spare |
| `[ ]` | Passive | extra `1k` resistors | `axial resistor` | 4 | general | optional indicators / glue |
| `[ ]` | Wiring | `30 AWG` Kynar wire-wrap wire | `spool` | 3 to 5 spools | all boards | multiple colors preferred |
| `[ ]` | Wiring | `22-24 AWG` hookup wire, red | `spool` | 1 spool | power | `+5V` |
| `[ ]` | Wiring | `22-24 AWG` hookup wire, black | `spool` | 1 spool | power | `GND` |
| `[ ]` | Wiring | 16- to 26-conductor ribbon or grouped cable | `cable` | 2 lengths | `CAB-A-B`, `CAB-A-C` | one connectorized cable and one fixed harness |
| `[ ]` | Wiring | cable lacing, zip ties, or harness clamps | `consumable` | 1 pack | stack harness | recommended for the hard-wired board |
| `[ ]` | Mechanical | standoffs / board supports | `hardware set` | 1 set | rack | enough for 3 boards |
| `[ ]` | Mechanical | labels or masking tape flags | `consumable` | 1 pack | build aid | cable and signal marking |
| `[ ]` | Power | `+5V` USB battery supply | `USB power bank` | 1 | bring-up | selected bench source for first logic bring-up |
| `[ ]` | Power | HP `5004A` signature-analyzer clip leads | `grabber / clip lead` | 2 | bring-up | used to clip `+5V` and `GND` onto board input pins |
| `[ ]` | Power | wall-powered `+5V` bench supply | `bench supply` | 1 optional | fallback | use only if the USB source shows droop or unstable behavior |
| `[ ]` | Tools | wire-wrap tool | `hand tool` | 1 | build | manual or powered |
| `[ ]` | Tools | unwrap tool | `hand tool` | 1 | build | strongly recommended |
| `[ ]` | Tools | soldering iron | `bench tool` | 1 | build | connectors, headers |
| `[ ]` | Tools | logic probe | `bench tool` | 1 | debug | recommended |
| `[ ]` | Tools | oscilloscope | `bench instrument` | 1 | debug | recommended |

## Quick Totals

| Type | Qty |
|---|---:|
| Boards | 3 |
| Edge connectors | 2 |
| ICs on sockets | 18 to 19 |
| Wire-wrap sockets total | 18 |
| Top-edge test posts minimum | 18 |
| LEDs | 16 |
| DIP switch packs | 2 |
| Bulk capacitors | 3 |
| `0.1uF` decouplers minimum | 17 |

## Recommended Swap-Isolation Targets

If you want to reserve ZIF capability without overcomplicating the build, prioritize in this order:

1. `Board B U8` EEPROM / monitor ROM
2. `Board B U7` `6264` program RAM
3. `Board A U1` `8085A`, only if you expect to try multiple CPUs
4. `Board B U1` `62256` only if you plan active learned-memory experiments with multiple SRAMs

For the current plan, we are reserving:

- `3 x DIP-28 ZIF` on Board B for `U1`, `U7`, and `U8`
- skip `DIP-40 ZIF` unless CPU swapping is a real expectation

Board B placement note:

- keep lever-clearance space around all three `28-pin` memory positions
- avoid placing tall posts or bulk harness tie-downs immediately beside `U8`
- intended stack is `board -> WW socket -> ZIF -> memory chip`

## Notes Against Existing Repo Inventory

- The repo already references the key board family and several compatible parts in [build-of-materials/Parts-List.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/Parts-List.csv:1) and [build-of-materials/BOM_Rodney.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/BOM_Rodney.csv:1), but those lists mix original-machine parts with this newer 3-board plan.
- This sheet is meant to be the simplified current-build target list.
- For the `2-connector` build, `Board C` is the best hard-wired candidate because it is the least likely board to need repeated removal during CPU and memory bring-up.
- The one part family still worth deciding explicitly before ordering is the exact EEPROM package width, because that can affect whether you want a DIP-24 or DIP-28 socket in Board B.
- Current bench-power plan is a `+5V` USB battery with `2` HP `5004A` signature-analyzer style clips landing on board power-input pins; verify stable `5V` under load and keep a solid common ground before CPU bring-up.

## Selected Memory Part

Current selected `U7` program RAM:

- `Alliance AS6C6264-55PCN`
- `8K x 8`
- `DIP-28` PDIP
- commercial temp grade `0C to 70C`
- preferred over `AS6C6264-55PIN` because the industrial-temperature variant costs about `EUR 5` more per device without adding useful value for the current bench build

Current selected `U1` main memory:

- `Alliance AS6C62256-55PIN`
- `32K x 8`
- `DIP-28` PDIP
- industrial temp grade `-40C to +85C`
- direct fit for the current `Board B U1` footprint and `28-pin ZIF` plan

Current selected `SW1` and `SW2` input switches:

- `CTS 195-8MST`
- `8-position` DIP switch
- through-hole
- piano / top-actuated
- tape sealed
- selected because it matches the current `Board C` operator-facing switch layout better than the side-actuated `BPA` family

Future variant stock:

- `2 x BPA08B`
- retained as stock for possible future miniaturized or side-access board variants
- not planned for the current `Board C` Rodney build
