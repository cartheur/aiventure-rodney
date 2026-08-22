# Rodney Self-Programming Replication Evidence

Goal: isolate the parts of `spr-book` that provide concrete evidence for reproducing the book's "self-programming" behavior on a new board.

This note is intentionally narrower than a book summary. It focuses on:

- what the book claims the self-programming mechanism actually is
- which memory and I/O structures it depends on
- which code pages appear to implement it
- what a replacement board would minimally need

## Executive Conclusion

The book's discrete self-programming mechanism is **not ROM** and not the front-panel code entry mechanism.

The self-programming mechanism is:

- a **main memory** indexed by environmental state
- a **stored response word** that includes action bits plus confidence bits
- a **Beta loop** that writes successful or unsuccessful responses back into that main memory
- a **Gamma routine** that scans main memory, detects relevant high-confidence patterns, and writes generalized low-confidence responses back into memory

The strongest evidence pages are:

- `0205` for the architectural claim that Rodney "programs the main memory system"
- `1203`-`1206` for the algorithm description
- `1207`-`1208` for the actual `GAMMA1` code listing
- `1110`-`1112` for the Beta scaffolding that Gamma extends

## Core Evidence

## 1. Main memory is the self-programmed store

Page `0205` is the key architectural statement.

Observed text from the page image:

- Rodney is "responsible for all main-memory operations."
- He "programs the main memory system in a fashion unique to his own personality."
- The system uses main memory when Rodney needs to know what he did before under a particular set of environmental circumstances.
- If no viable response exists, Rodney uses `TSWR` random input, and if a response works, he stores it in main memory for future use.
- The page explicitly says the main memory is unusual because it is **not addressed from the system address bus**, but by `MAWL` and `MAWH`.

Replication implication:

- The adaptive state store is separate from the instruction store.
- A new board does not need to preserve the exact bus topology, but it does need a distinct writable data structure that maps environmental state to learned response data.

## 2. The environment-to-memory mapping is explicit

Still on `0205`, plus context from the adjacent diagram:

- `ENVL` and `ENVH` are the environment inputs.
- `ACTL` and `ACTH` are the action outputs.
- `MARL` and `MARH` expose the main-memory address context.
- `MAWL` and `MAWH` load the main-memory address.
- `MDRL`/`MMDL` is the main-memory data word.

Replication implication:

- The self-programming scheme expects a mapping of:
  `environment bits -> memory address -> response/confidence data`
- The exact chip-level port names are old-hardware specific, but the logical interfaces are reproducible.

## 3. Beta is the first learning layer

Pages `1110`-`1112` show the Beta program and support routines.

What Beta appears to do:

- Read the current environment (`ENVL`)
- Look up a response in main memory (`PORT4` / `PORT6` references in the listing)
- If an older response works, raise confidence
- If a response fails, lower confidence
- If no response exists or confidence is zero, fetch a random response
- Store the chosen response plus confidence back into main memory

Strong evidence from the prose on `1110`:

- Successful response and confidence bits are stored in main memory at the address representing the `ENVL` condition.
- A negative result at `BEFORE` means no response is available or confidence is zero.
- In that case the system calls `FETCH-PLEX`, chooses a random response, sets confidence to `1`, and stores it in main memory.

Replication implication:

- The minimal self-programming implementation probably starts with Beta, not Gamma.
- Beta gives you online reinforcement against a per-environment response table.

## 4. Gamma is the generalization engine

Pages `1203`-`1206` are the clearest algorithmic description of "self-programming."

### Trigger condition

From `1203`:

- Gamma is called when a confidence level moves from `2 -> 3`
- Gamma is also called when a confidence level moves from `3 -> 2`

Interpretation:

- Gamma is not always running.
- It is triggered when an existing theory becomes newly strong or newly weakened.

### Search process

From `1204` and `1205`:

- Gamma scans main memory for addresses relevant to the situation being generalized.
- It fetches only high-confidence responses first (`CONL=3`).
- It counts whether relevant response bits are mostly `1` or mostly `0`.
- If there are no matching cases or equal numbers, results are discarded and relevance criteria are changed.
- If one value dominates, the system then scans for low-confidence entries (`CONL < 2`) under the same environmental criteria and writes the inferred bit there.
- Newly generalized responses are stored with confidence level `1`.

This is the most important discrete algorithm in the whole topic.

Replication implication:

- Gamma is effectively a bitwise generalizer over a learned lookup table.
- It is not symbolic AI and not a rule tree.
- It infers likely action bits for unseen or weakly learned states by majority evidence from similar high-confidence states.

## 5. Relevance selection is explicit enough to reproduce

Pages `1206`-`1207` define the relevance-selection process.

Strong evidence:

- The `RELST` subroutine controls which environmental bits are treated as relevant.
- The lower nibble is checked one bit at a time: `0, 1, 4, 8`.
- The upper nibble is checked in combinations with the hungry bit fixed high, giving the sequence:
  `8, 9, A, B, C, D, E, F`
- Table 12-1 shows the relevance bytes:
  `81 82 84 88 91 92 94 98 A1 A2 A4 A8 B1 B2 B4 B8 C1 C2 C4 C8 D1 D2 D4 D8 E1 E2 E4 E8 F1 F2 F4 F8`
- Each lower-bit case is tested once for `0` and once for `1`, making `64` cycles total.

Replication implication:

- The generalizer is intentionally constrained and enumerable.
- This makes it practical to reimplement on a modern MCU or FPGA without needing the full original hardware.

## 6. Gamma code listing exists

Pages `1207` and `1208` contain the strongest code evidence.

Important observations from the page images:

- `Beta With Gamma Calling` patches the Beta program with explicit `CALL GAMMA1`
- `INIT` loads a stop code to `ACTL` during Gamma
- `GAMMA1` starts around address `300`
- The listing shows the real routine structure, including:
  `PUSH PSW`
  `CALL INIT`
  `MVI B, FREL`
  clearing `PHBYT`
  clearing `D` and `E` counters
  initializing the MMA pointer
  fetching main-memory data from `PORT6`
  masking confidence bits with `ANI C0H`
  comparing against `C0H` and `80H`
  branching to `RELST`
  `SET BIT 1` via `MVI D,0FH`
  `SET BIT 0` via `MVI D,00H`
  writing modified memory back through `PORT6`

Replication implication:

- The book provides enough concrete code structure to reconstruct the algorithm even if OCR mistakes make the listing imperfect.
- The safest path is to treat these pages as algorithm source material, not as a byte-perfect ROM image.

## What A New Board Must Have

Based on the evidence pages, a new board needs at least:

- A CPU or MCU able to run a small control loop plus a background generalization pass
- Persistent or battery-backed writable state memory for learned entries
- A representation of environment input bits equivalent to `ENVL` at minimum
- A representation of action output bits equivalent to `ACTL`
- A random-response source equivalent to `TSWR`
- A response word layout containing:
  action bits
  confidence bits
  likely stall/feed state integration through environment inputs
- The ability to:
  look up response by environment
  update confidence online
  write new random responses when unknown
  periodically or event-driven run Gamma-style generalization

## What Seems Hardware-Specific Vs Portable

Likely hardware-specific:

- 8085 instruction encodings
- the exact `PORT0`, `PORT4`, `PORT6` addresses
- separate `MAWL`, `MAWH`, `MARL`, `MARH` latch wiring
- front-panel program entry details

Portable conceptual mechanism:

- environment-indexed learned memory
- confidence-weighted response updates
- random fallback for unseen states
- bitwise generalization from high-confidence to low-confidence states
- trigger Gamma when confidence crosses thresholds

## Best Pages To Use During Reimplementation

- `0205`
  Use for architecture and the self-programming claim.

- `1110`
  Use for Beta data format and update semantics.

- `1111`
  Use for `CLRM` and `RUAPX` support routines.

- `1112`
  Use for the actual Beta helper subroutines.

- `1203`
  Use for Gamma entry conditions.

- `1204`
  Use for Gamma flowchart semantics.

- `1205`
  Use for the clearest natural-language explanation of the generalization behavior.

- `1206`
  Use for `RELST` and relevance scheduling.

- `1207`
  Use for relevance table and the start of the code listing.

- `1208`
  Use for the main `GAMMA1` listing body.

## Bottom Line

If we want evidence strong enough to reproduce the self-programming behavior on a new board, the best reconstruction target is:

1. Implement the Beta lookup/update loop first.
2. Recreate the main-memory data format with confidence bits.
3. Recreate Gamma as a background routine that:
   scans high-confidence responses,
   groups by relevance masks,
   majority-votes action bits,
   writes generalized low-confidence entries with confidence `1`.

That is the clearest discrete mechanism behind the book's "self-programming" title.
