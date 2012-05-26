# include "fbcu.bi"



namespace fbc_tests.pointers.funcptr_mangling

''
'' no warnings should be shown (bug report #1523070)
''

type baz_ as baz

type bar
    fn as sub (byval as baz_ ptr)
end type

type baz
	zzz as integer
end type

type foo
    fn as sub (byval as foo ptr)
end type


sub bar_cb( byval p as baz ptr )
end sub

sub foo_cb( byval p as foo ptr )
end sub

sub test cdecl ()

	dim as foo f
	dim as bar b
	
	f.fn = @foo_cb
	b.fn = @bar_cb

end sub

'' -gen gcc regression test
sub sub1( )
	dim p1 as sub( )
end sub
sub sub2( )
	dim p2 as sub( )
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.funcptr_mangling")
	fbcu.add_test("test", @test)

end sub

end namespace
