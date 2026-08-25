# Basket Alignment To Current Rodney Build

Alignment of [`basket/basket-items.xls`](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/basket/basket-items.xls:1) against the current baseline build target in [`build-of-materials/RODNEY-3BOARD-SINGLE-SHEET-BOM.md`](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build-of-materials/RODNEY-3BOARD-SINGLE-SHEET-BOM.md:1).

Last updated: `2026-08-25`

## Scope

- This compares the shopping basket to the current **3-board Rodney bench build**.
- The goal is to see which basket items already support the build, which only partly support it, which baseline parts are still missing, and which basket items are for future work rather than the current machine.
- Quantities below are compared to the baseline build BOM, not to legacy Rodney parts lists.

## Direct Matches Or Better-Than-Needed Coverage

| Basket item | Basket qty | Build need | Status | Notes |
|---|---:|---:|---|---|
| `AS6C6264-55PCN` | 6 | 1 | covered | baseline needs `1` for `Board B U7`; leaves strong spare margin |
| `195-8MST` | 10 | 2 | covered | matches current selected `Board C` DIP switch |
| `AT28C64B-15PU` | 10 | 1 | covered | baseline EEPROM plus spares |
| `SN74LS32N` | 10 | 1 | covered | matches optional planned `Board B` glue part |
| `SN74LS86AN` | 10 | 1 | covered | covers `Board C` XOR feedback |
| `SN74LS164N` | 10 | 1 | covered | covers `Board C` pseudo-random source |
| `SN74LS273N` | 10 | 3 | covered | baseline uses `2` on `Board B` and `1` on `Board C` |
| `SN74LS245N` | 20 | 2 | covered | baseline uses `1` on `Board A` and `1` on `Board B` |
| `SN74LS138N` | 10 | 2 | covered | baseline uses `1` on `Board A` and `1` on `Board B` |
| `SN74LS139AN` | 10 | 1 | covered | covers `Board B` subdecode |
| `22pF` ceramic capacitor | 10 | 2 | covered | enough for the `5 MHz` crystal load pair |
| `0.1uF` capacitor | 100 | 17 | covered | enough for baseline decoupling with wide spare margin |
| `10uF` electrolytic | 100 | 1 | covered | enough for reset timing or other small bulk use |
| `47uF` electrolytic | 20 | 3 | covered | enough for one bulk capacitor per board |
| `228-1290-00-0602J` 3M `28`-contact socket | 6 | 3 required `DIP-28 ZIF` | covered | enough for the full `U1/U7/U8` ZIF plan on two Rodney units, with no spare beyond that |

## Partial Coverage Or Needs Confirmation

| Basket item | Basket qty | Build need | Status | Notes |
|---|---:|---:|---|---|
| `123-47-628-41-001000` Mill-Max wire-wrap socket | 10 | 3 | covered for baseline | enough for one unit and contributes strong margin toward a two-unit build when combined with on-hand inventory |
| `D0820-42` Harwin `DIP-20` wire-wrap socket | 20 | 6 | covered for baseline | resolves the main `DIP-20` socket shortage and gives useful margin for a two-unit build when combined with on-hand inventory |
| `RN60D3300FB14` `330R` resistor | 100 | 16 | covered for baseline | enough for a single unit with strong margin and materially improves two-unit LED-resistor readiness when combined with on-hand stock |
| `MF1/4DCT52R1001F` `1k` resistor | 100 | 4 | covered | far exceeds the baseline optional `1k` stock target |
| `3365/40-CUT-LENGTH` 40-conductor ribbon cable | 3 ft | 2 lengths | partial | likely enough for a single baseline machine, but probably light for two complete units unless the cable runs are kept very short |
| `09185406904` Harting `40P` male IDC long lever | 2 | connectorized cable hardware | partial | useful for the connectorized harness path |
| `09185406804` Harting `40P` female IDC | 2 | connectorized cable hardware | partial | useful for the connectorized harness path |
| `40-600-21` Aries `40`-pin header | 2 | `4` header strips | partial | may help with header stock, but the baseline BOM still calls for more header material |
| `ESW-120-44-T-D` Samtec elevated socket strip | 2 | `4` header strips | partial | potentially useful interconnect stock, but not a direct replacement for all planned `0.1"` male headers |
| Same Sky pushbuttons (`PB5` / `PB4L`) | 4 total | 3 total switches | partial | quantity is enough for `reset` plus `2` momentary switches, but these are panel-mount industrial parts and should be checked against the intended mounting approach |

## Missing From The Basket For The Baseline Build

These items do not appear in the basket in a clear baseline-ready form.

This is a basket-only gap list, not a combined readiness verdict. Some of these items are now present in `inventory/list.csv`; use the `Final Fitness Check` section below for the current combined `inventory + basket` status.

| Build item | Qty | Notes |
|---|---:|---|
| Vector `8801-6` wire-wrap plugboard | 3 | core board set |
| `100-pin` wire-wrap edge connector | 2 | `Board A` and `Board B` |
| `8085A` | 1 | baseline CPU |
| `74LS373` | 1 | `Board A` address latch |
| `74LS04` | 1 | `Board A` clock/reset glue |
| `74LS00` | 2 | `Board A` and `Board B` |
| `62256` SRAM | 1 | `Board B U1` main memory |
| `74LS244` | 1 | `Board C` input buffer |
| `5 MHz` crystal | 1 | basket has `16 MHz`, not the current selected part |
| `10k` resistors | 10 total baseline stock target | `2` for reset plus `8` extra in BOM |
| `1k` resistors | 4 | optional glue / indicator stock from baseline BOM |
| `330R` LED resistors | 16 | one per LED on `Board C` |
| `10k` resistor network or equivalent pull-up parts | 2 | for switch pulls on `Board C` |
| `5mm` LEDs | 16 | operator and debug indicators |
| DIP-40 wire-wrap socket | 1 | CPU socket |
| DIP-20 wire-wrap socket | 6 | `A, B, C` |
| DIP-16 wire-wrap socket | 3 | `A, B` |
| DIP-14 wire-wrap socket | 5 | `A, B, C` |
| `DIP-28 ZIF` socket | 3 required | planned for `U1`, `U7`, `U8` |
| `0.1"` male header strips | 4 | bus, service, debug |
| test posts / turret posts | 18 | top-edge minimum |
| hard-wire harness anchor points | 1 set | `Board C` |
| `30 AWG` Kynar wire-wrap wire | 3 to 5 spools | multiple colors preferred |
| `22-24 AWG` red hookup wire | 1 spool | `+5V` |
| `22-24 AWG` black hookup wire | 1 spool | `GND` |
| cable lacing / clamps / zip ties | 1 pack | harness management |
| standoffs / board supports | 1 set | 3-board stack support |
| labels / tape flags | 1 pack | build aid |
| `+5V` USB battery supply | 1 | baseline bring-up source |
| HP `5004A` style clip leads | 2 | bring-up clips |
| wire-wrap tool | 1 | required bench tool |
| unwrap tool | 1 | strongly recommended |
| logic probe | 1 | recommended |
| oscilloscope | 1 | recommended |

## Basket Items That Look Like Future Stock Or Non-Baseline Extras

These are not wrong purchases, but they are not required to assemble the current baseline machine.

| Basket item | Why it is extra for the current build |
|---|---|
| `BPA08B` side-actuated DIP switch | repo already treats this as future variant stock, not current `Board C` |
| `AT28C256-15PU` | future EEPROM stock, not baseline |
| `SN74LS85N` | planned experiment / decision-logic stock, not baseline |
| `LM324AN` op-amp | useful for the new light and sound analog-preview path, not part of the current digital baseline |
| Raspberry Pi HDMI cable | not part of Rodney baseline BOM |
| TE `5749180-1` DIN connector | not in current baseline BOM |
| `LM339AN` comparator | not in current baseline BOM |
| resettable fuses `MF-R050-AP`, `MF-R110-AP`, `MF-R075-AP` | not in current baseline BOM |
| `ATS16B-E` `16 MHz` crystal | current BOM selects `5 MHz` |
| `1N5819` | not in current baseline BOM |
| `1N4148` | not in current baseline BOM |
| `1uF` film capacitor | not required by current baseline BOM |
| `100pF`, `470pF`, `1000pF`, `4700pF`, `0.01uF` capacitors | not required by current baseline BOM |
| `3386P-1-103LF` trimmer | not in current baseline BOM |
| `USBLC6-2SC6` ESD part | not in current baseline BOM |
| `M20-9994045` Harwin horizontal pin header | not clearly needed for current baseline BOM |
| `ATMEGA328P-PU` | not part of current Rodney baseline build |
| Newhaven `0116GZ-FSW-GBW` LCD | not part of current Rodney baseline build |
| Displaytech `204G BC BW` LCD | not part of current Rodney baseline build |
| Same Sky `PTNS2-4515M-B10` slide potentiometer | not part of current Rodney baseline build |
| `CD74HC4051E` analog mux | not part of current Rodney baseline build |

## Recommended Basket Direction

If the goal is to make the basket line up with the current build target:

1. Keep the directly matching memory, logic, switch, and capacitor items.
2. Treat the `DIP-28` socket situation as unresolved until the exact socket types are confirmed.
3. Add the missing baseline CPU, main memory, support logic, sockets, LEDs, resistors, wiring, connectors, and mechanical items listed above.
4. Decide whether the non-baseline extras should stay in this order as future stock or move to a separate expansion basket.

## Basket Update Note

- Basket workbook updated on `2026-08-25`.
- Current workbook now includes `LM324AN` for the analog preview path.
- Current workbook also shows `LM339AN` quantity increased to `25`, which is well beyond the comparator count needed for preview work.
- Current workbook now shows `6` `DIP-28 ZIF` sockets and `20` `D0820-42` `DIP-20` wire-wrap sockets, which materially improves two-unit readiness.
- Current workbook now also includes `330R` LED resistors and `1k` resistor stock, closing two earlier passive-component gaps.

## Final Fitness Check

Using the current basket together with the latest `inventory/list.csv`:

- one complete Rodney unit: fit looks strong
- two complete Rodney units: not fully closed yet

The main remaining hard shortages for two complete units are:

- `2` more `Vector 8801-6` boards
- `2` more `R681-2` edge connectors

Everything else now looks materially better than earlier passes, especially sockets, resistor stock, LEDs, crystals, and general logic coverage.

Itemized combined check:

| Build item | Need for 1 | Need for 2 | Combined available now | 1-unit status | 2-unit status | Notes |
|---|---:|---:|---:|---|---|---|
| Vector `8801-6` boards | 3 | 6 | 4 | covered | short by 2 | on-hand inventory is the limiting factor |
| `R681-2` edge connectors | 2 | 4 | 2 | covered | short by 2 | exact two-unit blocker with the boards |
| `8085A` CPU | 1 | 2 | 4 | covered | covered | inventory already exceeds two-unit target |
| `62256` SRAM | 1 | 2 | 10 | covered | covered | strong on-hand margin |
| `6264` SRAM | 1 | 2 | 6 | covered | covered | basket quantity alone clears two units |
| `AT28C64B-15PU` EEPROM | 1 | 2 | 10 | covered | covered | basket quantity alone clears two units |
| `74LS373` | 1 | 2 | 20 | covered | covered | on hand |
| `74LS245` | 2 | 4 | 20 | covered | covered | basket quantity alone clears two units |
| `74LS138` | 2 | 4 | 10 | covered | covered | basket quantity alone clears two units |
| `74LS04` | 1 | 2 | 60 | covered | covered | on hand |
| `74LS00` | 2 | 4 | 60 | covered | covered | on hand |
| `74LS139` | 1 | 2 | 10 | covered | covered | basket quantity alone clears two units |
| `74LS273` | 3 | 6 | 10 | covered | covered | basket quantity alone clears two units |
| `74LS32` | 1 | 2 | 10 | covered | covered | optional baseline glue also covered |
| `74LS244` | 1 | 2 | 20 | covered | covered | on hand |
| `74LS164` | 1 | 2 | 10 | covered | covered | basket quantity alone clears two units |
| `74LS86` | 1 | 2 | 10 | covered | covered | basket quantity alone clears two units |
| `5 MHz` crystal | 1 | 2 | 10 | covered | covered | on hand |
| `22pF` capacitors | 2 | 4 | 10 | covered | covered | crystal load pair covered with margin |
| `0.1uF` decouplers | 17 | 34 | 100 | covered | covered | basket quantity alone clears two units |
| `10uF` reset capacitor | 1 | 2 | 100 | covered | covered | basket quantity alone clears two units |
| `47uF` bulk capacitors | 3 | 6 | 20 | covered | covered | basket quantity alone clears two units |
| `10k` resistors | 10 | 20 | 100 | covered | covered | discrete stock is enough for reset, pull-ups, and spare use |
| `1k` resistors | 4 | 8 | 100 | covered | covered | basket quantity alone clears two units |
| `330R` LED resistors | 16 | 32 | 110 | covered | covered | basket plus inventory gives wide margin |
| `5mm` LEDs | 16 | 32 | 120 | covered | covered | inventory already clears two units |
| `195-8MST` DIP switch | 2 | 4 | 10 | covered | covered | strong margin |
| momentary / reset pushbuttons | 3 | 6 | 4 | covered with fit check | partial | enough for one unit; two units need two more unless mounting plan changes |
| DIP-40 WW socket | 1 | 2 | 9 | covered | covered | on hand |
| DIP-28 WW socket | 3 | 6 | 18 | covered | covered | basket plus inventory gives strong margin |
| DIP-20 WW socket | 6 | 12 | 25 | covered | covered | basket resolves the earlier shortfall |
| DIP-16 WW socket | 3 | 6 | 36 | covered | covered | on hand |
| DIP-14 WW socket | 5 | 10 | 30 | covered | covered | on hand |
| DIP-28 ZIF socket plan | 3 | 6 | 6 | covered | covered exactly | no spare margin at the two-unit level |
| `30 AWG` Kynar wire-wrap wire | 3 spools | 6 to 10 spools | 8 spools | covered | covered | current on-hand color stock clears the two-unit target band |
| red power wire | 1 spool | 2 spools | 1 spool | covered | partial | one spool is enough now; two-unit comfort margin is not yet explicit |
| black power wire | 1 spool | 2 spools | 1 spool | covered | partial | one spool is enough now; two-unit comfort margin is not yet explicit |
| ribbon or grouped cable | 2 lengths | 4 lengths | 3 ft plus partial connector hardware | partial | partial | likely workable for one unit, but final cut plan still needs confirmation |
| `0.1"` header material | 4 strips | 8 strips | mixed candidate stock only | partial | partial | Samtec, Aries, and Harwin parts may cover this, but not yet as a clean committed set |
| test posts / harness anchor hardware | 1 baseline set | 2 baseline sets | mixed candidate stock only | partial | partial | repo inventory suggests likely material, but the exact allocation is not yet called closed |
| standoffs / board supports | 1 set | 2 sets | not tracked | missing | missing | mechanical gap remains |
| cable lacing / clamps / zip ties | 1 pack | 2 packs | not tracked | missing | missing | consumable gap remains |
| labels / tape flags | 1 pack | 2 packs | not tracked | missing | missing | build-aid gap remains |
| `+5V` USB battery supply | 1 | 2 | not tracked | missing | missing | selected bring-up source is not yet tracked as on hand |
| HP `5004A` clip leads | 2 | 4 | not tracked | missing | missing | bring-up accessory gap remains |
| wire-wrap tool | 1 | 1 | not tracked | missing | missing | required bench tool still untracked here |
| unwrap tool | 1 | 1 | not tracked | missing | missing | strongly recommended tool still untracked here |
| `Weller` soldering iron | 1 | 1 | 1 | covered | covered | explicitly on hand |
| logic probe | 1 | 1 | not tracked | missing | missing | recommended debug tool still untracked here |
| oscilloscope | 1 | 1 | not tracked | missing | missing | recommended debug tool still untracked here |

Matching CSV:

- [BASKET-FINAL-CHECK.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/basket/BASKET-FINAL-CHECK.csv:1)

## Short Read

Current basket-only status against the baseline 3-board Rodney machine:

- covered well: `6264`, `AT28C64B`, `74LS32`, `74LS86`, `74LS164`, `74LS273`, `74LS245`, `74LS138`, `74LS139`, `195-8MST`, confirmed `DIP-28 ZIF`, `22pF`, `0.1uF`, `10uF`, `47uF`
- partly covered or unclear: non-ZIF wire-wrap sockets, interboard cable hardware, header stock, pushbutton mechanics
- still missing from the basket view: core boards, edge connectors, `8085A`, `62256`, `74LS373`, `74LS04`, `74LS00`, `74LS244`, most sockets, LEDs, resistor stock, wire, tooling, and bring-up hardware
- extra for future work: `AT28C256`, `74LS85`, side-actuated DIP switches, display and microcontroller parts, and several unrelated support parts
