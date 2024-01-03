## Running SIMH

_How to use the simulator on various platforms (Intel)_

* Download the simulator with documentation and [CP/M 2.2](/software/SIMH/cpm2.zip).
* Unpack the simulator to obtain `altairz80.exe`, the disk image `cpm2.dsk` and the command file `cpm2`. Put all files into one folder.
* Start the simulator and type the command do `cpm2` at the sim> command prompt and CP/M is booted.

Here is what is included in this version.

* Operating system
* Microsoft Basic and [Eliza](https://en.wikipedia.org/wiki/ELIZA)
* Microsoft development tools M80 and L80, debugger DDTZ
* SPL: a compiler for a C-like, Simple Programming Language
* PROLOGZ (interactive Prolog development environment)
* SPL sources for PROLOGZ
* Pascal MT+ compiler and Pascal pretty printer (Pascal source)
* Assembler sources for CP/M 2.2 BDOS, CCP and Altair BIOS
* Assembler source and documentation for CCPZ, a CCP replacement written for the Z80
* .SUB files to re-create CP/M 2.2 from the supplied sources
* Othello and Ladder (games)
* Many utilities with SPL or assembler sources

### Technical details of CP/M

_Components_

In the 8-bit versions, while running, the CP/M operating system loaded into memory espoused

* Basic Input/Output System (BIOS),
* Basic Disk Operating System (BDOS),
* Console Command Processor (CCP).

The BIOS and BDOS were memory-resident, while the CCP was memory-resident unless overwritten by an application, in which case it was automatically reloaded after the application finished running. A number of transient commands for standard utilities were also provided. The transient commands resided in files with the extension .COM on disk.

The BIOS directly controlled hardware components other than the CPU and main memory. It contained functions such as character input and output and the reading and writing of disk sectors. The BDOS implemented the CP/M file system and some input/output abstractions (such as redirection) on top of the BIOS. The CCP took user commands and either executed them directly (internal commands such as DIR to show a directory or ERA to delete a file) or loaded and started an executable file of the given name (transient commands such as PIP.COM to copy files or STAT.COM to show various file and system information). Third-party applications for CP/M were also essentially transient commands.

The BDOS, CCP and standard transient commands were the same in all installations of a particular revision of CP/M, but the BIOS portion was always adapted to the particular hardware.

Adding memory to a computer, for example, meant that the CP/M system had to be reinstalled to allow transient programs to use the additional memory space. A utility program (MOVCPM) was provided with system distribution that allowed relocating the object code to different memory areas. The utility program adjusted the addresses in absolute jump and subroutine call instructions to new addresses required by the new location of the operating system in processor memory. This newly patched version could then be saved on a new disk, allowing application programs to access the additional memory made available by moving the system components. Once installed, the operating system (BIOS, BDOS and CCP) was stored in reserved areas at the beginning of any disk which would be used to boot the system. On start-up, the bootloader (usually contained in a ROM firmware chip) would load the operating system from the disk in drive A:.

By modern standards CP/M was primitive, owing to the extreme constraints on program size. With version 1.0 there was no provision for detecting a changed disk. If a user changed disks without manually rereading the disk directory the system would write on the new disk using the old disk's directory information, ruining the data stored on the disk. From version 1.1 or 1.2 onwards, changing a disk then trying to write to it before its directory was read would cause a fatal error to be signalled. This avoided overwriting the disk but required a reboot and loss of the data that was to be stored on disk.

The majority of the complexity in CP/M was isolated in the BDOS, and to a lesser extent, the CCP and transient commands. This meant that by porting the limited number of simple routines in the BIOS to a particular hardware platform, the entire OS would work. This significantly reduced the development time needed to support new machines, and was one of the main reasons for CP/M's widespread use. Today this sort of abstraction is common to most OSs (a hardware abstraction layer), but at the time of CP/M's birth, OSs were typically intended to run on only one machine platform, and multilayer designs were considered unnecessary.

Enjoy what was old is new again.