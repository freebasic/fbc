# include "fbcu.bi"

namespace fbc_tests.typedef.backpatch

sub patchFwdrefWithFwdref1 cdecl ()

    type a as b
    type b as c

    '' In "a", fwdref "b" is replaced by _another_ fwdref ("c") from
    '' typedef "b", so "a" must be patched _again_ when "c" is known.

    type c
        as integer foo
    end type

    dim as a foo = (5)
    CU_ASSERT_EQUAL( foo.foo, 5 )

end sub

sub patchFwdrefWithFwdref2 cdecl ()

    type a as b
    type b as c
    type c as d ptr
    type d as integer

    dim as integer i = 5
    dim as a foo = @i

    CU_ASSERT_EQUAL( *foo, 5 )

end sub

sub preservePtrs cdecl ()

    type x as y       ptr ptr ptr ptr
    type y as integer ptr ptr ptr ptr

    dim as integer                             i = 5
    dim as integer ptr                         p1 = @i
    dim as integer ptr ptr                     p2 = @p1
    dim as integer ptr ptr ptr                 p3 = @p2
    dim as integer ptr ptr ptr ptr             p4 = @p3
    dim as integer ptr ptr ptr ptr ptr         p5 = @p4
    dim as integer ptr ptr ptr ptr ptr ptr     p6 = @p5
    dim as integer ptr ptr ptr ptr ptr ptr ptr p7 = @p6
    dim as x                                   p8 = @p7

    CU_ASSERT_EQUAL( ********p8, 5 )

end sub

private sub _sub()
end sub

private function _function(x as integer) as integer
    return x
end function

sub funcPtr cdecl ()

    type PPSub as PSub ptr
    type PSub as sub()

    type PPFunc as PFunc ptr
    type as function(as integer) as integer PFunc

    dim as PSub p1 = @_sub
    dim as PPSub pp1 = @p1

    p1()
    (*pp1)()

    dim as PFunc p2 = @_function
    dim as PPFunc pp2 = @p2

    CU_ASSERT_EQUAL( p2((*pp2)(5)), 5 )

end sub

namespace byrefFwdrefParamLength
	type UDT as FWDREF

	declare function f1 cdecl( byref x as UDT, ... ) as integer

	type FWDREF
		'' Big enough that it is bigger than the BYREF (sizeof(any ptr))
		array(0 to 64-1) as integer
	end type

	function f1 cdecl( byref x as UDT, ... ) as integer
		dim result as integer
		dim arg as any ptr

		arg = va_first( )
		result += va_arg( arg, integer )

		arg = va_next( arg, integer )
		result += va_arg( arg, integer )

		arg = va_next( arg, integer )
		result += va_arg( arg, integer )

		function = result
	end function

	sub test cdecl( )
		dim x as UDT
		CU_ASSERT( f1( x, 123, 456, 789 ) = 123 + 456 + 789 )
	end sub
end namespace

private sub ctor () constructor
	fbcu.add_suite("fbc_tests.typedef.backpatch")
	fbcu.add_test("patchFwdrefWithFwdref1", @patchFwdrefWithFwdref1)
	fbcu.add_test("patchFwdrefWithFwdref2", @patchFwdrefWithFwdref2)
	fbcu.add_test("preservePtrs", @preservePtrs)
	fbcu.add_test("funcPtr", @funcPtr)
	fbcu.add_test( "BYREF AS FWDREF param length", @byrefFwdrefParamLength.test )
end sub

end namespace
