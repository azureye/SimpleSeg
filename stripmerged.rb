def main
	# name of the file we want to strip
	#name = "alice100break.txt"
	name = ARGV[0]
	
	# file we'll be writing to
	#my_file = File.new("alice_merged_stripped.txt",'a')
	my_file = File.new(ARGV[1],'a')
	
	# open the file we'll be reading from
	File.open name, "r" do |f|
		# for each line...
		f.each_line do |line|
			# strip leading and trailing whitespace
			if line[0] == 32 || line[0] == " "
				line.slice!(0)
			end
			if line[line.size-1] == 32 || line[line.size-1] == " "
				#puts "chomping"
				line.chomp!
			end
			#printf "#{line}w\n"
			#line = line.lstrip
			#line = line.rstrip
			# turn double spaces into single spaces
			line = line.gsub("  "," ")
			# write to file
			my_file.puts(line)
		end
	end
end

main