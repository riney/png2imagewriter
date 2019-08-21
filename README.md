# png2imagewriter
Converts PNG images into appropriate gibberish to drive an Apple Imagewriter dot-matrix printer

## Requirements
* Ruby 2.something
* A USB serial adapter
* A serial printer style null modem adapter
* An Apple ImageWriter (tested on a 15”, a II should work although in 72DPI mode, dunno about an LQ)

## Installation
* Prepare an image; it should be monochrome (1-bit), and the height and width should be multiples of 8. (There's a TODO to take arbitrarily sized images.) The ImageWriter/ImageWriter 15 run at 72 DPI, so resize the image accordingly.

* Figure out where your USB serial adapter shows up under /dev; it’s usually something like /dev/ttyUSB0.

* Set the baud rate of the serial port to 9600 baud (unless you've set the printer to something else; 9600 is the default. On Linux, this looks like 

```
stty -F /dev/ttyUSB0 9600
```

* Clone the repo to a directory of your choosing
* In that directory, run
```
ruby src/png2imagewriter.rb FILENAME > /dev/ttyUSB0
```

Enjoy several minutes of screeching.
