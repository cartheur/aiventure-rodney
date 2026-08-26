# Rodney Revision Ladder With `SC67475P` / `MC6829P`

Date: `2026-08-26`

This note reformulates the CPU-board analysis in light of the `SC67475P` inventory entry, noted in [inventory/list.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/inventory/list.csv:9) as a Motorola memory management unit in the `MC6829P` family.

For the crystal-boundary side of the same revision ladder, also see:

- [AN002-171106-OSC.pdf](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/AN002-171106-OSC.pdf)

## Summary

The earlier `6x09` analysis was directionally right, but it blurred revision steps and later expansion language.

The cleaner reading is a linear revision ladder:

- `Rev. 0`: `8085` on `Board A`
- `Rev. 1`: `MC6809P` plus `GA144` inclusion on `Board A`
- `Rev. 2`: `HD63C09RP` plus `GA144` inclusion on `Board A`
- `Rev. 3`: `MC6809P/HD63C09RP/SC67475P` plus `GA144` inclusion on `Board A`

With the `SC67475P` addition, the important change is not a new "phase." It is that the later revisions can be made `MMU-aware`.

## Inventory Fact

The repo inventory currently lists:

- `SC67475P` x `6`

at [inventory/list.csv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/inventory/list.csv:9).

That means the revision ladder is not limited to a plain CPU swap. It already has the inventory basis for a memory-management branch once the linear CPU revisions are stable.

## Revision Ladder

### `Rev. 0`

- baseline `8085` `Board A`
- historical reference point
- current conventional starting machine
- no `GA144` inclusion assumed

### `Rev. 1`

- `MC6809P` on `Board A`
- `GA144` included on `Board A`
- first non-Intel CPU-board revision
- keep the machine as simple as possible:
  - linear `64 KB` map
  - memory-mapped I/O
  - ROM valid at top of memory for vector fetch
  - `MMA_L`, `MMA_H`, and `MMD` preserved
  - no MMU dependency in the active path
  - use `GA144` for the crystal-boundary inclusion rather than centering the board around a `74LS74` resonance workaround

### `Rev. 2`

- `HD63C09RP` on `Board A`
- `GA144` included on `Board A`
- begin by treating it as a conservative drop-in replacement for the `MC6809P`
- only after stability should clock or instruction-set advantages be explored

### `Rev. 3`

- `MC6809P/HD63C09RP/SC67475P` `Board A`
- `GA144` included on `Board A`
- intended as the converged conventional CPU board plus explicit MMU introduction
- should preserve the same `Board B` and `Board C` contract
- this is the natural place to move from MMU-awareness to MMU population

## MMU Interpretation

The `SC67475P` does not need to redefine the ladder.

It fits it like this:

- `Rev. 0`: no MMU assumption
- `Rev. 1`: no MMU dependency
- `Rev. 2`: no MMU dependency
- `Rev. 3`: explicit `SC67475P` introduction

Across the same ladder:

- `Rev. 0`: no `GA144` inclusion assumed
- `Rev. 1`: `GA144` included
- `Rev. 2`: `GA144` included
- `Rev. 3`: `GA144` included

## Why The MMU Stays Out Of `Rev. 1`

- it adds another failure surface during reset and vector fetch
- it complicates decode before the base machine has proven itself
- it makes ROM / RAM / learned-memory faults harder to isolate
- it delays the core question of whether the `MC6809P` Rodney model runs at all

This keeps `Rev. 1` aligned with [BRING-UP-PLAN.md](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/BRING-UP-PLAN.md:1).

## What The MMU Changes Once Revisions Mature

The MMU creates a credible path to:

- banking program RAM
- stabilizing a fixed visible ROM or monitor region while remapping working memory
- creating alternate learned-state or experiment spaces
- separating operator-visible map simplicity from deeper internal memory experiments

## Why This Matters For Rodney

Rodney already wants a distinction between:

- support code
- runtime code
- learned state

The MMU can make that distinction stronger without forcing everything into fixed decode forever.

## Best Early MMU Uses

Recommended uses once the linear CPU revisions are stable:

1. banked program-RAM experiments behind a stable CPU-visible window
2. alternate learned-memory spaces for Beta/Gamma experiments
3. controlled remap schemes for comparing seeded and evolved behavior tables

## Uses To Avoid At First

- putting the MMU directly in the critical reset-vector path
- making ROM visibility depend on a complex runtime state
- solving basic bring-up problems with address translation instead of simpler decode

## Architectural Reframe

Before the MMU addition, the redesign could be summarized as:

- a linear CPU-board progression from `8085` to `MC6809P` to `HD63C09RP`

After this addition, the better summary is:

- a linear CPU-board progression
- with `Rev. 3` as the point where `SC67475P` becomes part of the board definition
- with `GA144` included from `Rev. 1` onward at the crystal boundary

That is a materially stronger position.

## BOM Implication

The current `6x09` BOM remains a valid `Rev. 1` BOM.

It is not yet a complete `Rev. 3` BOM, because it does not currently account for:

- `SC67475P` population
- MMU support wiring
- any additional latch, strap, or decode support needed for the chosen mapping scheme

So the BOM status is now:

- `Rev. 1` BOM: valid
- `Rev. 2` can remain close to `Rev. 1`
- `Rev. 3` BOM with `SC67475P`: not yet expressed

## Design Implication

The design status is now:

- `Rev. 0`: `8085`
- `Rev. 1`: `MC6809P` plus `GA144`
- `Rev. 2`: `HD63C09RP` plus `GA144`
- `Rev. 3`: `MC6809P/HD63C09RP/SC67475P` plus `GA144`

That means future `Board A` or `Board B` planning should treat `Rev. 3` as the explicit `SC67475P` revision, not merely a vague MMU-aware placeholder.

## Recommendation

Proceed in this order:

1. keep `Rev. 0` as the `8085` reference
2. complete `Rev. 1` as the clean `MC6809P` port without MMU dependency
3. validate `Rev. 2` as the `HD63C09RP` drop-in path
4. use `Rev. 3` as the place to define explicit `MC6809P/HD63C09RP/SC67475P` convergence
5. introduce `SC67475P` only after ROM fetch, RAM handoff, and Beta seed behavior are stable in the earlier revisions

## Practical Conclusion

The earlier analysis was incomplete because it mixed a linear hardware revision ladder with later expansion language.

With `SC67475P` x `6` in inventory, the better reading is:

- `Rev. 0`: `8085`
- `Rev. 1`: `MC6809P` plus `GA144`
- `Rev. 2`: `HD63C09RP` plus `GA144`
- `Rev. 3`: `MC6809P/HD63C09RP/SC67475P` plus `GA144`

And that keeps the MMU explicitly attached to the later linear revision without forcing that complexity into the earlier ones.
