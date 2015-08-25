#print "--- UDT + var ---"
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

#print "--- UDT + var of that type ---"
#print "no warnings:"
scope
	type UDT
		i as integer
	end type

	dim udt as udt

	print len(udt)
	print sizeof(udt)
end scope

#print "--- UDT + const ---"
scope
	type MSG
		i as integer
	end type

	const msg = "msg"

	#print "1 warning:"
	print len(msg)

	#print "1 warning:"
	print sizeof(msg)

	#print "1 warning:"
	dim x as typeof(msg)
end scope

#print "--- typedef + var ---"
scope
	type MSG2 as integer
	dim msg2 as string

	#print "1 warning:"
	print len(msg2)
end scope

#print "--- fwdref + var ---"
scope
	type typedef as fwd

	dim fwd as string

	#print "1 warning:"
	print len(fwd)
end scope

#print "--- syntax is enough to disambiguate ---"
scope
	type array
		i as integer
	end type

	dim array(0 to 1) as string

	#print "no warning:"
	print sizeof(array(1))

	type a
		i as integer
	end type

	dim as string a, b

	#print "no warning:"
	print sizeof(a + b)
end scope

#print "--- UDT + proc ---"
type f1
	i as integer
end type
declare sub f1
#print "no warning:"
print sizeof(f1)
