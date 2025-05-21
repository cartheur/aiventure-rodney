# PLA Filament Requirement for All 3D Printed Robot Parts

This document clarifies the scope of the previous PLA filament estimate and provides a revised calculation for the total amount of 1.75 mm PLA filament required to 3D print all parts of the robot, including the circular bottom plate, skirt, card rack assembly, rack mounts, and wheels. The calculations use a 20% infill, 3 perimeter shells, 4 top/bottom layers, and PLA material properties.

## Clarification of Previous Estimate

The previous estimate focused **only on the circular bottom plate and the attached skirt**:
- **Circular Plate (Bottom Plate)**:
  - Two thickness options: 0.5 inches (12.7 mm) and 0.75 inches (19.05 mm).
- **Skirt**:
  - Height: 2 inches (50.8 mm), Thickness: 0.25 inches (6.35 mm).
- **Filament Usage** (20% infill, 3 shells at 0.4 mm each, 4 top/bottom layers at 0.2 mm each):
  - **Design 1 (0.5-inch thick plate)**: 890.71 cm³, or 370.31 meters of 1.75 mm filament.
  - **Design 2 (0.75-inch thick plate)**: 1,116.26 cm³, or 464.24 meters of 1.75 mm filament.

This estimate did **not** include the card rack assembly, rack mounts, or wheels, as the focus was on the circular plate and skirt in the context of structural analysis and material requirements for that specific component.

## Revised Estimate: Including All Parts

Below is the total PLA filament required for all 3D printed parts of the robot, using the same assumptions:
- **Material**: PLA (density: 1.24 g/cm³).
- **Filament**: 1.75 mm diameter (mass per unit length = 2.982 g/m).
- **Infill**: 20% for all parts.
- **Shells**: 3 perimeters (1.2 mm total thickness).
- **Top/Bottom Layers**: 4 layers per side (0.8 mm total per side).

### 1. Circular Plate + Skirt (Recap)

- **Design 1 (0.5-inch thick plate)**: 890.71 cm³ (370.31 m).
- **Design 2 (0.75-inch thick plate)**: 1,116.26 cm³ (464.24 m).

### 2. Card Rack Assembly

- **Dimensions**:
  - Overall: 11 inches × 11 inches × 13 inches (279.4 mm × 279.4 mm × 330.2 mm).
- **Components**:
  - **Vertical Supports**: 4 beams, each 12.7 mm × 12.7 mm × 330.2 mm.
  - **Top/Bottom Frames**: 2 frames, each 279.4 mm × 279.4 mm with a 12.7 mm thick border (inner dimensions 253.9 mm × 253.9 mm).
  - **Shelves**: 2 shelves, each 279.4 mm × 279.4 mm × 6.35 mm.
- **Volume**:
  - **Vertical Supports**:
    - Volume per support = 12.7 mm × 12.7 mm × 330.2 mm = 53,239.3 mm³ = 53.24 cm³.
    - Total for 4 supports = 4 × 53.24 cm³ = 212.96 cm³.
  - **Top/Bottom Frames**:
    - Outer Area = 279.4 mm × 279.4 mm = 78,064.4 mm².
    - Inner Area = 253.9 mm × 253.9 mm = 64,465.2 mm².
    - Frame Area = 78,064.4 mm² - 64,465.2 mm² = 13,599.2 mm².
    - Volume per frame = 13,599.2 mm² × 12.7 mm = 172,709.8 mm³ = 172.71 cm³.
    - Total for 2 frames = 2 × 172.71 cm³ = 345.42 cm³.
  - **Shelves**:
    - Area = 78,064.4 mm².
    - Volume per shelf = 78,064.4 mm² × 6.35 mm = 495,709.0 mm³ = 495.71 cm³.
    - Total for 2 shelves = 2 × 495.71 cm³ = 991.42 cm³.
- **Total Volume (Solid)**:
  - Total = 212.96 cm³ + 345.42 cm³ + 991.42 cm³ = 1,549.80 cm³.
- **Shells and Top/Bottom Layers**:
  - **Shells** (3 shells, 1.2 mm thick):
    - Perimeter (approximate as a square) = 4 × 279.4 mm = 1,117.6 mm.
    - Height = 330.2 mm.
    - Outer Shell Volume = 1,117.6 mm × 330.2 mm × 1.2 mm = 442,833.8 mm³ = 442.83 cm³.
    - Inner Shell Volume (inner perimeter ≈ 4 × 253.9 mm = 1,015.6 mm) = 1,015.6 mm × 330.2 mm × 1.2 mm = 402,464.6 mm³ = 402.46 cm³.
  - **Top/Bottom Layers** (4 layers, 0.8 mm per side):
    - Area = 78,064.4 mm².
    - Volume per side = 78,064.4 mm² × 0.8 mm = 62,451.5 mm³ = 62.45 cm³.
    - Total = 62.45 cm³ × 2 = 124.90 cm³.
  - **Shelves (Top/Bottom Layers)**:
    - Each shelf: 2 shelves × 2 × 62.45 cm³ = 249.80 cm³.
- **Infill Volume**:
  - Total Volume = 1,549.80 cm³.
  - Subtract shells and top/bottom: 1,549.80 cm³ - (442.83 cm³ + 402.46 cm³ + 124.90 cm³ + 249.80 cm³) = 329.81 cm³.
  - Infill Volume = 0.2 × 329.81 cm³ = 65.96 cm³.
- **Total PLA Volume for Rack**:
  - Total = 442.83 cm³ + 402.46 cm³ + 124.90 cm³ + 249.80 cm³ + 65.96 cm³ = 1,285.95 cm³.

### 3. Rack Mounts

- **Dimensions**:
  - 4 L-shaped brackets, each leg 50.8 mm × 50.8 mm, thickness 12.7 mm, height 25.4 mm.
- **Volume**:
  - Volume per bracket (approximate as two prisms, subtract overlap):
    - Each leg = 50.8 mm × 12.7 mm × 25.4 mm = 16,388.5 mm³ = 16.39 cm³.
    - Total per bracket = 2 × 16.39 cm³ - (12.7 mm × 12.7 mm × 25.4 mm) = 32.78 cm³ - 4.10 cm³ = 28.68 cm³.
    - Total for 4 brackets = 4 × 28.68 cm³ = 114.72 cm³.
- **Shells** (3 shells, 1.2 mm thick):
  - Perimeter (L-shape) = 2 × (50.8 mm + 25.4 mm) = 152.4 mm.
  - Height = 12.7 mm.
  - Outer Shell Volume per bracket = 152.4 mm × 12.7 mm × 1.2 mm = 2,322.6 mm³ = 2.32 cm³.
  - Inner Shell Volume (inner perimeter ≈ 2 × (50.8 - 2.4) + 2 × (25.4 - 2.4) = 142.8 mm) = 142.8 mm × 12.7 mm × 1.2 mm = 2,176.5 mm³ = 2.18 cm³.
  - Total Shells for 4 brackets = 4 × (2.32 cm³ + 2.18 cm³) = 18.00 cm³.
- **Top/Bottom Layers**:
  - Area per bracket = 50.8 mm × 50.8 mm = 2,580.6 mm².
  - Volume per side = 2,580.6 mm² × 0.8 mm = 2,064.5 mm³ = 2.06 cm³.
  - Total for 4 brackets = 4 × 2 × 2.06 cm³ = 16.48 cm³.
- **Infill Volume**:
  - Total Volume = 114.72 cm³.
  - Subtract shells and top/bottom: 114.72 cm³ - (18.00 cm³ + 16.48 cm³) = 80.24 cm³.
  - Infill Volume = 0.2 × 80.24 cm³ = 16.05 cm³.
- **Total PLA Volume for Rack Mounts**:
  - Total = 18.00 cm³ + 16.48 cm³ + 16.05 cm³ = 50.53 cm³.

### 4. Wheels

- **Dimensions**:
  - 4 wheels, each 3.5 inches (88.9 mm) in diameter, 1 inch (25.4 mm) wide.
- **Volume**:
  - Volume per wheel = π × (44.45 mm)² × 25.4 mm = 157,697.6 mm³ = 157.70 cm³.
  - Total for 4 wheels = 4 × 157.70 cm³ = 630.80 cm³.
- **Shells**:
  - Outer circumference = π × 88.9 mm = 279.3 mm.
  - Height = 25.4 mm.
  - Outer Shell Volume per wheel = 279.3 mm × 25.4 mm × 1.2 mm = 8,514.2 mm³ = 8.51 cm³.
  - Inner Shell Volume (inner diameter ≈ 86.5 mm, circumference = 271.7 mm) = 271.7 mm × 25.4 mm × 1.2 mm = 8,281.9 mm³ = 8.28 cm³.
  - Total Shells for 4 wheels = 4 × (8.51 cm³ + 8.28 cm³) = 67.16 cm³.
- **Top/Bottom Layers**:
  - Area per wheel = π × (44.45 mm)² = 6,202.2 mm².
  - Volume per side = 6,202.2 mm² × 0.8 mm = 4,961.8 mm³ = 4.96 cm³.
  - Total for 4 wheels = 4 × 2 × 4.96 cm³ = 39.68 cm³.
- **Infill Volume**:
  - Total Volume = 630.80 cm³.
  - Subtract shells and top/bottom: 630.80 cm³ - (67.16 cm³ + 39.68 cm³) = 523.96 cm³.
  - Infill Volume = 0.2 × 523.96 cm³ = 104.79 cm³.
- **Total PLA Volume for Wheels**:
  - Total = 67.16 cm³ + 39.68 cm³ + 104.79 cm³ = 211.63 cm³.

### 5. Total PLA for All Parts

- **Design 1 (0.5-inch thick plate)**:
  - Plate + Skirt: 890.71 cm³.
  - Card Rack Assembly: 1,285.95 cm³.
  - Rack Mounts: 50.53 cm³.
  - Wheels: 211.63 cm³.
  - **Total Volume** = 890.71 cm³ + 1,285.95 cm³ + 50.53 cm³ + 211.63 cm³ = 2,438.82 cm³.
  - **Mass** = 2,438.82 cm³ × 1.24 g/cm³ = 3,024.14 g.
  - **Filament Length** = 3,024.14 g / 2.982 g/m = 1,013.93 m.
- **Design 2 (0.75-inch thick plate)**:
  - Plate + Skirt: 1,116.26 cm³.
  - Card Rack Assembly: 1,285.95 cm³.
  - Rack Mounts: 50.53 cm³.
  - Wheels: 211.63 cm³.
  - **Total Volume** = 1,116.26 cm³ + 1,285.95 cm³ + 50.53 cm³ + 211.63 cm³ = 2,664.37 cm³.
  - **Mass** = 2,664.37 cm³ × 1.24 g/cm³ = 3,303.82 g.
  - **Filament Length** = 3,303.82 g / 2.982 g/m = 1,107.86 m.

## Final Answer

- **Design 1 (0.5-inch thick plate)**:
  - Total PLA Required for All Parts: **2,438.82 cm³**, equivalent to **1,013.93 meters** of 1.75 mm filament (~3.02 kg, or ~3.1 spools of 1 kg filament).
- **Design 2 (0.75-inch thick plate)**:
  - Total PLA Required for All Parts: **2,664.37 cm³**, equivalent to **1,107.86 meters** of 1.75 mm filament (~3.30 kg, or ~3.3 spools of 1 kg filament).

## Notes

- The previous estimate (370.31 m for Design 1, 464.24 m for Design 2) only included the circular plate and skirt, confirming that it did not account for the card rack, mounts, and wheels.
- A standard 1 kg spool of PLA filament is ~330 meters (for 1.75 mm filament). Design 1 requires ~3.1 spools, and Design 2 requires ~3.3 spools. Add 10-20% extra filament for waste, supports, or failed prints.
- The parts are designed to be printed separately (e.g., plate in quadrants, rack components, etc.), so filament usage can be distributed across multiple print jobs.