module ThermalPrinter
  NORMAL_WIDTH_AND_HEIGHT = "\e!\x00" # [27, 33,  0]
  DOUBLE_HEIGHT           = "\e!\x10" # [27, 33, 16]
  DOUBLE_WIDTH            = "\e! "    # [27, 33, 32]
  DOUBLE_WIDTH_AND_HEIGHT = "\e!0"    # [27, 33, 48]

  # Activate the printer.  (This may require user input.)
  def self.activate!
    if File.writable?(ThermalPrinter.location)
      true
    else
      puts "enter password to activate printer"
      command = "sudo chmod 666 #{ThermalPrinter.location} && echo success"
      require "open3"
      if Open3.capture2(command)[0] == "success\n"
        true
      else
        puts "error activating printer"
        exit
      end
    end
  end

  # Add sizing escapes to the content.
  def self.format_text(content, text_size=false)
    if text_size
      content = text_size + content + ThermalPrinter::NORMAL_WIDTH_AND_HEIGHT
    end
    content
  end

  # Return (or detect) the path of the printer.
  def self.location
    return @location if @location
    device_folder = "/dev/usb"
    printer = Dir.entries(device_folder).find_all {|i| i =~ /^lp/ }.first
    if printer
      @location = [device_folder, printer].join("/")
    else
      nil
    end
  end

  # Send text to the printer.
  def self.write(content)
    ThermalPrinter.activate!
    File.open(ThermalPrinter.location, "w") {|printer| printer.puts content }
  end
end
