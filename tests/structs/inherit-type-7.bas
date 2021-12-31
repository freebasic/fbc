' TEST_MODE : COMPILE_ONLY_FAIL

sub duplicate()
	print "   ..duplicate"
end sub

namespace m
	sub duplicate()
		print "   m.duplicate"
	end sub
end namespace

type udt extends object
	declare sub test()
end type

sub udt.test()
	using m
	this.duplicate()  '' expected: element not defined
end sub

print "from type:"
dim as udt u
u.test()          
print
