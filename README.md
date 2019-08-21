# png2imagewriter
Converts PNG images into appropriate gibberish to drive an Apple Imagewriter dot-matrix printer

## Requirements
* Ruby 2.something
* A USB serial adapter
* A serial printer style null modem adapter
* An Apple ImageWriter (tested on a 15”, a II should work although in 72DPI mode, dunno about an LQ)

## Installation
* Figure out where your USB serial adapter shows up under /dev; it’s usually something like /dev/ttyUSB0.
* Clone the repo to a directory of your choosing
* In that directory, run
```
ruby src/png2imagewriter.rb FILENAME > /dev/ttyUSB0
```
