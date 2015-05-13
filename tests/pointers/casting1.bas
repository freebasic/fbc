# include "fbcu.bi"



namespace fbc_tests.pointers.casting1

const TEST_VAL = &hDeadC0de

type fluff as udttype

type funcudt
	field	as integer
end type

type functype as function( ) as funcudt ptr

type udttype
	fparray  as functype ptr
end type

type DerivedClass extends object
	as integer abc
end type

function realfunc( ) as funcudt ptr
	static as funcudt t = ( TEST_VAL )

	function = @t

end function

sub test cdecl ()

	dim as udttype t
	
	dim as any ptr p
	dim as any ptr ptr pptr
	
	p = @t
	pptr = @p
	
	t.fparray = cast( any ptr ptr, callocate( 11 * len( functype ) ) )
	
	t.fparray[10] = @realfunc
	
	CU_ASSERT( cast(udttype ptr, *cast(any ptr ptr, pptr))->fparray[10]()->field = TEST_VAL )
	

	'' Bug #3269771 regression test (casting derived class pointers to integers)
	dim as DerivedClass ptr pclass
	dim as ulong l = culng(pclass)
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.casting1")
	fbcu.add_test("test", @test)

end sub

end namespace
