## The physical characteristics of this robot

The robot chassis is based on this diagram:

![base](/spr-book/0400-1.png)

Where the disk is 457 mm (18").

With an upward construct to hold the boards:

![rack](/spr-book/0400-2.png)

Re-contemplating the design architecture: Grok analyzed the photos and has come-up with his estimate, given the information regarding Vector 8801 boards that are mounted internally:

* Width: 280 mm
* Depth: 280 mm
* Height: 360 mm
* Weight: 23 kg

### The Vector board 8801-6 using a S-100 bus

![8801-6](/design/vector-8801-6.gif)

_Specification_

| Dimensions  (H x W x Thick) | 10.50" x 5.30" x 0.062"  (266.7mm x 134.6mm x 1.57mm) |
|-----------------------------|-------------------------------------------------------|
| Hole Diameter               | 0.042" (1.067mm) Plated Thru                          |
| Grid                        | 0.100" x 0.100" square  (2.54mm x 2.54mm)             |
| Circuit Pattern             | Pad per hole - both sides                             |
| Material                    | FR4                                                   |
| UL Flammability Class       | 94V-0                                                 |
| 16 Pin DIP Capacity         | 80                                                    |
| Wire-Wrap Terminals         | T125, T126                                            |
| Wire-Wrap Socket Pins       | R32                                                   |
| Solder Connector            | R681-3                                                |
| Wire-Wrap Connector         | R681-2                                                |

_Description_

* 100 Gold plated edge contacts (50 each side) on 0.125"(3.175mm) centers
* Pad per hole (square) both sides
* I/O mounting area for ribbon cable header
* Row and column legends provided
* S-100 Form Factor
* Pin `1` and `51` committed to power.
* Pin `50` and `100` committed to ground.

### Grok-generated 3D printing design suggestions

The textual description is [here](/design/GROK.md), while details of FreeCAD design are [here](/design/PRINT.md).