# png2imagewriter.rb - convert monochrome PNGs to Apple Imagewriter control commands

require 'chunky_png'

class Png2Imagewriter
  def main
    # TODO: should be able to read a file from STDIN
    Kernel.abort "Usage: png2imagewriter.rb [FILENAME]" if !ARGV[0]

    png = ChunkyPNG::Image.from_file ARGV[0]

    # TODO: clean up init code

    # reset printer
    print 27.chr
    print 99.chr
    sleep(0.1)

    # set square pitch
    print 27.chr
    print 'N'
    print 27.chr
    print "T16"
    sleep(0.1)

    # turn off bidirectonal (boustrophedon) printing for more quality
    print 27.chr
    print 62.chr
    sleep(0.1)

    # TODO: not doing anything with this right now, image size is expected to be divisible by 8
    leftovers = png.height.modulo(8)
    strip_count = (png.height - png.height.modulo(8)) / 8

    # plow through the image, one 8-pixel high row at a time, and generate a "strip" of integers
    strip = Array.new(6 + png.width, 0)

    # Each strip starts with ESC G wwww - wwww is the width, zero padded
    strip[0] = 27
    strip[1] = 71
    length = png.width.to_s.rjust(4, "0")
    strip[2] = length[0].ord
    strip[3] = length[1].ord
    strip[4] = length[2].ord
    strip[5] = length[3].ord

    # Turn pixels to bits, vertically swapped
    # TODO: provide documentation reference
    for strip_index in 0..strip_count-1
      for i in 0..png.width-1
        strip[6+i] =  ((png[i, 8 * strip_index + 7] == 255) ? 1 << 7 : 0) |
                      ((png[i, 8 * strip_index + 6] == 255) ? 1 << 6 : 0) |
                      ((png[i, 8 * strip_index + 5] == 255) ? 1 << 5 : 0) |
                      ((png[i, 8 * strip_index + 4] == 255) ? 1 << 4 : 0) |
                      ((png[i, 8 * strip_index + 3] == 255) ? 1 << 3 : 0) |
                      ((png[i, 8 * strip_index + 2] == 255) ? 1 << 2 : 0) |
                      ((png[i, 8 * strip_index + 1] == 255) ? 1 << 1 : 0) |
                      ((png[i, 8 * strip_index] == 255) ? 1 : 0)
      end

      strip.each { |c| print c.chr }
      print "\n"

      # It takes this long for the carriage to return to home
      # TODO: should really just be counting characters and writing a bufferful at a time
      sleep(1.5)
    end
  end
end

# aaaaand go
Png2Imagewriter.new.main
