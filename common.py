#!/usr/bin/python

### Common code for n-gram counting and Tango segmentation
###
### Elif Yamangil

import string

MAX_ORDER = 10 # will compute ngrams of orders {2, 3, ..., max_order}
WW = string.whitespace

def remove_whitespace(line):
	padding = "#"*(MAX_ORDER-1) # padding

	seg = ""
	ret = padding
	
	for c in line:
		if c not in WW:
			ret += c
			seg += "0"
		else:
			seg += "1"
	
	#print line
	#print seg
	#print
			
	return ret + padding, seg

