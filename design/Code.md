# Rodney Code Structure

This note explains what code belongs where in the new wire-wrap Rodney build, and why.

The short version is:

- `ROM` should provide startup, stable service routines, and safety behavior.
- `RAM` should hold the behavior that is allowed to change, including the first learning loops.
- learned `main memory` is not the same thing as program ROM or program RAM.

That separation matters if we want to replicate the self-programming claim honestly.

## What The Book Actually Implies

The book does **not** describe a machine whose learned behavior is stored in ROM.

What it describes is closer to this:

1. a fixed support layer that gets the machine running
2. an externally loaded program layer that provides the initial reflex and control structure
3. a writable learned-state memory keyed by environment
4. routines that update and generalize that learned-state memory

In other words, the machine is not "self-programming" because it rewrites its boot ROM. It is "self-programming" because it writes and rewrites the memory structure that determines future responses.

## Why The ROM Exists At All

For the new build, ROM is still useful, even though learned behavior does not belong there.

ROM gives us:

- reset entry
- stack setup
- board initialization
- stable subroutine entry points
- optional memory clear routines
- a sanity check that RAM code is present
- a safe failure mode if RAM is empty or corrupt

This makes the bench-first build much easier to debug. It also keeps the RAM-resident behavior small enough to iterate without having to rebuild the entire bootstrap layer each time.

## Why The Learning Loop Must Stay In RAM

The first real behavioral loop must stay in writable memory for three reasons.

1. It matches the book’s architecture.
   The book’s learned behavior is stored in main memory and manipulated by runtime routines.

2. It keeps code and learned state conceptually separate.
   We want to distinguish:
   - fixed support code
   - runtime behavior code
   - learned response data

3. It lets us trace complexity.
   We can start from a tiny seed loop, then add Beta, then Gamma, and inspect each stage independently.

## Current File Roles

## `RODNEY-SUPPORT-ROM.asm`

This is the fixed ROM-resident support layer.

Its job is to:

- enter cleanly from reset
- initialize visible outputs and indirect memory registers
- verify that the RAM runtime exists
- expose stable callable routines for:
  - `ENVL`
  - `ENVH`
  - `TSWR`
  - `ACTL`
  - `ACTH`
  - `MMA`
  - `MMD`

This file should remain small and boring on purpose.

## `RODNEY-BETA-SEED.asm`

This is the smallest plausible RAM-resident learning loop.

Its job is to prove the key mechanism:

- read the current environment
- treat that environment as an address into learned state
- fetch a learned byte
- if no confidence exists yet, choose a random action nibble
- store that response with low confidence
- otherwise replay the stored action

This file is intentionally minimal. It is the bridge between "the machine runs" and "the machine begins to accumulate response history."

## Why Extensions Must Be Separate

Keeping extensions in separate files is the right move for this project.

If we pile everything into one assembly source too early, we lose the ability to answer basic questions like:

- when did confidence logic first appear?
- when did response revision first appear?
- when did generalization first appear?
- which failure came from the ROM layer versus the Beta layer versus the Gamma layer?

So from here on:

- the original seed files stay as they are
- richer behavior gets added in new files
- each new file should represent one clear increase in behavioral complexity

## Planned Next Files

## `RODNEY-BETA-FULL.asm`

This will extend the seed loop into a more faithful Beta-style mechanism.

Expected additions:

- explicit response/confidence byte format
- known-response replay path
- unknown-response random acquisition path
- confidence increment when a stored response appears valid
- confidence decrement when a stored response appears invalid
- write-back of revised learned bytes

This will still be RAM-resident.

## `RODNEY-GAMMA-PASS1.asm`

This will be the first explicit generalization pass.

Expected additions:

- scan of learned memory
- search for high-confidence entries
- relevance-mask style grouping
- majority inference of action bits
- write-back of generalized low-confidence entries

This will not try to be a byte-perfect reconstruction of the book on the first pass. It will try to preserve the same underlying mechanism in a form we can reason about on the new hardware.

## Important Boundary

The ROM supports the behavior.
The RAM code performs the behavior.
The learned main-memory table stores the results of the behavior.

That boundary is the cleanest way to replicate the self-programming claim without cheating or collapsing everything into a generic monitor.
