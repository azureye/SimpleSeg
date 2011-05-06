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
	
	big_total = 0.0
	
	File.open readfile, "r" do |f|
		f.each_line do |line|
			line.chomp!
			if /[a-z ]* ([0-9]*)/.match(line) != nil
				number = /[a-z ]* ([0-9]*)/.match(line)[1].to_i
				big_total = big_total + number
			end
			current_line += 1
			if current_line >= lines_desired
				break
			end
		end
	end
	
	current_line = 0
	
	# open the file we'll be reading from
	File.open readfile, "r" do |f|
		# for each line...
		f.each_line do |line|
			line.chomp!
			my_file.printf "0 #{master_count} <eps> <spc> 0\n"
			if /([a-z ]*) [0-9]*/.match(line) != nil
				word = /([a-z ]*) [0-9]*/.match(line)[1]
				number = /[a-z ]* ([0-9]*)/.match(line)[1].to_i
				word.each_char do |char|
					#puts char
					if master_count-1 == 6
						#puts char
					end
					master_count += 1
					if char == " "
						my_file.printf "#{master_count-1} #{master_count} <spc> <spc> 0 \n"
					else
						my_file.printf "#{master_count-1} #{master_count} #{char} #{char} 0 \n"
					end
				end
				
				weight = 1.0 - (number / big_total)
			
				my_file.printf "#{master_count} 0 <eps> <spc> #{weight}\n"
				master_count+=1
				current_line += 1
				if current_line >= lines_desired
					break
				end
			end
		end	
		
		my_file.print "0 0"

	end
end

main