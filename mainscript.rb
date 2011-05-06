text_tokenized = ARGV[0]
text_merged = ARGV[1]
option = ARGV[2].to_i

start = "" + ARGV[0][0].to_s + ARGV[0][1].to_s

for i in 1..2
	num = i*25
	name = num.to_s
	
	if option == 2
		aname = start + name + "_geq_a.txt"
		bname = start + name + "_geq_b.fst"
		cname = start + name + "_geq_c.txt"
		dname = start + name + "_geq_d.txt"
	elsif option == 1
		aname = start + name + "_a.txt"
		bname = start + name + "_b.txt"
		cname = start + name + "_c.txt"
		dname = start + name + "_d.txt"
	else
		puts "Invalid argument"
		break
	end
	
	if option == 2
		system("ruby brown_fstmaker.rb top400stripgeq2.txt #{aname} #{num}")
	else
		system("ruby brown_fstmaker.rb top400strip.txt #{aname} #{num}")
	end
	system("fstcompile --isymbols=test.sym --osymbols=test.sym --keep_isymbols --keep_osymbols #{aname} #{bname}")
	system("python test-string2.py #{bname} #{text_merged} #{cname}")
	system("ruby stripmerged.rb #{cname} #{dname}")
	puts "For #{num} words, we get:"
	system("python eval.py -f #{text_tokenized} -p #{dname}")
end