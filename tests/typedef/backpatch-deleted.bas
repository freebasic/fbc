' TEST_MODE : COMPILE_ONLY_OK

type FORWARD as T

type U
    __ as integer
    declare sub foo(byval as FORWARD ptr)
end type

sub U.foo(byval fooparam as FORWARD ptr)
end sub

declare sub declonly(byval as integer)

type T
    x as integer
end type

dim as T a

'' Symbols using fwdrefs were not removed from backpatching lists when being
'' deleted, so by the time the backpatching happened it was writing to a
'' deleted node, or even worse, corrupting the data type of a symbol that
'' reused the same address.
'' In this test case, the bug caused the 'x' field's data type to be
'' overwritten, from integer to struct T, and this assignment caused an error.
dim as integer b = a.x
