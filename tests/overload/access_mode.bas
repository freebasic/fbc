# include "fbcu.bi"

namespace fbc_tests.overloads.acc_mode

type foo
	as byte pad
	
	private:
	declare function bar() as integer
	declare constructor ()
	
	public:
	declare function bar(i as integer) as integer
	declare constructor (i as integer)
end type

function foo.bar(i as integer) as integer
	function = 0
end function

constructor foo(i as integer)
end constructor

sub test_1 cdecl
	dim f as foo = foo(1)
	
	f.bar(1)
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.overload.access_mode")
	fbcu.add_test("1", @test_1)

end sub

end namespace
