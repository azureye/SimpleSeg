#!/usr/bin/python

### Implementation of segmentation evaluation
###
### Elif Yamangil

import os, sys
import string
import getopt

from common import remove_whitespace

DEBUG = False

# seg: gold segmentation
# pre: predicted segmentation
def evaluate(pre, seg):
	tp,fp,tn,fn = 0,0,0,0
	
	i = j = 0
	while i < len(seg) and j < len(pre):
	
		if DEBUG: print seg[i], pre[j]
	
		if seg[i] == "1":
			if pre[j] == "1":
				tp += 1
				i += 1
				j += 1

			elif pre[j] == "0":
				fn += 1
				i += 1
				
		elif seg[i] == "0":
			if pre[j] == "0":
				tn += 1
				i += 1
				j += 1
				
			elif pre[j] == "1":
				fp += 1
				j += 1
				
	#assert(fp + tp == pre.count("1"))
	#assert(fn + tn == pre.count("0"))
	
	if DEBUG:
		print
		print tp,fp,tn,fn
	
	#sys.exit()
	return tp,fp,tn,fn

def main():
	''' evaluate a predictions file against the gold segmentations from the data '''

	## Read command line arguments
	try:
		opts, args = getopt.getopt(sys.argv[1:], 
					   "hd:f:p:", 
					   ["help", "debug", "file=", "predictions="])
	except getopt.error, msg:
		print msg
		print "for help use --help"
		sys.exit(2)
		
	## Internal constants
	FILENAME = "data.txt"		# file of test data
	PREDFILE = "predict.txt"	# file of counts data
	
	global DEBUG

	## Handle command line arguments
	for opt, arg in opts:
		if opt in ("-h", "--help"):
			print "to specify a test data file to read, use \"-f <filename>\""
			print "to specity the predictions file, use \"-p <threshold>\""
			sys.exit(0)
		elif opt == "-f":
			FILENAME = arg
		elif opt == "-d":
			DEBUG = True
		elif opt == "-p":
			PREDFILE = arg

	fin = file(FILENAME, "r")
	fin_pred = file(PREDFILE, "r")
	
	count = 0
	sum_tp = sum_fp = sum_tn = sum_fn = 0.0
	for line in fin_pred:
	
		x, seg = remove_whitespace(fin.readline().strip().lower())
		x, pre = remove_whitespace(line.strip().lower())
		count += 1
		
		if DEBUG:
			print seg
			print pre
		
		tp,fp,tn,fn = evaluate(pre, seg)
		sum_tp += tp
		sum_fp += fp
		sum_tn += tn
		sum_fn += fn
		
	print
	print "precision %.5f" %(float(sum_tp) / (sum_tp + sum_fp))
	print "recall %.5f" %(float(sum_tp) / (sum_tp + sum_fn))

	print
	print "%d prediction sentences used for evaluation" %count
	
	fin.close()
	fin_pred.close()
	return



if __name__ == "__main__": main()


