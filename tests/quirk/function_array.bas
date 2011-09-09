' TEST_MODE : COMPILE_ONLY_FAIL

sub foo(a() as integer)
end sub
function bar() as integer
end function
enum baz
	hi
end enum
type bark
	__ as integer
end type
type balk as bark
const as string msg = "hello"

dim as baz bak
dim as bark lark
dim as balk talk
foo( bar )
foo( bak )
foo( lark )
foo( talk )
foo( msg )
