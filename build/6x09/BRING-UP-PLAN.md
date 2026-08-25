# `6x09` Bring-Up Plan

This note turns the redesign packet into a practical bench sequence.

## Goal

Bring the `6809` Rodney variant up in the smallest safe steps:

1. prove reset and vector fetch
2. prove ROM execution
3. prove program RAM execution
4. prove `ACTL`
5. prove `MMA` / `MMD`
6. only then run the Beta seed

## Phase 1: Dead-Board Checks

Before inserting the CPU:

- verify `+5V` and `GND` continuity on all boards
- verify no rail shorts
- verify every IC has local decoupling
- verify reset pull-ups and interrupt inactive pulls
- verify ROM chip-select logic with static probing if possible

## Phase 2: Clock And Reset

With CPU installed:

- verify reset pulse width and idle level
- verify `E` and `Q` are present and stable
- verify no obvious bus contention on `D0-D7`

Success looks like:

- clean reset behavior
- repeatable bus activity after reset release

## Phase 3: ROM Fetch

The first software milestone is vector correctness.

Checks:

- ROM is visible at the top of memory
- reset vector points to `ROM_ENTRY`
- address bus shows top-of-memory fetch activity during reset/release

If this is wrong, stop here. Everything else depends on this.

## Phase 4: ROM Blink Test

Run the support ROM alone first.

Recommended first visible behavior:

- force the failure monitor path temporarily
- blink `ACTL` in a repeating pattern

Why:

- it proves vector fetch
- it proves instruction execution
- it proves output write path to `ACTL`

## Phase 5: RAM Handoff

Once ROM execution is stable:

- load a tiny RAM program at `$0100`
- confirm `VERIFY_RUNTIME` passes
- confirm ROM jumps into program RAM

At this stage the RAM payload should be as small as possible, ideally just:

- write a known pattern to `ACTL`
- loop forever

## Phase 6: Learned-Memory Path

Before running Beta, validate the indirect learned-memory path by hand:

1. write `MMA_L`
2. write `MMA_H`
3. write a byte through `MMD`
4. reselect the same address
5. read back through `MMD`

Only move on when this is solid.

## Phase 7: Beta Seed

Load [RODNEY-6809-BETA-SEED.asm](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/build/6x09/RODNEY-6809-BETA-SEED.asm:1) at `$0100`.

Expected behavior:

- unknown `ENVL` states cause random low-nibble action selection
- learned byte is written back with confidence `1`
- repeated visits replay the stored action on `ACTL`

## Suggested Debug Strategy

If Beta fails, isolate in this order:

1. `READ_ENVL`
2. `SET_MMA_FROM_A`
3. `READ_MMD`
4. `WRITE_MMD`
5. `WRITE_ACTL`

That keeps us from blaming the learning loop for what is really just one broken primitive.

## After Beta Seed

Only after the seed loop is stable should the next steps begin:

- port `RODNEY-BETA-FULL`
- add explicit confidence update tests
- port first-pass Gamma
- consider `6309`-specific cleanup or acceleration
