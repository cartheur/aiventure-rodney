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

# 3D Printed Model Suggestion for Robot with 18-Inch Circular Base

This model is designed for a robot with an 18-inch circular base, incorporating a card rack assembly to fit Vector 8801-6 S-100 bus boards (10.5 inches × 5.3 inches). The design is modular to facilitate 3D printing on standard printers.

## Key Dimensions and Components

### Circular Base (Bottom Plate with Skirt)
- **Bottom Plate**:
  - Shape: Circular disc
  - Diameter: 18 inches (457.2 mm)
  - Thickness: 0.5 inches (12.7 mm)
- **Skirt**:
  - Shape: Cylindrical ring
  - Outer Diameter: 18 inches (457.2 mm)
  - Height: 2 inches (50.8 mm)
  - Thickness: 0.25 inches (6.35 mm)
- **Features**:
  - Mounting holes for 4 wheels (4-inch diameter cutouts for 3.5-inch wheels).
  - Holes for rack mounts, spaced for an 11-inch × 11-inch rack footprint, centered on the plate.

### Card Rack Assembly
- **Dimensions**:
  - Width: 11 inches (279.4 mm)
  - Depth: 11 inches (279.4 mm)
  - Height: 13 inches (330.2 mm)
- **Structure**:
  - Frame: Rectangular with 0.5-inch (12.7 mm) thick vertical supports.
  - Shelves: Two shelves for circuit boards:
    - Spacing: 2 inches (50.8 mm) between shelves.
    - Position: One at 8 inches (203.2 mm) from the bottom (above battery section), another at 10 inches (254 mm).
    - Shelf Thickness: 0.25 inches (6.35 mm).
  - 100-Pin Connectors: Space for S-100 bus connectors (10.5 inches long) at the back of each shelf.
- **Features**:
  - Open sides for wiring access.
  - Mounting points at the bottom for attachment to the bottom plate.

### Rack Mounts
- **Shape**: 4 L-shaped brackets.
- **Dimensions**:
  - Each bracket: 2 inches × 2 inches (50.8 mm × 50.8 mm), 0.5 inches (12.7 mm) thick.
  - Height: 1 inch (25.4 mm).
- **Features**:
  - Holes for bolts to attach to the bottom plate and rack.

### Wheels (Optional)
- **Dimensions**:
  - Diameter: 3.5 inches (88.9 mm)
  - Width: 1 inch (25.4 mm)
- **Features**:
  - Axle hole: 0.25-inch (6.35 mm) diameter.
- **Quantity**: 4 wheels.

## Assembly Notes
- **Base Assembly**: Attach the skirt to the bottom plate (glue or screw segments if printed separately). Mount wheels to the underside using axles and bearings.
- **Rack Assembly**: Assemble the frame (vertical supports, top/bottom frames, shelves) and attach S-100 connectors (sourced separately).
- **Mounting**: Secure the rack to the bottom plate using the rack mounts.
- **Additional Components**: Source the battery, Vector 8801-6 boards, wiring, and sensors separately.

## 3D Printing Suggestions
- **Material**: PLA or PETG for most parts; ABS or nylon for wheels if durability is needed.
- **Infill**:
  - Base and rack frame: 20-30%
  - Rack mounts and wheels: 50-75%
- **Supports**: Needed for the skirt and some rack components (e.g., shelves).
- **Print Bed Size**: If smaller than 18 inches, print the base in 4 quadrants (~9 inches wide each). Rack components and wheels fit on standard beds (e.g., 220 mm × 220 mm).

### Model Breakdown for Printing
1. **Bottom Plate + Skirt**:
   - 4 quadrants, each ~9 inches (228.6 mm) wide.
   - Skirt printed separately or in segments.
2. **Card Rack Assembly**:
   - 4 vertical supports (13 inches tall).
   - Top/bottom frames (11 inches × 11 inches).
   - 2 shelves (11 inches × 11 inches).
3. **Rack Mounts**: 4 L-shaped brackets.
4. **Wheels**: 4 wheels, 3.5 inches in diameter.

## Scaling Considerations
If the 18-inch base is too large, scale down to 75% (base becomes 13.5 inches), but this may make the rack too small for the Vector 8801-6 boards. Instead, print the rack at 100% scale and adjust the base and mounts accordingly.

## Summary
This model includes an 18-inch diameter base with a 2-inch skirt, a card rack (11 inches × 11 inches × 13 inches) for S-100 boards, 4 rack mounts, and 4 wheels (3.5 inches in diameter). It’s designed for modular printing and assembly, with additional components (S-100 connectors, battery, boards) sourced separately.