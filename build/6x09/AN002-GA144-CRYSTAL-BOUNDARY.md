# AN002: `GA144` Crystal-Boundary Introduction

Application note `AN002` records the architectural boundary between:

- the conventional Rodney CPU path built around `8085`, `6809`, and `6309`
- the next phase beginning with the `GA144`

## Boundary Definition

The boundary is defined at the crystal.

- the conventional CPU branch ends at the crystal-clocked machine boundary
- the `GA144` branch begins at the resonant-frequency origin of that crystal

This is not merely a processor substitution.

It is a change in architectural regime:

- below the crystal domain: conventional synchronous CPU, glue logic, memory, and bench I/O
- at and beyond the crystal's resonant-frequency domain: `GA144`

## Why This Note Exists

Immediately before this boundary was made explicit, the `6x09` branch was moving toward a conventional `74LS74` divider / phase-generation approach for `Board A`.

That path remains a valid conventional engineering option, but it is intentionally de-emphasized here because it does not express the cleaner handoff you wanted:

- crystal as boundary
- `GA144` as the next regime beginning from that resonance domain

## Scope

This note is interpretive and architectural.

It does not yet define:

- a complete `GA144` schematic
- a shared timing-distribution network
- a mixed `6x09` / `GA144` bus protocol
- a final resonant-coupling implementation

Those belong to the next documentation branch after `build/6x09`.
