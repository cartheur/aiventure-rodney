## Tests in this folder

A series of sanity checks and operational tests are contained in this folder. Note that textural references to hexidecimal numbers will have the `H` character as suffix.

### Check

_Analysis_

* `000 00`: At memory address `000H`, the data `00H` is loaded, which is a `NOP` (no operation) instruction.
* `001 C7`: At memory address `001H`, the data `C7H` is loaded, which is described as a command to return to address `000H` (labeled as `TEST`).
* `TEST`:: A label marking the address `000H`.
* `;RETURN TO TEST`: A comment indicating the purpose of the `C7` instruction, which is to return execution to the `TEST` label (address `000H`).

This code creates a simple loop where the microprocessor executes a `NOP` at `000H`, then at `001H` executes an instruction (`C7`) that returns it to `000H`, repeating indefinitely.

_Instructions_

Set up the panel address for `000H` and `LOAD` `00H`. This is a `NOP` (no operation) command. Then set the address to `001H` and `LOAD` data `C7` (a command that tells the system to return to address `000H`). You are telling the microprocessor to do nothing and then return to doing nothing again. Ideally, the system will buzz back and forth between these two commands at an r-f rate.

In a semi-assembly programming format used for most of the work remaining in this book, this simple program will look something like [this](/tests/check.asm).

Now set the `RUN/PROGRAM` switch to `RUN`. IF the `RESET` switch is still ON (as it should be at this point), nothing should happen. Return the system to `PROGRAM` after a few seconds and check the content of the program RAM. The data at 000H address should still be 00H and the data at `001H` should still be `C7H`. If it is not, something is wrong with the `RESET` wiring between the front panel and the microprocessor. Do not go any further with the testing until you are convinced the program RAM holds the 2-step program when switching the system between `RUN` and `PROGRAM`.

Check if things get scrambed.

### All ones

_Analysis_

* Address `000H` (`21 00 08`): The instruction `LXI` `H`,`PORT0` loads the register pair `H` and `L` with the address `0800H` (likely a port address labeled `PORT0`).
* Address `003H` (`3E FF`): The instruction `MVI` `A`,`FFH` loads the accumulator `A` with the value `FFH` (255 in decimal).
* Address `005H` (`77`): The instruction `MOV` `M`,`A` moves the content of the accumulator `A` to the memory location pointed to by the `H` and `L` registers (i.e., `PORT0`).
* Address `006H` (`C7`): The instruction `RST` `0` performs a reset by jumping to address `0000H`, effectively restarting the program.

This code appears to be written for an 8085 microprocessor, as the opcodes and mnemonics (`LXI`, `MVI`, `MOV`, `RST`) match the 8085 instruction set. The program initializes a port (`PORT0`) with the value `FFH` and then resets to the start.

_Instructions_

Things will probably get scrambled every time. If the program isn’t scrambled by some quirk of good fortune, try it again for several minutes. You cannot afford to hedge on this bet—programs must remain intact in the program RAM indefinitely. Let’s suppose the program isn’t getting scrambled and you are wondering what this fuss is all about. In this case, the system just might not be working right anyhow. Try [this](/tests/all-ones.asm) program. If you have been doing your homework on 8085 instruction sets and programming, you will see that this program loads all 1’s at the motor-control outputs (`Port 0`). The 3-digit numbers are address locations and the 2-digit numbers are hex data to be entered at the outputs. Since the first line of the program uses three different bytes of data, it figures they will occupy address locations `000H`, `001H` and `002H`. That’s why the second line begins with address `003H`. Load this little program but before `RUN`ing it, turn off the motor status lamps by addressing `Port 0` (`800H`) and `LOAD`ing data `00H`. Then start the program by first setting the system to RUN and then turning off the `RESET` switch. If the system is reading the program properly, the motor status lamps should turn on and remain on. They probably won’t stay on, but they should. If your system wasn’t scrambling the 2-step `TEST` program, but the `OTEST` program doesn’t run right, you know the system isn’t executing any commands. If that’s the case, you have to doublecheck a lot of circuitry, beginning with the program RAM tests in [Chapter 7](/build/7-ram-ports/README.md) and working all the way through the static tests in the previous section of this chapter.

### Conclusion

Maybe it isn’t so bad to have the 2-step `TEST` program fouling up after all. At least you know the microprocessor is executing commands. The commands are _garbage_, but at least that part of the system is working. The odds against the system running both of these dynamic test programs are tremendous.

