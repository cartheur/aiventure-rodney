# aiventure-rodney

A project revolving around Heiserman's 1979 robotics proposition. The focus is _scratch-building_ computer that possesses and executes self-learning machine code. They [ref]--(I think an Motorola 6800 computer design book) say this is _a dangerous practice_ having a comptuer self-generate code - with the notion that it programs - but if we do not start seriously exploring in slower formats (slow that our brains can recognize *good* from *bad*), then we we stay stuck.

Given the time spent with _Ideal_, games will get one just so far; an effort begins today where we emplant Rodney onto a wheeled platform. Once there, we will backpropagate different kinds of dangerous things.

I think this has been accomplished before, I mean the robot by the unknown designer and creator a late academic dubbed _Tati_. And I've watched his films, they are brilliant and keep me in this vein.

## What is in here?

This repository contains a revitialization of the idea of a self-programming robot coupled with the ambition to learn the deepest aspects of how a computer functions at its most basic level. The book, written in 1978, leverages an Intel 8085 8-bit (the very last CPU made to this specification) where the reader builds up the system from scratch including the logic, buffers, and memory systems. Additionally, a tape-drive storage interface is described. Not just an historical curiousity, Rodney continues to teach readers by having them build one step at a time.

The challenge of this project is to make a build of the microcomputer system to examine the merit of the "self-programming" claim. On this rests *everything* claimed 'A.I.'. This is a total misnomer and will need to be discussed in great detail.

Also here is the earliest 86-DOS version to be [published](/software/ReadMe.md). CP/M is a concerted effort going forward.

### Progress

The foundations in metal have been constructed and starting the design phase.

Have the UI indicator light pattern thusly:

![pattern](/images/indicating-pattern.jpg)

### Making things easier

As wirewrapping is _always_ the mirror-inverse, an old technique is the _wrap id_:

![image](/models/wrap-id-18-relative.png)

As stock is hard-to-find, will create a 3D-printed model. As a datasheet is rather untenable, a datasheet from the wirewrap sockets is a good measure.

![image](/models/ww-sockets.jpg)

### The rise of 8-bit AI

AI image generators are very popular these days, and the results are used in all sorts of creative projects. This made me wonder what it would have been like if image generators had existed during the early personal computer revolution in the 1980s. What would they have been like, and what would the images have been used for?

Today's algorithms, like Stable Diffusion, require a huge amount of computational resources that simply cannot be made to work (in any reasonable way) on machines of the era. But with some work, a simpler generative algorithm could be used to produce images. So I decided to adapt a probabilistic PCA algorithm to run on a Commodore 64, with the goal of producing 8x8 retro game sprites that could have been used to inspire a game design.

I started by building a model using a modified version of the Python code found in this tutorial. I made about 100 retro-inspired sprites (represented as binary strings) with the help of a spreadsheet I made. This data was used to train the model on a modern computer with modified scripts from the tutorial.

This produces a number of parameter values (a mean matrix, covariance matrix, etc.) that only need to be calculated once for a given dataset. These were then plugged into a script I created with simplified logic — no NumPy or other libraries — to run the randomization and generative parts of the algorithm. This simplification made it easy to convert the logic into BASIC code that is compatible with the Commodore 64. That code is then loaded onto a C64 to generate unique images that fit in the distribution of the training data. Finally, the 8x8 images are expanded to 64x64 and displayed on the screen.

The number of iterations the algorithm goes through can be varied. More iterations produces better results generally, but takes longer. At 94 iterations, it takes about 20 minutes to run on a C64. Not really too bad considering how long a modern image generator would take on a modern computer without a GPU.

From [here](https://hackaday.io/project/195819-commodore-64-ai-image-generator).

### Taking a walk on the wild-side

As it is necessary to explore the algorithm of [ideal](https://github.com/cartheur/ideal), we are stretching into unknown realms. How do we document this unexpected journey?

* An alternative to the Von Neumann architecture is the [initiative](/literature/s41565-020-0738-x.pdf).
* A combination of hardware and software [implementation](https://en.wikipedia.org/wiki/In-memory_processing).
* What are some forward-looking paths, considering the initiatives, without going into the nanoscale esoteric?
* SRAM and DRAM are perfectly capable of performing in-memory logic operations while NAND Flash memory is fit for matrix–vector multiplication operations.
* In the context of the application-specific approach to computation, memory-based computational primitives can be used in a variety of tasks ranging from high-precision scientific computing to largely imprecise stochastic computing and everything in-between including deep learning in artificial neural networks (ANNs). 