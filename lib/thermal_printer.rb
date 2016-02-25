module ThermalPrinter
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
