text_tokenized = ARGV[0]
text_merged = ARGV[1]

start = "" + ARGV[0][0].to_s + ARGV[0][1].to_s

for i in 1..15
	num = i*25
	name = num.to_s

	aname = start + name + "_geq_a_uni.txt"
	bname = start + name + "_geq_b_uni.fst"
	cname = start + name + "_geq_c_uni.txt"
	dname = start + name + "_geq_d_uni.txt"
	
	system("ruby brown_fstmaker_special.rb top400stripgeq2withprobs.txt #{aname} #{num}")
	system("fstcompile --isymbols=test.sym --osymbols=test.sym --keep_isymbols --keep_osymbols #{aname} #{bname}")
	system("python test-string2.py #{bname} #{text_merged} #{cname}")
	system("ruby stripmerged.rb #{cname} #{dname}")
	puts "For #{num} words, we get:"
	system("python eval.py -f #{text_tokenized} -p #{dname}")
end