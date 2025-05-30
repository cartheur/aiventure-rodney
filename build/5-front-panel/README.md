## Chapter 5: Front panel Program/Test assembly

While Rodney is essentially a self-programming machine, there is still a need for entering a small selection of programs from the outside world. An animal might be born knowing exactly nothing about how to cope with its environment, but even so, it is born with an underlying reflex mechanism that helps the learning process begin.

_Description_

The system contains a 12-bit addressing and 8-bit data format.

### The Task

Is to assemble the front panel assembly that looks like this:

![assembly](/build/5-front-panel/images/indicating-pattern.jpg)

Where we have the orange indicators as the low 4-bits, green indicators as the mid 4-bits of the address-bus and high 4-bits for the data-bus, yellow indicators as the high 4-bits of the address-bus. The LEDs to be used are these:

| Color                | Voltage Vf | Manufacturer |
|----------------------|------------|--------------|
| Pure Orange Diffused | 2.1        | Kingbright   |
| Green Diffused       | 2.1        | LiteOn       |
| Yellow Diffused      | 2.1        | Lumex        |

Where the notion of _diffused_ gives a special property:

![diffused](/tools/images/diffused.jpg)

In order to accomplish this, a set of three cables extend from a set of pins to another board:

![fig5.1](/build/5-front-panel/images/fig.5-1.png)

Where the detail of the connections (addressing) is recommended as:

![fig5.5](/build/5-front-panel/images/fig.5-5.png)

And the detail of the connections (data) is recommended as:

![fig5.8](/build/5-front-panel/images/fig.5-8.png)

Notice how:

* `+5v`, denoted as `PZ02` - `PIN 16`, is shared between the address and data circuits and,
* `COMM`, denoted as `PZ02` - `PIN 8`, is shared between all circuits in the panel.

Therefore, the corresponding wiring pattern of the _user interface_ is thusly:

![pattern](/build/5-front-panel/interface/user-interface.png)

Using the colors from the lamps to show where the wires [connect](/tools/README.md).

_Connection from the panel_

The wires coming into the triad of 16-pin ribbon cable will first be wired to the appropriate connections:

![fig5.7](/build/5-front-panel/images/fig.5-7.png)

For the address and for the data:

![fig5.10](/build/5-front-panel/images/fig.5-10.png)

Meaning there are these requring a 22k-Ohm resistor:

* `12 AS` (`PR207`) + `8 DS` + `2 SS` + `1 PB` (`PR205`) = 23 slots.

And these requiring a 150-Ohm resistor bank:

* `12 AL` (`PR208`) + `8 DL` (`PR206`) = 20 slots.

That leads into the bus system components:

![fig5.6](/build/5-front-panel/images/fig.5-6.png)