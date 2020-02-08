# text2imagewriter.rb - print text to Apple Imagewriter with formatting commands

class Text2Imagewriter
  def main
    # TODO: should be able to read a file from STDIN
    Kernel.abort "Usage: text2imagewriter.rb [FILENAME]" if !ARGV[0]
    filename = ARGV[0]

    f = File.open(filename)
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

    count = 0
    
    f.read.each_char do |c|
      if count == 1000
        sleep(1.5)
        count = 0
      end
      print c
      count += 1
    end

    f.close
  end
end

# aaaaand go
Text2Imagewriter.new.main
