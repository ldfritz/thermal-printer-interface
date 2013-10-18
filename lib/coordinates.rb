class Coordinates
  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def to_image_bit_index(image_width, height_of_print_row)
    w = image_width
    h = height_of_print_row
    (@x * h) + ((@y / h) * (h * w)) + (@y % h)
  end
end
