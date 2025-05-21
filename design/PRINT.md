# 3D Printed Robot Design in FreeCAD

This guide provides a step-by-step process to design a 3D printable robot in FreeCAD, based on a circular base of 18 inches and a card rack for Vector 8801-6 S-100 bus boards. The components will be designed as separate parts, which can be exported as STL files for 3D printing.

* If safety has primacy, have a look at thickness increase and ribbing discussed [here](/design/SAFETY.md).
* Look at the analysis of two thicknesses of the disk and skirt [here](/design/FILAMENT.md).
* For a total caluclation of the amount of PLA required for the infrastructure, see [here](/design/TOTAL.md).

## Project Overview: Robot Components

The robot consists of the following parts to be 3D printed:

1. **Bottom Plate + Skirt**:
   - Bottom Plate: 18-inch (457.2 mm) diameter, 0.5-inch (12.7 mm) thick.
   - Skirt: 18-inch (457.2 mm) outer diameter, 2-inch (50.8 mm) height, 0.25-inch (6.35 mm) thick.
2. **Card Rack Assembly**:
   - Dimensions: 11 inches × 11 inches × 13 inches (279.4 mm × 279.4 mm × 330.2 mm).
   - Includes vertical supports, top/bottom frames, and two shelves.
3. **Rack Mounts**: 4 L-shaped brackets, each 2 inches × 2 inches (50.8 mm × 50.8 mm), 0.5-inch (12.7 mm) thick, 1-inch (25.4 mm) height.
4. **Wheels**: 4 wheels, each 3.5 inches (88.9 mm) in diameter, 1-inch (25.4 mm) wide.

## Designing in FreeCAD

FreeCAD uses a parametric modeling approach, where you create sketches and extrude or cut them to form 3D objects. We'll use the **Part Design workbench** for most components. All measurements are in millimeters, as FreeCAD defaults to metric units.

### Step-by-Step Design in FreeCAD

#### 1. Bottom Plate + Skirt

**Bottom Plate**:
- **Shape**: Circular disc.
- **Dimensions**:
  - Diameter: 457.2 mm (18 inches).
  - Thickness: 12.7 mm (0.5 inches).
- **Steps**:
  1. Open FreeCAD and switch to the **Part Design workbench**.
  2. Create a new document (`File > New`).
  3. Click **Create a new sketch** and select the XY plane.
  4. In the sketcher:
     - Draw a circle centered at the origin (0,0) with a diameter of 457.2 mm (radius = 228.6 mm).
     - Click **Close** to finish the sketch.
  5. With the sketch selected, click **Pad** (extrude) in the Part Design toolbar:
     - Set the length to 12.7 mm.
     - Click **OK** to create the disc.
- **Features** (Mounting Holes):
  - **Wheel Holes** (4 holes, evenly spaced, 90 degrees apart, near the edge):
    1. Create a new sketch on the top face of the disc.
    2. Draw 4 circles (6.35 mm diameter for axles) at 90-degree intervals, 20 mm from the edge:
       - Use a construction circle (radius = 208.6 mm, i.e., 228.6 mm - 20 mm) to position the holes.
       - Place circles at (208.6, 0), (0, 208.6), (-208.6, 0), (0, -208.6).
       - Set each circle’s diameter to 6.35 mm.
    3. Close the sketch and use **Pocket** to cut the holes through the disc.
  - **Rack Mount Holes** (4 holes at the corners of an 11-inch × 11-inch square, centered):
    1. Create a new sketch on the top face.
    2. Draw 4 circles (6.35 mm diameter) at (±139.7 mm, ±139.7 mm), corresponding to the rack’s 279.4 mm × 279.4 mm footprint.
    3. Use **Pocket** to cut the holes through.

**Skirt**:
- **Shape**: Cylindrical ring.
- **Dimensions**:
  - Outer Diameter: 457.2 mm.
  - Inner Diameter: 444.5 mm (457.2 mm - 2 × 6.35 mm).
  - Height: 50.8 mm.
- **Steps**:
  1. Create a new sketch on the top face of the bottom plate.
  2. Draw two concentric circles: one at 457.2 mm diameter (radius = 228.6 mm), another at 444.5 mm diameter (radius = 222.25 mm).
  3. Close the sketch.
  4. Use **Pad** to extrude the ring by 50.8 mm.
- **Combine**: The skirt and bottom plate can be modeled as one body in FreeCAD, or as separate bodies combined later using **Part > Boolean > Union**.

**Splitting for Printing**:
- An 18-inch (457.2 mm) diameter part is too large for most 3D printers (e.g., a 220 mm × 220 mm bed). Split the model into 4 quadrants:
  1. Create a new sketch on the XY plane.
  2. Draw two lines (one along the X-axis, one along the Y-axis) to divide the circle into 4 quadrants.
  3. Use **Part > Split > Slice** to split the model into 4 parts.
  4. Add connectors (e.g., small dovetail joints or screw holes) along the edges:
     - For dovetails, sketch trapezoids (e.g., 10 mm wide, 5 mm deep) on the cut edges and extrude/cut to form interlocking joints.
     - For screw holes, add 4 mm diameter holes on each quadrant’s edge for M4 bolts.

#### 2. Card Rack Assembly

**Frame**:
- **Dimensions**:
  - Overall: 279.4 mm × 279.4 mm × 330.2 mm.
- **Components**:
  - **Vertical Supports**: 4 beams, 12.7 mm × 12.7 mm, 330.2 mm tall.
  - **Top/Bottom Frames**: 279.4 mm × 279.4 mm, 12.7 mm thick.
  - **Shelves**: 2 shelves, 279.4 mm × 279.4 mm, 6.35 mm thick.
- **Steps**:
  1. **Vertical Supports**:
     - Create a new body (`Part Design > Create body`).
     - Create a sketch on the XY plane.
     - Draw a 12.7 mm × 12.7 mm square, centered at (139.7 mm, 139.7 mm) for one corner.
     - Pad the square by 330.2 mm.
     - Copy this body 3 times (use **Part Design > Transform > Linear Pattern**):
       - Place at (±139.7 mm, ±139.7 mm) to form the 4 corners.
  2. **Bottom Frame**:
     - Create a new body.
     - Sketch on the XY plane a 279.4 mm × 279.4 mm square with a 12.7 mm thickness (inner square at 253.9 mm × 253.9 mm).
     - Pad by 12.7 mm.
     - Add 4 mounting holes (6.35 mm diameter) at (±139.7 mm, ±139.7 mm) to match the bottom plate.
  3. **Top Frame**:
     - Repeat the bottom frame process, but move the body to Z = 317.5 mm (330.2 mm - 12.7 mm) using **Part Design > Transform > Translate**.
  4. **Shelves**:
     - Create a new body.
     - Sketch on the XY plane a 279.4 mm × 279.4 mm square.
     - Pad by 6.35 mm.
     - Move to Z = 203.2 mm (above the battery section).
     - Copy and move the second shelf to Z = 260.35 mm (203.2 mm + 50.8 mm + 6.35 mm).
- **Features**:
  - Add slots for 100-pin S-100 connectors on the back of each shelf:
    - Create a sketch on the back edge of each shelf.
    - Draw a 266.7 mm × 5 mm rectangle, centered.
    - Use **Pocket** to cut the slot through.
- **Combine**: Use **Part > Boolean > Union** to combine all parts into one body, or keep them separate for modular assembly.

**Printing Note**: Each component (supports, frames, shelves) should fit on a standard print bed (e.g., 220 mm × 220 mm). Print separately and assemble with screws or glue.

#### 3. Rack Mounts

- **Shape**: 4 L-shaped brackets.
- **Dimensions**:
  - Each leg: 50.8 mm × 50.8 mm.
  - Thickness: 12.7 mm.
  - Height: 25.4 mm.
- **Steps**:
  1. Create a new body.
  2. Sketch on the XY plane an L-shape: two 50.8 mm legs, 12.7 mm thick.
  3. Pad by 25.4 mm.
  4. Add two 6.35 mm diameter holes (one on each leg, centered, 25.4 mm from the corner) for bolts:
     - Create a sketch on the top face, draw the circles, and use **Pocket** to cut through.
  5. Copy to create 4 brackets (use **Linear Pattern**).
- **Printing Note**: These small parts can be printed with 50-75% infill for strength.

#### 4. Wheels

- **Dimensions**:
  - Diameter: 88.9 mm.
  - Width: 25.4 mm.
- **Steps**:
  1. Create a new body.
  2. Sketch on the XY plane a circle with a diameter of 88.9 mm.
  3. Pad by 25.4 mm to create a cylinder.
  4. Add an axle hole:
     - Sketch a 6.35 mm diameter circle at the center on one face.
     - Use **Pocket** to cut through.
  5. (Optional) Add a tread pattern:
     - Sketch small rectangles (e.g., 5 mm × 3 mm) around the outer edge, evenly spaced.
     - Pad or pocket to create a grip pattern.
  6. Copy to create 4 wheels.
- **Printing Note**: Print with 50% infill for durability.

## Exporting STL Files in FreeCAD

Once each component is modeled:

1. Select the body (or combined body) in the model tree.
2. Go to `File > Export`.
3. Choose **STL** as the file format.
4. Save the file.
5. Repeat for each component (e.g., bottom plate quadrant 1, quadrant 2, etc., rack supports, shelves, mounts, wheels).

## Printing Recommendations

- **Material**: PLA or PETG for most parts; ABS or nylon for wheels if durability is needed.
- **Infill**: 20-30% for the base and rack, 50-75% for mounts and wheels.
- **Supports**: Enable supports for the skirt and any overhangs (e.g., shelves, tread patterns).
- **Assembly**: Use M4 bolts for the mounting holes, or glue parts together if preferred.

## Summary

Using FreeCAD, you can design the robot components as described above. The process involves creating sketches, extruding them into 3D shapes, adding features like holes and slots, and splitting large parts (like the base) for printing. Once designed, export each part as an STL file for 3D printing. For additional help with FreeCAD tools or settings, refer to the FreeCAD documentation or community forums.