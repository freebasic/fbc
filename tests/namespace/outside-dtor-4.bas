' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns
	type UDT
		dummy as integer
		declare destructor( )
	end type
end namespace

destructor ns( )
end destructor
