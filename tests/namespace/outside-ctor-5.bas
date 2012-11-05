' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns
	type UDT
		dummy as integer
		declare constructor( )
	end type
end namespace

constructor UDT( )
end constructor
