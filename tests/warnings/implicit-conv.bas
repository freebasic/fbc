#print "1 warning:"
print -&hFFFFFFFFu

scope
	#print "no warnings:"
	dim as uinteger a, b
	print a - (b - 1)
	print a - (-1 - b)
end scope
