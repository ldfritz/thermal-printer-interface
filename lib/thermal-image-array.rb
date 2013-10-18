class ThermalImageArray
  def initialize(size)
    @image_bits = Array.new(size, 0)
  end

  def add_bit(index)
    @image_bits[index] = 1
  end

  def bits
    @image_bits
  end
end
