# Self-Programming Pages With Explicit Programming Angle

Source basis: OCR from the `spr-book/*.png` images in [ocr.tsv](/home/cartheur/ame/aiventure/aiventure-github/cartheur/aiventure-rodney/spr-book-analysis/ocr.tsv).

I’ve confirmed the book is more specific than the title suggests: the replicable mechanism is a main-memory learning format plus the Gamma generalization routine. I’m checking the continuation pages now so we can capture the evidence that matters for a new board implementation, not just the headline claims.

## Strong Matches

- `0002`
  Evidence: "It is about a machine that programs itself..." and "Rodney is a self-programming machine..."
  Why it matters: This is the clearest early statement that the topic is literal programming, not just adaptive behavior.

- `0201`
  Evidence: "The program RAM contains a list of instructions..." and "You will be entering these program instructions directly into the program RAM..."
  Why it matters: Explains where Rodney's programming instructions live and how they enter the system.

- `0204`
  Evidence: "The program RAM handles the more mundane 'housekeeping' chores required for the microprocessor-and you program the program RAM."
  Why it matters: Explicitly separates human-entered program RAM from Rodney's own internal learning-related memory.

- `0205`
  Evidence: "Rodney, himself, is responsible for all main-memory operations. He programs the main memory system..." and "systems that have a self-programming character."
  Why it matters: This is the strongest technical explanation of the self-programming idea.

- `0500`
  Evidence: "While Rodney is essentially a self-programming machine, there is still a need for entering a small selection of programs from the outside world."
  Why it matters: Directly explains that self-programming still depends on initial externally entered reflex programs.

- `0501`
  Evidence: "write data directly at the system's program RAM" and "This allows direct entry of programming information..."
  Why it matters: Describes the front-panel mechanism used to enter the base programs that Rodney builds on.

## Related But Less Direct

- `0101`
  Evidence: "microprocessor programming" and "machine-language programming procedures."
  Note: Programming is discussed here, but mainly as background knowledge for the builder, not as the self-programming mechanism itself.

- `0103`
  Evidence: "Control switches are included, but mainly for programming purposes" and "dynamic, self-programming, general-purpose machines..."
  Note: This ties programming to Rodney philosophically, but it does not yet explain the programming mechanism.

- `0207`
  Evidence: "This allows direct entry of programming information..." and "All of the control operations take place as a direct result of data from the program RAM."
  Note: Useful supporting page for the programming workflow, though less directly about self-programming than `0204`-`0205`.

## Best Answer To The Original Question

If you want the pages that most explicitly mention the programming aspect of the self-programming topic, the best set is:

- `0002`
- `0201`
- `0204`
- `0205`
- `0500`
- `0501`

If you want the broader supporting context too, add:

- `0101`
- `0103`
- `0207`

## ROM Mentions On This Topic

These pages mention ROM in direct connection with the programming side of Rodney's self-programming design:

- `0201`
  Evidence: program instructions "can also be entered into the system from a ROM (Read-Only memory) or cassette-tape programming scheme."
  Why it matters: Establishes ROM as one possible source of the base instruction set.

- `0204`
  Evidence: "The ROM (Read-Only Memory) is an optional device..." and "eliminate the need for reprogramming the program RAM..."
  Why it matters: This is the clearest ROM explanation in the self-programming context. The book says ROM stores the same externally supplied program information, while Rodney's self-programming happens in main memory.

- `0206`
  Evidence: "The optional ROM has a 256-byte capacity..." and the system may use "the program RAM or optional ROM."
  Why it matters: Gives the architectural role of ROM in the memory map.

## ROM Code Findings

I did not find a distinct ROM code listing in the pages most directly about self-programming.

What the book appears to say instead:

- ROM is optional support for preserving the externally entered base programs.
- Program RAM holds the instruction stream the human enters.
- Main memory is where Rodney's self-programming behavior takes place.

So, in this topic area, ROM is described as persistent storage for startup or reflex code, not as the place where Rodney's self-programming logic is created by Rodney himself.

## Discrete Self-Programming Mechanism

If your goal is to find the book's actual discrete self-programming mechanism, the key section is the `Gamma` routine, not the optional ROM.

- `1203`
  Evidence: "RUN GAMMA-1" and "Figure 12-2 is the flowchart for the GAMMA portion..."
  Why it matters: This is the entry point and top-level control structure for the self-programming process.

- `1204`
  Evidence: the flowchart terms `MMA REL`, `FETCH MMD`, `CONL=3`, `SET BIT 1`, `SET BIT 0`, `LOAD NEW MMD`
  Why it matters: This page describes the actual generalization algorithm that rewrites low-confidence memory entries from high-confidence patterns.

- `1205`
  Evidence: "that's the nature of this self-programming process"
  Why it matters: This is the clearest page where the book explicitly names the Gamma generalization behavior as the self-programming process.

- `1206`
  Evidence: "There is no such thing here as a programming 'tree.' The environment and Rodney's initial responses to it set the pace, but each encounter with the environment further modifies and refines all activity."
  Why it matters: This is the most explicit conceptual description of how the self-programming differs from ordinary fixed programming.

- `1207`
  Evidence: "The important Gamma subroutine is listed here as The Main Gamma-1 Program. This is all new programming."
  Why it matters: This is the strongest candidate for the discrete code you are looking for: an actual program listing tied to the self-programming mechanism.

## Best Pages For Actual Code

If you want pages with program listings or code nearest to the self-programming claim, focus on:

- `1207`
  Gamma routine listing. This is the most directly self-programming code page.

- `1110`
  Beta Rodney-One program listing.
  Useful because Gamma is added on top of Beta.

- `1112`
  `RUAPX` subroutine listing used by Beta/Gamma support logic.

- `1007`
  Alpha Rodney-One program listing.
  Useful as the base behavior layer beneath Beta and Gamma.

## Bottom Line

The book's title phrase `self-programming` is most concretely realized in:

- the main-memory scheme on `0205`
- the Gamma process explanation on `1203`-`1206`
- the Gamma code listing on `1207`

ROM is not the discrete self-programming mechanism. The strongest discrete mechanism is the `Gamma` routine that scans main memory, generalizes from high-confidence responses, and writes revised low-confidence entries back into memory.
