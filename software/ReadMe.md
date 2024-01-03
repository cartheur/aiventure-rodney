## Software on the cusp of 8-bit

* 86-DOS Version 0.1-C

Serial #11
Copyright 1980 by Seattle Computer Products

This is the precursor to MS-DOS and is likely the oldest known version to survive. This disk can be booted via the SIMH emulator.

### Quick Start Guide to running 86-DOS on SIMH/AltairZ80

* Unzip all files from the archive into a directory on your PC.
* Then run the AltairZ80 simulator using the scp86mon startup script. This can be found [here](http://cpmarchives.classiccmp.org/cpm/mirrors/www.schorn.ch/cpm/intro.php). PC, Linux and source are in [this](/software/SIMH/) folder.
* Press <return> a few times to get the SCP 8086 Monitor '>' prompt.
* Type 'B' at the monitor prompt (uppercase) to boot 86-DOS.
* Enter a date, note that 86-DOS is not Y2K compliant, and will reject recent dates.
* 86-DOS Manuals are available from: http://www.patersontech.com/dos/manuals.aspx (dead link, no archive)

```
=====================================================
=========== Transcript of booting 86-DOS ============
=====================================================
C:\86DOS>AltairZ80.exe scp86mon
M68K Reset

Altair 8800 (Z80) simulator V3.7-3 build 1000 (scp created Jun  5 2008 at 22:27:
41)

2047 bytes [8 pages] loaded at 0.
2047 bytes [8 pages] loaded at ff800.


SCP 8086 Monitor 1.5
>B
?
86-DOS version 1.00
Copyright 1980,81 Seattle Computer Products, Inc.
Enter today's date (m-d-y): 06-05-82

COMMAND v. 1.00

A:DIR
COMMAND   COM        1842  04-28-81
RDCPM     COM        1310  04-30-81
CHKDSK    COM        1110  04-24-81
TRANS     COM        3088  04-24-81
ASM       COM        6389  04-28-81
DEBUG     COM        5153  04-29-81
EDLIN     COM        2144  04-28-81
HEX2BIN   COM         483  04-18-81
SYS       COM         154  04-24-81
MAKRDCPM  COM         303  04-30-81
INITLARG  COM         509  04-28-81
INITSMAL  COM         507  04-28-81
CPMTAB    ASM        1072  04-30-81
BOOT      ASM        2602  04-28-81
INIT      ASM        5595  04-28-81
DOSIO     ASM       24277  04-30-81
MON       ASM       35502  04-28-81
NEWS      DOC        1404  04-28-81
NEW       BAT         101  04-24-81

A:
```