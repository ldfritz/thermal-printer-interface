module ThermalPrinter
  NORMAL_WIDTH_AND_HEIGHT = [27, 33,  0]
  DOUBLE_HEIGHT           = [27, 33, 16]
  DOUBLE_WIDTH            = [27, 33, 32]
  DOUBLE_WIDTH_AND_HEIGHT = [27, 33, 48]

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

  def self.activate
    if File.writable?(ThermalPrinter.location)
      true
    else
      puts "enter password to activate printer"
      command = "sudo chmod 666 #{ThermalPrinter.location} && echo success"
      require "open3"
      Open3.capture2(command)[0] == "success\n"
    end
  end
end
