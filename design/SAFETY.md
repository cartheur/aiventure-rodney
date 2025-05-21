# Structural Analysis: Does the Circular Plate Thickness Compensate for a 23 kg Robot Weight Using PLA?

This analysis evaluates whether the 0.5-inch thick circular bottom plate of a robot can support its approximate weight of 23 kg when 3D printed using PLA. The plate's structural integrity is assessed for bending stress and deflection, considering PLA's material properties and the robot's load distribution.

Filament (PLA) particulars are detailed [here](/design/FILAMENT.md).

## Key Parameters

- **Bottom Plate Dimensions**:
  - Diameter: 18 inches (457.2 mm).
  - Thickness: 0.5 inches (12.7 mm).
- **Robot Weight**: 23 kg.
  - Weight in Newtons: 23 kg × 9.81 m/s² = 225.63 N.
- **Material**: PLA (Polylactic Acid, a common 3D printing material).
  - **Density**: ~1.24 g/cm³ (1240 kg/m³).
  - **Tensile Strength**: ~50 MPa.
  - **Flexural Strength**: ~80 MPa (resistance to bending).
  - **Young’s Modulus**: ~3.5 GPa (3500 N/mm², stiffness).
- **Load Distribution**: Assumed to be uniform across the plate for initial analysis, with a worst-case point load scenario for the battery.

## Step 1: Calculate the Weight of the Bottom Plate

- **Volume of the Bottom Plate**:
  - Radius = 457.2 mm / 2 = 228.6 mm.
  - Area = π × (228.6 mm)² = 164,021.7 mm².
  - Thickness = 12.7 mm.
  - Volume = Area × Thickness = 164,021.7 mm² × 12.7 mm = 2,083,075.6 mm³ = 2,083.08 cm³.
- **Mass of the Bottom Plate**:
  - Density of PLA = 1.24 g/cm³.
  - Mass = Volume × Density = 2,083.08 cm³ × 1.24 g/cm³ = 2,583.02 g = 2.58 kg.

The plate weighs 2.58 kg, contributing a small portion to the total 23 kg. The remaining weight (20.42 kg) comes from the rack, circuit boards, battery, wheels, and other components.

## Step 2: Load Analysis

The total weight of 225.63 N is supported by the plate, which rests on 4 wheels near the edges. We’ll analyze both a uniform load and a worst-case point load scenario.

### Load Distribution

- **Uniform Load**:
  - Area of the plate = 164,021.7 mm².
  - Pressure = Force / Area = 225.63 N / 164,021.7 mm² = 0.001375 N/mm² = 0.001375 MPa.
  This is very low compared to PLA’s strengths (50 MPa tensile, 80 MPa flexural), so compressive failure is not a concern.
- **Point Load Consideration**:
  - Battery: ~6 kg (58.86 N), assumed over a 200 mm × 200 mm area.
  - Rack and components: ~14 kg (137.34 N), over the rack’s 279.4 mm × 279.4 mm footprint.
  - Wheels and other parts: ~2.42 kg (23.74 N), near the edges.

### Bending Stress (Simplified Analysis)

The plate is approximated as a circular plate, simply supported at the edges (by the wheels), with a central load from the rack and battery.

#### Uniform Load Case

- **Maximum Deflection** (for a simply supported circular plate with uniform load):
  - Formula: δ = (3 × w × R⁴ × (5 + ν)) / (16 × E × t³ × (1 - ν)).
    - w = load per unit area = 0.001375 N/mm².
    - R = radius = 228.6 mm.
    - t = thickness = 12.7 mm.
    - E = Young’s Modulus = 3500 N/mm².
    - ν = Poisson’s ratio for PLA ≈ 0.36.
  - δ = (3 × 0.001375 × (228.6)⁴ × (5 + 0.36)) / (16 × 3500 × (12.7)³ × (1 - 0.36)).
  - (228.6)⁴ = 2,732,310,417.6 mm⁴.
  - 5 + 0.36 = 5.36.
  - (12.7)³ = 2,048.38 mm³.
  - 1 - 0.36 = 0.64.
  - δ ≈ 0.653 mm (negligible compared to the 12.7 mm thickness).

- **Maximum Bending Stress**:
  - Formula: σ = (3 × w × R² × (1 + ν)) / (4 × t²).
  - σ = (3 × 0.001375 × (228.6)² × (1 + 0.36)) / (4 × (12.7)²).
  - (228.6)² = 52,257.96 mm².
  - 1 + 0.36 = 1.36.
  - (12.7)² = 161.29 mm².
  - σ ≈ 0.361 MPa (far below PLA’s 80 MPa flexural strength).

#### Point Load Case (Battery, Worst Case)

- Battery load: 6 kg = 58.86 N, over a 200 mm × 200 mm area.
- Pressure = 58.86 N / (200 × 200) mm² = 0.0014715 N/mm².
- **Bending Stress** (central point load, simply supported circular plate):
  - Formula: σ = (3 × F × R) / (2 × π × t²).
  - F = 58.86 N, R = 228.6 mm, t = 12.7 mm.
  - σ = (3 × 58.86 × 228.6) / (2 × π × (12.7)²).
  - σ ≈ 39.81 MPa.

This stress (39.81 MPa) is below PLA’s flexural strength (80 MPa), but 3D-printed PLA often has reduced strength due to layer adhesion (effective strength ~48-64 MPa). Safety factor ≈ 1.2-1.6, which is low for a critical component.

## Step 3: Does the Thickness Compensate?

- **Bending Stress**: 39.81 MPa (point load case) vs. PLA’s 80 MPa flexural strength (safety factor 1.2-1.6 for 3D-printed PLA).
- **Deflection**: 0.653 mm (uniform load), negligible relative to the 12.7 mm thickness.
- **Conclusion**: The 0.5-inch (12.7 mm) thickness can support the 23 kg load, but the safety factor is low for a 3D-printed PLA part, especially under concentrated loads. PLA’s anisotropic nature and print imperfections could further reduce reliability.

## Step 4: Recommendations to Improve Safety

To increase the safety factor, consider the following options:

1. **Increase Thickness**:
   - Increase to 15 mm (0.59 inches):
     - New σ = (3 × 58.86 × 228.6) / (2 × π × (15)²) ≈ 28.49 MPa.
     - Safety factor = 80 / 28.49 ≈ 2.8 (or 1.7-2.2 for 3D-printed PLA).
   - New mass = 2,083.08 cm³ × (15 / 12.7) × 1.24 g/cm³ ≈ 3.05 kg (still a small fraction of 23 kg).
2. **Reinforce the Plate**:
   - Add radial ribs on the underside (e.g., 8 ribs, 5 mm thick, 20 mm high) to increase stiffness.
3. **Use a Stronger Material**:
   - Switch to PETG (flexural strength ~90 MPa) or ABS (~75 MPa) for better durability.
4. **Distribute the Load**:
   - Mount the battery and rack closer to the wheels to reduce central bending stress.

## Final Answer

The 0.5-inch (12.7 mm) thickness of the circular plate can support the 23 kg weight when made of PLA, with a maximum bending stress of ~39.81 MPa (below PLA’s 80 MPa flexural strength). However, the safety factor is low (1.2-1.6 for 3D-printed PLA), making it riskier for long-term use or concentrated loads. Increasing the thickness to 15 mm or adding ribs would provide a safer design with a higher safety factor (~1.7-2.8).