# include "fbcu.bi"

namespace fbc_tests.overload_.new_del

	dim shared as integer call_cnt = 0, vec_call_cnt = 0

type bar
	declare operator new( size as uinteger ) as any ptr
	declare operator delete( buf as any ptr )
	declare static operator new[]( size as uinteger ) as any ptr
	declare static operator delete[]( buf as any ptr )
	pad as byte
end type

operator bar.new( size as uinteger ) as any ptr
	operator = new byte[size] { any }
	call_cnt += 1
end operator

operator bar.delete( buf as any ptr )
	delete[] cast( byte ptr, buf )
	call_cnt += 1
end operator

static operator bar.new[]( size as uinteger ) as any ptr
	operator = new byte[size] { any }
	vec_call_cnt += 1
end operator

static operator bar.delete[]( buf as any ptr )
	delete[] cast( byte ptr, buf )
	vec_call_cnt += 1
end operator

sub test_1 cdecl
	call_cnt = 0
	
	dim as bar ptr pbar = new bar( any )
	delete pbar
	
	CU_ASSERT_EQUAL( call_cnt, 2 )
end sub

sub test_2 cdecl
	vec_call_cnt = 0
	
	dim as bar ptr pbar = new bar[1] { any }
	delete[] pbar
	
	CU_ASSERT_EQUAL( vec_call_cnt, 2 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:op-new-delete")
	fbcu.add_test("#1", @test_1)
	fbcu.add_test("#2", @test_2)

end sub

end namespace
