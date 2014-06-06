class ThermalImageSize
  def initialize(width, height, row_height=24)
    @width = width.to_i
    @height = height.to_i
    @row_height = row_height.to_i
  end

  def width_in_bits
    @width
  end

  def height_in_bits
    @height
  end

  def height_of_row_in_bits
    @row_height
  end

  def height_of_print_image_in_bits
    overage = height_in_bits % height_of_row_in_bits
    if overage == 0
      height_in_bits
    else
      height_in_bits + height_of_row_in_bits - overage
    end
  end

  def bits_in_print_row
    width_in_bits * height_of_row_in_bits
  end

  def bits_in_print_image
    width_in_bits * height_of_print_image_in_bits
  end

  def print_row_bytes
    r = width_in_bits
    hex = r.to_s(16)
    if hex.length == 3
      nh = "0" + hex[0]
      nl = hex[1,2]
    elsif hex.length == 2
      nh = "00"
      nl = hex
    elsif hex.length == 1
      nh = "00"
      nl = "0" + hex
    end
    nl.to_i(16).chr + nh.to_i(16).chr
#    "\\x%s\\x%s" % [nl, nh]
  end
end
