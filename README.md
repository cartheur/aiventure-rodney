# aiventure-rodney

A project revolving around Heiserman's 1979 robotics proposition. The focus is _scratch-building_ computer that possesses and executes self-learning machine code. They [ref]--(I think an Motorola 6800 computer design book) say this is _a dangerous practice_ having a comptuer self-generate code - with the notion that it programs - but if we do not start seriously exploring in slower formats (slow that our brains can recognize *good* from *bad*), then we we stay stuck.

Given the time spent with _Ideal_, games will get one just so far; an effort begins today where we emplant Rodney onto a wheeled platform. Once there, we will backpropagate different kinds of dangerous things.

I think this has been accomplished before, I mean the robot by the unknown designer and creator a late academic dubbed _Tati_. And I've watched his films, they are brilliant and keep me in this vein.

## What is in here?

This repository contains a revitialization of the idea of a self-programming robot coupled with the ambition to learn the deepest aspects of how a computer functions at its most basic level. The book, written in 1978, leverages an Intel 8085 8-bit (the very last CPU made to this specification) where the reader builds up the system from scratch including the logic, buffers, and memory systems. Additionally, a tape-drive storage interface is described. Not just an historical curiousity, Rodney continues to teach readers by having them build one step at a time.

The challenge of this project is to make a build of the microcomputer system to examine the merit of the "self-programming" claim. On this rests *everything* claimed 'A.I.'. This is a total misnomer and will need to be discussed in great detail.

### Progress

The publication for this is drafted [here](https://github.com/pub-n-dub/native-self-programming).

### Wiring-up the user-interface (UI)

Here we are using binary to program the machine. In order to accomplish this, a set of swutches and lights indicate the patterns that are input. The UI indicator light pattern is thusly:

![pattern](/images/indicating-pattern.jpg)

### Errata

As it is necessary to explore the algorithm of [ideal](https://github.com/cartheur/ideal), we are stretching into unknown realms. How do we document this unexpected journey?

* An alternative to the Von Neumann architecture is the [initiative](/literature/s41565-020-0738-x.pdf).
* A combination of hardware and software [implementation](https://en.wikipedia.org/wiki/In-memory_processing).
* What are some forward-looking paths, considering the initiatives, without going into the nanoscale esoteric?
* SRAM and DRAM are perfectly capable of performing in-memory logic operations while NAND Flash memory is fit for matrix–vector multiplication operations.
* In the context of the application-specific approach to computation, memory-based computational primitives can be used in a variety of tasks ranging from high-precision scientific computing to largely imprecise stochastic computing and everything in-between including deep learning in artificial neural networks (ANNs). 