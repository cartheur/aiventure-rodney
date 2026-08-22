# Rodney Wire-Wrap Coordinate Worksheet

First-pass socket worksheet for the `3 x Vector 8801-6` Rodney bench build.

This turns the block diagrams and placement plan into **board-local placement coordinates** that are concrete enough to start socket layout and hole counting.

Companion docs:

- [RODNEY-WIREWRAP-BLOCK-DIAGRAM.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-BLOCK-DIAGRAM.md:1)
- [RODNEY-WIREWRAP-PLACEMENT-PLAN.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-PLACEMENT-PLAN.md:1)
- [RODNEY-WIREWRAP-DESIGN-SPEC.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-DESIGN-SPEC.md:1)

Rendered planning images:

- [Board A worksheet JPG](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/diagrams/RodneyBoardA-worksheet.jpg)
- [Board B worksheet JPG](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/diagrams/RodneyBoardB-worksheet.jpg)
- [Board C worksheet JPG](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/diagrams/RodneyBoardC-worksheet.jpg)
- [Overall stack JPG](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/diagrams/RodneyWirewrapWorksheetStack.jpg)

Silkscreen-style overlays on the actual board image:

- [Silkscreen overlay doc](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/design/RODNEY-WIREWRAP-SILKSCREEN-OVERLAYS.md:1)

## Coordinate System

- Each board uses a **planning grid** in `0.1"` hole increments.
- Coordinates are written as `Xnn, Ynn`.
- `X1` is the left side of the usable component field.
- `Y1` is the top of the usable component field.
- The bottom connector/breakout band is reserved as `Y35-Y40`.
- Default orientation is viewed from the **component side**, with the edge connector at the bottom.
- `Pin-1 origin` means the coordinate marks the **pin 1 hole** for the socket.
- `E-W` means the long axis of the package runs left-to-right.

This worksheet is intentionally a **build-planning grid**, not a claim about the original Vector silkscreen row/column labels.

## Planning Lanes

Apply these on all three boards unless routing forces a local exception:

- `X1-X6`: power lane
- `X87-X96`: bus, breakout, or service lane
- `Y1-Y5`: test points, jumpers, and top-edge service area
- `Y35-Y40`: connector, power entry, and bus ingress/egress

## Package Span Reference

These spans are for worksheet planning only.

| Package | Typical Use Here | Span |
|---|---|---|
| DIP-14 narrow | `74LS04`, `74LS164`, `74LS93` | `7 x 4` |
| DIP-16 narrow | `74LS138`, `74LS139` | `8 x 4` |
| DIP-20 narrow | `74LS245`, `74LS373`, latch/buffer choices | `10 x 4` |
| DIP-28 wide | `6264`, `62256`, EEPROM | `14 x 7` |
| DIP-40 wide | `8085A` | `20 x 7` |

## Board A Worksheet

Role: CPU, clock/reset, latch, transceiver, coarse decode, bus breakout.

### Planned Placements

| Ref | Function | Package | Pin-1 origin | Orientation | Notes |
|---|---|---|---|---|---|
| `U1` | `8085A` CPU | DIP-40 wide | `X39, Y16` | `E-W` | keep central |
| `U2` | `74LS373` address latch | DIP-20 narrow | `X17, Y16` | `E-W` | bus-side pins face CPU |
| `U3` | `74LS245` data buffer | DIP-20 narrow | `X70, Y16` | `E-W` | short shared-data path |
| `U4` | `74LS138` coarse decode | DIP-16 narrow | `X72, Y24` | `E-W` | decode fan-out toward bus lane |
| `U5` | `74LS04` clock/reset glue | DIP-14 narrow | `X73, Y8` | `E-W` | keep clear of bus bundles |
| `Y1` | crystal | 2-pin oscillator part | `X61, Y8` | `E-W` | adjacent to `U5` |
| `SW1` | reset pushbutton | panel or PCB pushbutton | `X54, Y8` | `E-W` | top-edge access |
| `TP1-TP6` | `CLK`, `ALE`, `/RD`, `/WR`, `IO/M`, `/RESET_OUT` | test posts | `X10-X40, Y3` | row | leave clip clearance |
| `J1` | board bus header / service header | 2-row header | `X84, Y26` | vertical | export shared bus |
| `Cbulk` | board bulk capacitor | radial | `X4, Y31` | n/a | near power entry |

### Routing Intent

- `AD0-AD7` should stay between `U1` and `U2`.
- `D0-D7` shared path should stay between `U1` and `U3`.
- `CLK` and reset traces should stay in the upper-right quiet zone.
- Bus breakout should drop into `J1` without crossing the top test-point strip.

## Board B Worksheet

Role: program RAM, monitor ROM, learned-state memory, decode, MMA/MMD path.

### Planned Placements

| Ref | Function | Package | Pin-1 origin | Orientation | Notes |
|---|---|---|---|---|---|
| `U1` | `62256` main memory | DIP-28 wide | `X37, Y10` | `E-W` | dominant board feature |
| `U2` | `74LS138` region decode | DIP-16 narrow | `X13, Y20` | `E-W` | close to bus ingress |
| `U3` | `74LS139` subdecode | DIP-16 narrow | `X24, Y20` | `E-W` | pairs with `U2` |
| `U4` | MMA low latch | DIP-20 narrow | `X48, Y20` | `E-W` | close to lower memory address side |
| `U5` | MMA high latch | DIP-20 narrow | `X60, Y20` | `E-W` | close to upper memory address side |
| `U6` | MMD path register / gate | DIP-20 narrow | `X73, Y20` | `E-W` | keep close to `U1` data side |
| `U7` | `6264` program RAM | DIP-28 wide | `X12, Y28` | `E-W` | selected part `Alliance AS6C6264-55PCN`; easy to isolate during bring-up |
| `U8` | EEPROM / monitor ROM | DIP-28 wide | `X61, Y28` | `E-W` | opposite side from program RAM |
| `TP1-TP8` | `/PRG_RAM_CS`, `/ROM_CS`, `/MMA_L_CS`, `/MMA_H_CS`, `/MMD_CS`, `MMA0`, `MMA8`, `D0` | test posts | `X10-X50, Y3` | row | keep contiguous |
| `J1` | bus in / service header | 2-row header | `X84, Y26` | vertical | one clean ingress point |
| `Cbulk` | board bulk capacitor | radial | `X4, Y31` | n/a | near power entry |

### Routing Intent

- `U4` and `U5` should sit adjacent to the `62256` address side.
- `U6` should sit on the `62256` data side with a short read/write gate path.
- `U7` and `U8` should route down toward the lower bus band rather than across `U1`.
- Decode outputs should fan from left to right, not back through the bus lane.

### Board B ZIF Clearance Note

If you choose `3 x 28-pin ZIFs` on Board B, treat `U1`, `U7`, and `U8` as **clearance footprints**, not just DIP bodies.

- keep at least one empty hole row around each of `U1`, `U7`, and `U8` where practical
- do not place tall headers, posts, or electrolytics immediately beside the ZIF lever side
- keep the area above `U7` and `U8` free of tie-downs or harness crossings
- leave `J1` wiring low and to the right so it does not interfere with the `U8` lever

The current Board B placement is acceptable for `3 x 28-pin ZIFs`, but only if we preserve those three memory areas as no-crowding zones during final socket placement.

## Board C Worksheet

Role: bench inputs, random source, output latch, LED observability, local decode.

### Planned Placements

| Ref | Function | Package | Pin-1 origin | Orientation | Notes |
|---|---|---|---|---|---|
| `SW1` | `ENVL` DIP switch pack | 8-position DIP switch | `X8, Y17` | `E-W` | operator access |
| `SW2` | `ENVH` optional DIP switch | 8-position DIP switch | `X8, Y27` | `E-W` | can leave unpopulated |
| `U1` | input buffer | DIP-20 narrow | `X29, Y17` | `E-W` | between switches and bus |
| `U2` | output latch | DIP-20 narrow | `X49, Y17` | `E-W` | short path to LEDs |
| `U3` | local decode | DIP-16 narrow | `X29, Y27` | `E-W` | local register select |
| `U4` | `TSWR` LFSR / random source | DIP-14 narrow | `X49, Y9` | `E-W` | distinct top-center block |
| `LED1-LED8` | `ACTL` LED row | LED bar or discrete row | `X73, Y17` | vertical row | keep readable |
| `LED9-LED16` | debug / `ACTH` row | LED bar or discrete row | `X73, Y27` | vertical row | optional second bank |
| `TP1-TP4` | `ENVL`, `TSWR`, `ACTL`, `spare` | test posts | `X10-X28, Y3` | row | top edge probing |
| `JP1-JP3` | mode / readback jumpers | 0.1" jumpers | `X74-X86, Y3` | row | configurable behavior |
| `J1` | bus in / service header | 2-row header | `X84, Y31` | vertical | lower-right ingress |
| `Cbulk` | board bulk capacitor | radial | `X4, Y31` | n/a | near power entry |

### Routing Intent

- Manual inputs stay left.
- Decode and buffering stay central.
- Visual outputs stay right.
- `TSWR` stays above the switch path so it does not get lost in LED or pull-up wiring.

## Board-to-Board Cable Worksheet

Use two main cable groups and one optional service group.

| Cable | Source | Destination | Signals |
|---|---|---|---|
| `CAB-A-B` | Board A `J1` | Board B `J1` | `A0-A15`, `D0-D7`, `/RD`, `/WR`, `IO/M`, `/RESET_OUT`, `+5V`, `GND` |
| `CAB-A-C` | Board A `J1` | Board C `J1` | `A0-A15`, `D0-D7`, `/RD`, `/WR`, `IO/M`, `/RESET_OUT`, `+5V`, `GND` |
| `CAB-SVC` optional | Board A service header | Board B/C service posts | `CLK`, `ALE`, `READY`, spare debug lines |

## Practical Build Order

1. Mark the power lane, bus lane, top service strip, and bottom connector band on all three boards.
2. Place only the largest sockets first: `8085A`, `62256`, `6264`, EEPROM, and the two main central latches.
3. Dry-fit headers and test-post rows before soldering sockets permanently.
4. Confirm wrap-tool hand clearance around `U1` on each board.
5. Add decouplers and bulk capacitors before any dense signal wrapping.

## Swap / ZIF Strategy

These are the devices most worth isolating for swap testing:

| Priority | Ref | Device | Recommendation | Reason |
|---|---|---|---|---|
| `1` | `U8` | EEPROM / monitor ROM | use a **ZIF on top of a machine-pin wire-wrap socket** | most likely image-swapped device during bring-up |
| `2` | `U7` | `6264` program RAM | use a **ZIF on top of a machine-pin wire-wrap socket** if you have one | useful for RAM substitution and fault isolation |
| `3` | `U1` Board A | `8085A` CPU | keep mechanically isolated and consider ZIF only if you expect CPU swapping | helpful if testing multiple 8085s, but ZIF height and lever access matter |
| `4` | `U1` Board B | `62256` main memory | normal wire-wrap socket is fine unless you expect repeated memory experiments | usually less frequently swapped than ROM or program RAM |

Recommended default:

- definitely ZIF: `U8` EEPROM
- good candidate for ZIF: `U7` program RAM
- optional ZIF: `Board A U1` `8085A`
- usually leave normal: `Board B U1` `62256`

If you are committing to `3 x 28-pin ZIFs` on Board B, promote `Board B U1` from optional to planned and preserve clearance around all three memory positions from the start.

Mechanical caution:

- A ZIF should plug into a **machine-pin/socket-pin carrier**, not directly into fragile loose headers.
- For Board B, the intended stack is: **Vector board -> soldered machine-pin wire-wrap socket -> plugged-in 28-pin ZIF -> device under test**.
- Leave extra side clearance for the ZIF lever, especially around `Board A U1` and `Board B U8`.
- On the current layout, `Board B U8` is the cleanest ZIF location, `Board B U7` is also reasonable, and `Board B U1` is workable if its surrounding wrap field is kept open.

## Assumptions and Cautions

- These are **first-pass placement coordinates**, not museum-faithful original socket locations.
- `U4-U6` on Board B and `U1-U4` on Board C are defined by role and package size; exact part substitutions may shift placement by a hole or two.
- If you decide to move EEPROM to Board A later, Board B has enough room to reclaim that block as a debug header or wider MMD section.
- Before committing to wrap, it would still be smart to print this worksheet and do one paper overlay against the actual `8801-6`.
