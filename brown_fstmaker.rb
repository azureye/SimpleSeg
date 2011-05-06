def main
	# stands for "arbitrarily high probability"
	ahp = 20000000000000000000000
	
	master_count = 1

	# file we'll be writing to
	#my_file = File.new("100dictfst.txt",'a')
	my_file = File.new(ARGV[1],'a')

	for letter in "a".."z"
		my_file.printf "0 0  #{letter} #{letter} #{ahp}\n"
	end
	
	# file we'll be reading from
	#readfile = "100common.txt"
	readfile = ARGV[0]
	
	# number lines we want to read
	lines_desired = ARGV[2].to_i
	current_line = 0
	
	# open the file we'll be reading from
	File.open readfile, "r" do |f|
		# for each line...
		f.each_line do |line|
			line.chomp!
			my_file.printf "0 #{master_count} <eps> <spc> 0\n"
			
			line.each_char do |char|
				if master_count-1 == 6
					puts char
				end
				master_count += 1
				if char == " "
					my_file.printf "#{master_count-1} #{master_count} <spc> <spc> 0 \n"
				else
					my_file.printf "#{master_count-1} #{master_count} #{char} #{char} 0 \n"
				end
			end
			
			my_file.printf "#{master_count} 0 <eps> <spc> 1\n"
			master_count+=1
			current_line += 1
			if current_line >= lines_desired
				break
			end
		end
		my_file.print "0 0"
	end	

end

main