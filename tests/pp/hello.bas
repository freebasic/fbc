# include "fbcu.bi"

namespace fbc_tests.macros.hello

#define merge(seq) letter seq
#define letter(seq) #seq + letter
#define letter__ ""

sub helloTest cdecl ()

	if( merge( (H)(e)(l)(l)(o)(.)(W)(o)(r)(l)(d)(!)__ ) <> "Hello.World!" ) then
		CU_ASSERT( 0 )
	end if

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pp.hello")
	fbcu.add_test("helloTest", @helloTest)

end sub

end namespace
