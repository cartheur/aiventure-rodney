# Rodney `6x09` Redesign Track

This folder captures what it would take to pivot the current Rodney bench-first architecture away from the `8085A` and onto a `6809` or `6309`.

The key distinction is:

- if the goal is a historically faithful Heiserman reconstruction, stay with the `8085`
- if the goal is preserving Rodney's **learning architecture** on a friendlier 8-bit CPU, the `6x09` family is a strong candidate

The existing repo already separates those concerns fairly well:

- the current wire-wrap architecture preserves the **behavioral model**
- the current implementation details are still very `8085`-specific

So this redesign is best understood as:

- a new `Board A` CPU/bus design
- moderate decode and reset changes
- near-total assembly rewrite
- minimal conceptual change to the `ENVL` / `ACTL` / `MMA` / `MMD` model

## Recommendation

Recommended path:

1. target the plain `6809` first
2. keep the hardware and source compatible with the `6309`
3. treat the `6309` as a later performance and cleanup upgrade, not the bring-up baseline

Why:

- `6809` bring-up is simpler and better documented
- `6309` can usually drop into a `6809`-clean design later
- debugging a fresh board and a CPU superset at the same time adds avoidable risk

The inventory already supports this direction:

- `EF6809P`
- `MC6809P`
- `HD63C09RP`

## Scope Of Change

### What must be redesigned

- `Board A` CPU socket region
- clock generation for `E` / `Q`
- reset, interrupt, and halt handling
- address and control decode assumptions
- bootstrap and monitor assembly
- Beta and Gamma assembly sources

### What can stay conceptually intact

- `3-board` partitioning
- memory-mapped `ENVL`, `ENVH`, `TSWR`, `ACTL`, `ACTH`
- indirect learned-memory access through `MMA_L`, `MMA_H`, and `MMD`
- bench-first switch and LED I/O strategy
- learned-byte format:
  - low nibble = action
  - upper bits = confidence

## Practical Assessment

This is not a "swap the CPU and reassemble" project.

It is closer to:

- `60%` hardware respin of the CPU/bus layer
- `100%` rewrite of the assembly sources
- `10-20%` rethink of memory decode and bring-up procedures

The payoff is real, though:

- the `6809` is a cleaner CPU to program
- indexed addressing is much better suited to table-heavy learning code
- stack and subroutine support are stronger than the `8085`
- the `6309` offers a later speed path if Gamma passes become expensive

## Files In This Folder

- [BOARD-A-SIGNAL-SUBSTITUTIONS.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/BOARD-A-SIGNAL-SUBSTITUTIONS.md:1)
- [BRING-UP-PLAN.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/BRING-UP-PLAN.md:1)
- [CONCRETE-BOM-4BOARD-8085-AND-6X09.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/CONCRETE-BOM-4BOARD-8085-AND-6X09.md:1)
- [AN002-GA144-CRYSTAL-BOUNDARY.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/AN002-GA144-CRYSTAL-BOUNDARY.md:1)
- [6X09-BOM-DELTA.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/6X09-BOM-DELTA.md:1)
- [6X09-MISSING-PARTS-CHECKLIST.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/6X09-MISSING-PARTS-CHECKLIST.md:1)
- [MEMORY-AND-DECODE-PROPOSAL.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/MEMORY-AND-DECODE-PROPOSAL.md:1)
- [RODNEY-3BOARD-SINGLE-SHEET-BOM-6X09.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-6X09.md:1)
- [RODNEY-3BOARD-SINGLE-SHEET-BOM-6X09.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-6X09.csv:1)
- [RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.md:1)
- [RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-3BOARD-SINGLE-SHEET-BOM-8085-REFERENCE.csv:1)
- [RODNEY-ON-HAND-STOCK-REFERENCE.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-ON-HAND-STOCK-REFERENCE.md:1)
- [RODNEY-6809-BETA-SEED.asm](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-6809-BETA-SEED.asm:1)
- [RODNEY-6809-SUPPORT-ROM.asm](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-6809-SUPPORT-ROM.asm:1)

## Suggested Migration Order

1. Freeze the logical memory map and I/O contract.
2. Redesign `Board A` around `6809` bus timing.
3. Keep `Board B` and `Board C` interfaces as stable as possible.
4. Bring up ROM, reset, RAM execution, and `ACTL` blink first.
5. Port the smallest runtime:
   - support ROM
   - Beta seed
6. Only then port Beta-full and Gamma.

## Decision

If only one CPU family should be pursued here, use:

- `6809` for first hardware and software bring-up
- `6309` for later drop-in validation once the baseline system is stable

## Boundary Marker

Treat this `6x09` folder as the boundary between:

- the conventional Rodney CPU-board redesign path built around `8085`, `6809`, and `6309`
- a later, separate architectural phase that would introduce a `GA144`

In other words:

- everything in this folder stays on the side of socketed conventional CPUs and shared `Board B` / `Board C` infrastructure
- any `GA144` introduction should begin as a new branch of documentation rather than being folded back into this `6x09` track

More specifically, this boundary is defined at the crystal.

- the `6x09` track ends at the conventional crystal-clocked CPU boundary
- the `GA144` track begins at the resonant-frequency origin of that crystal

That means the split is not merely "old CPU here, new chip there." It is:

- below the crystal domain: conventional synchronous CPU design, glue logic, memory, and bench I/O
- at and beyond the crystal's resonant-frequency domain: the start of the `GA144` architectural phase

Historical note for this branch:

- immediately before drawing this boundary, the `6x09` path was heading toward a `74LS74`-based clock-divider / phase-generation approach
- that would have been the more conventional and less elegant solution compared with treating the crystal boundary itself as the start of the next phase
- see [AN002-GA144-CRYSTAL-BOUNDARY.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/AN002-GA144-CRYSTAL-BOUNDARY.md:1)
