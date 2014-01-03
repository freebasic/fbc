type Pod1
	i as integer
end type

type Pod2
	i as integer
end type

dim as Pod1 ptr ppod1a, ppod1b
dim as Pod2 ptr ppod2

#print "no warning:"
ppod1a = ppod1b

#print "1 warning:"
ppod1a = ppod2
