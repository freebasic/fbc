#print "1 warning:"
#ifdef __FB_64BIT__
	print -&hFFFFFFFFFFFFFFFFu
#else
	print -&hFFFFFFFFu
#endif

scope
	#print "no warnings:"
	dim as uinteger a, b
	print a - (b - 1)
	print a - (-1 - b)
end scope
