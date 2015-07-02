scope
	type MSG
		i as integer
	end type

	dim msg as string

	#print "1 warning:"
	print len(msg)

	#print "1 warning:"
	print sizeof(msg)

	#print "1 warning:"
	dim x as typeof(msg)
end scope

#print "---"

scope
	type array
		i as integer
	end type

	dim array(0 to 1) as string

	#print "no warning:"
	print sizeof(array(1))
end scope
