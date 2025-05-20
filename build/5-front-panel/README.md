## Chapter 5: Front panel Program/Test assembly

While Rodney is essentially a self-programming machine, there is still a need for entering a small selection of programs from the outside world. An animal might be born knowing exactly nothing about how to cope with its environment, but even so, it is born with an underlying reflex mechanism that helps the learning process begin.

_Description_

The system contains a 12-bit addressing and 8-bit data format.

### The Task

Is to assemble the front panel assembly that looks like this:

![assembly](/build/5-front-panel/images/indicating-pattern.jpg)

Where we have the orange indicators as the low 4-bits, green indicators as the mid 4-bits of the address-bus and high 4-bits for the data-bus, yellow indicators as the high 4-bits of the address-bus.

In order to accomplish this, a set of three cables extend from a set of pins to another board:

![fig5.1](/build/5-front-panel/images/fig.5-1.png)

Where the corresponding wiring pattern of the _user interface_ is thusly:

![pattern](/build/5-front-panel/interface/user-interface.png)

Using the colors from the lamps to show where the wires connect.