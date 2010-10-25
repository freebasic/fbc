# include "fbcu.bi"

namespace fbc_tests.typedef.pointers

sub forwardPtr cdecl ()

    '' Pointers to a forwardref
    type t1 as UDT ptr
    type t2 as UDT ptr ptr

    type UDT
        as integer x, y, z
    end type

    dim as UDT x = (1, 2, 3)

    dim as t1 p1 = @x
    dim as t2 p2 = @p1

    CU_ASSERT_EQUAL( p1->z, 3 )
    CU_ASSERT_EQUAL( (*p2)->z, 3 )

end sub

sub unresolvedTypedefPtr cdecl ()

    type u as UDT

    '' Pointers to a typedef'ed forwardref
    type t1 as u ptr
    type t2 as u ptr ptr

    type UDT
        as integer x, y, z
    end type

    dim as UDT x = (4, 5, 6)

    dim as t1 p1 = @x
    dim as t2 p2 = @p1

    CU_ASSERT_EQUAL( p1->z, 6 )
    CU_ASSERT_EQUAL( (*p2)->z, 6 )

end sub

sub ptrAliases cdecl ()

    type UDT
        as integer x, y, z
    end type

    dim as UDT x = (1, 2, 3)

    '' Simple aliases containing pointers
    type t1 as UDT ptr
    type t2 as UDT ptr ptr

    dim as t1 p1 = @x
    dim as t2 p2 = @p1

    CU_ASSERT_EQUAL( p1->y, 2 )
    CU_ASSERT_EQUAL( (*p2)->y, 2 )

end sub

sub aliasPtrs cdecl ()

    type UDT
        as integer x, y, z
    end type

    dim as UDT x = (4, 5, 6)

    type u as UDT

    '' Pointers to an alias
    type t1 as u ptr
    type t2 as u ptr ptr

    dim as t1 p1 = @x
    dim as t2 p2 = @p1

    CU_ASSERT_EQUAL( p1->y, 5 )
    CU_ASSERT_EQUAL( (*p2)->y, 5 )

end sub

private sub _sub()
end sub

private function _function(x as integer) as integer
    return x
end function

sub funcPtr cdecl ()

    type PSub as sub()
    type PPSub as PSub ptr

    type as function(as integer) as integer PFunc
    type PPFunc as PFunc ptr

    dim as PSub p1 = @_sub
    dim as PPSub pp1 = @p1

    p1()
    (*pp1)()

    dim as PFunc p2 = @_function
    dim as PPFunc pp2 = @p2

    CU_ASSERT_EQUAL( p2((*pp2)(5)), 5 )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.typedef.pointers")
	fbcu.add_test("forwardPtr", @forwardPtr)
	fbcu.add_test("unresolvedTypedefPtr", @unresolvedTypedefPtr)
	fbcu.add_test("ptrAliases", @ptrAliases)
	fbcu.add_test("aliasPtrs", @aliasPtrs)
	fbcu.add_test("funcPtr", @funcPtr)

end sub

end namespace
