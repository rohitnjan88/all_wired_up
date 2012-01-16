require 'all_wired_up'
require 'optparse'

options = {}
OptionParser.new do |opts|
	opts.banner = "Usage: #{__FILE__} [options]"
	opts.on("-i", "--input-file FILE", "Input circuits file") do |input|
		options[:input] = input
	end
	opts.on("-o", "--output-file FILE", "Output circuits file") do |output|
		options[:output] = output
	end
end.parse!

parsed  = AllWiredUp::Parser.new(options[:input])
circuit = AllWiredUp::Circuit.new(parsed.matrix)

File.open(options[:output], 'w') do |of|
	parsed.bulb_positions.each do |bulb_index|
		of.puts circuit.solve_circuit(bulb_index)
	end
end
