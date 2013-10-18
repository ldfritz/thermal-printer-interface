load File.dirname(__FILE__) + "/thermal-image.rb"

src = ARGV[0]
dest = ARGV[1]

src_file = File.readlines(src)

size_match = src_file[0].match(/: (\d+),(\d+)/)
width = size_match[1]
height = size_match[2]

image = ThermalImage.new(width, height)

black_lines = src_file.find_all {|line| line =~ /black/}

black_lines.each do |line|
  coords_match = line.match(/^(\d+),(\d+)/)
  x = coords_match[1]
  y = coords_match[2]

  image.add_bit(x, y)
end

File.open(dest, "w") do |file|
  file.puts image.dump
end
