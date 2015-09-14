' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

function f(byval i as integer) as UDT
	function = type(i)
end function

namespace n
end namespace

dim as integer a = 0

with( f(n.a) )
	print .i
end with
