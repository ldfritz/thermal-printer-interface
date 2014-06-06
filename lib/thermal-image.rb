load File.dirname(__FILE__) + "/thermal-image-array.rb"
load File.dirname(__FILE__) + "/thermal-image-size.rb"
load File.dirname(__FILE__) + "/coordinates.rb"

class ThermalImage
  def initialize(width, height)
    @size = ThermalImageSize.new(width, height)
    @array = ThermalImageArray.new(@size.bits_in_print_image)
  end

  def add_bit(x, y)
    coord = Coordinates.new(x, y)
    index = coord.to_image_bit_index(@size.width_in_bits, @size.height_of_row_in_bits)
    @array.add_bit(index)
  end

  def dump
    cursor = 0
    output = ""
    while cursor < @size.bits_in_print_image
      if cursor % @size.bits_in_print_row == 0
        output << "\x1b".chr << "\x2a".chr << "\x21".chr
        output << @size.print_row_bytes
      end

      output << @array.bits[cursor, 8].join.to_i(2).chr

      cursor += 8

      if cursor % @size.bits_in_print_row == 0
        output << "\n"
      end
    end
    output << ("\n" * 4)
  end
end
