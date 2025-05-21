# PLA Filament Requirement for Circular Plate Designs

This document calculates the amount of PLA filament (1.75 mm diameter) required to 3D print the circular bottom plate and skirt of a robot, considering two design options for the plate's thickness: 0.5 inches and 0.75 inches. The calculation accounts for the volume of material, infill percentage, and typical 3D printing settings.

## Design Specifications

- **Circular Plate (Bottom Plate)**:
  - Diameter: 18 inches (457.2 mm).
  - Thickness Options:
    - Design 1: 0.5 inches (12.7 mm).
    - Design 2: 0.75 inches (19.05 mm, recommended for a higher safety factor).
- **Skirt** (attached to the plate):
  - Outer Diameter: 18 inches (457.2 mm).
  - Height: 2 inches (50.8 mm).
  - Thickness: 0.25 inches (6.35 mm).
- **Material**: PLA.
  - **Density**: 1.24 g/cm³ (1240 kg/m³).
- **Filament**: 1.75 mm diameter PLA filament.
  - Cross-sectional area = π × (0.875 mm)² = 2.405 mm².
  - Mass per unit length = 2.405 mm² × 1 mm × 1.24 g/cm³ = 0.002982 g/mm = 2.982 g/m.
- **Infill Percentage**: 20% infill for the plate and skirt (common for structural parts). Outer shells and top/bottom layers are solid (100% infill).

## Step 1: Volume of the Circular Plate and Skirt

### Circular Plate (Bottom Plate)

- **Area of the Plate**:
  - Radius = 457.2 mm / 2 = 228.6 mm.
  - Area = π × (228.6 mm)² = 164,021.7 mm².
- **Volume for Design 1 (0.5 inches = 12.7 mm thick)**:
  - Volume = 164,021.7 mm² × 12.7 mm = 2,083,075.6 mm³ = 2,083.08 cm³.
- **Volume for Design 2 (0.75 inches = 19.05 mm thick)**:
  - Volume = 164,021.7 mm² × 19.05 mm = 3,124,613.4 mm³ = 3,124.61 cm³.

### Skirt

- **Dimensions**:
  - Outer Diameter: 457.2 mm (radius = 228.6 mm).
  - Inner Diameter: 457.2 mm - 2 × 6.35 mm = 444.5 mm (inner radius = 222.25 mm).
  - Height: 50.8 mm.
- **Volume**:
  - Outer Area = π × (228.6 mm)² = 164,021.7 mm².
  - Inner Area = π × (222.25 mm)² = 155,026.7 mm².
  - Cross-sectional Area = 164,021.7 mm² - 155,026.7 mm² = 8,995 mm².
  - Volume = 8,995 mm² × 50.8 mm = 456,946 mm³ = 456.95 cm³.

### Total Volume (Plate + Skirt)

- **Design 1 (0.5-inch thick plate)**:
  - Total Volume = 2,083.08 cm³ + 456.95 cm³ = 2,540.03 cm³.
- **Design 2 (0.75-inch thick plate)**:
  - Total Volume = 3,124.61 cm³ + 456.95 cm³ = 3,581.56 cm³.

## Step 2: Adjust for Infill and Shells

In 3D printing, the part has an infill structure (20% infill) with solid outer shells and top/bottom layers. Let’s calculate the effective PLA volume.

### Shells and Top/Bottom Layers

- **Shells (Outer Walls)**:
  - Assume 3 perimeter shells (wall thickness = 0.4 mm per shell, so 3 shells = 1.2 mm).
  - **Outer Shell Volume**:
    - Outer circumference = π × 457.2 mm = 1,436.5 mm.
    - Height (Design 1) = 50.8 mm + 12.7 mm = 63.5 mm.
    - Height (Design 2) = 50.8 mm + 19.05 mm = 69.85 mm.
    - Volume (Design 1) = 1,436.5 mm × 63.5 mm × 1.2 mm = 109,471.5 mm³ = 109.47 cm³.
    - Volume (Design 2) = 1,436.5 mm × 69.85 mm × 1.2 mm = 120,409.7 mm³ = 120.41 cm³.
  - **Inner Shell Volume** (inside the skirt):
    - Inner circumference = π × 444.5 mm = 1,396.9 mm.
    - Volume (Design 1) = 1,396.9 mm × 63.5 mm × 1.2 mm = 106,466.6 mm³ = 106.47 cm³.
    - Volume (Design 2) = 1,396.9 mm × 69.85 mm × 1.2 mm = 117,084.2 mm³ = 117.08 cm³.
- **Top and Bottom Layers**:
  - Assume 4 solid layers (0.2 mm per layer, so 4 × 0.2 mm = 0.8 mm per side).
  - Top/Bottom Area = 164,021.7 mm².
  - Volume per side = 164,021.7 mm² × 0.8 mm = 131,217.4 mm³ = 131.22 cm³.
  - Total Top + Bottom = 131.22 cm³ × 2 = 262.44 cm³ (same for both designs).

### Infill Volume

- **Infill Percentage**: 20%.
- **Design 1**:
  - Total Volume = 2,540.03 cm³.
  - Subtract shells and top/bottom: 2,540.03 cm³ - (109.47 cm³ + 106.47 cm³ + 262.44 cm³) = 2,061.65 cm³.
  - Infill Volume = 0.2 × 2,061.65 cm³ = 412.33 cm³.
- **Design 2**:
  - Total Volume = 3,581.56 cm³.
  - Subtract shells and top/bottom: 3,581.56 cm³ - (120.41 cm³ + 117.08 cm³ + 262.44 cm³) = 3,081.63 cm³.
  - Infill Volume = 0.2 × 3,081.63 cm³ = 616.33 cm³.

### Total PLA Volume (Shells + Top/Bottom + Infill)

- **Design 1**:
  - Total = 109.47 cm³ + 106.47 cm³ + 262.44 cm³ + 412.33 cm³ = 890.71 cm³.
- **Design 2**:
  - Total = 120.41 cm³ + 117.08 cm³ + 262.44 cm³ + 616.33 cm³ = 1,116.26 cm³.

## Step 3: Convert Volume to Filament Length

- **Mass of PLA**:
  - Density = 1.24 g/cm³.
  - **Design 1**: Mass = 890.71 cm³ × 1.24 g/cm³ = 1,104.48 g.
  - **Design 2**: Mass = 1,116.26 cm³ × 1.24 g/cm³ = 1,384.16 g.
- **Filament Length**:
  - Mass per meter of 1.75 mm filament = 2.982 g/m.
  - **Design 1**: Length = 1,104.48 g / 2.982 g/m = 370.31 m.
  - **Design 2**: Length = 1,384.16 g / 2.982 g/m = 464.24 m.

## Final Answer

- **Design 1 (0.5-inch thick plate)**:
  - PLA Required: **890.71 cm³**, equivalent to **370.31 meters** of 1.75 mm filament.
- **Design 2 (0.75-inch thick plate)**:
  - PLA Required: **1,116.26 cm³**, equivalent to **464.24 meters** of 1.75 mm filament.

## Notes

- **Accuracy**: This assumes 20% infill, 3 perimeter shells, and 4 top/bottom layers. Adjusting these settings (e.g., infill percentage, shell count, layer height) will change filament usage.
- **Practical Considerations**:
  - A standard 1 kg spool of PLA filament is ~330 meters (for 1.75 mm filament).
  - **Design 1** requires slightly more than one spool (~1.12 spools).
  - **Design 2** requires about 1.4 spools.
  - Account for potential waste (e.g., failed prints, support material) by adding 10-20% extra filament.
- **Splitting the Plate**: The 18-inch diameter plate is too large for most 3D printers, so it’s designed to be printed in 4 quadrants. Filament usage per quadrant is roughly 1/4 of the total, plus a small amount for connectors (e.g., dovetail joints or screw holes).

This estimate provides the material requirements for printing the circular plate and skirt for both design options.