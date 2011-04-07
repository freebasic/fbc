# include "fbcu.bi"

namespace fbc_tests.structs.op_acc_mode

type foo
	as byte pad
	
private:
	declare operator cast ( ) as integer
	declare operator += ( i as integer )
	
public:
	declare operator += ( i as double )
	declare operator cast ( ) as double
	
end type

operator foo.+= ( i as double )
end operator

operator foo.cast ( ) as double
	return 0
end operator

sub test_1 cdecl	
	dim f as foo
	
	dim as double d = cdbl(f)
	
	f += 1.0
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:op_acc_mode")
	fbcu.add_test( "1", @test_1)

end sub
	
end namespace