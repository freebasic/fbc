' TEST_MODE : COMPILE_ONLY_FAIL

dim shared as zstring * 32 duplicate = "   ..duplicate"

namespace m
	dim as zstring *32 duplicate = "   m.duplicate"
end namespace

type udt extends object
	declare sub test()
end type

sub udt.test()
	using m
	print this.duplicate           '' expected: element not defined
end sub

print "from type:"
dim as udt u
u.test()
print
