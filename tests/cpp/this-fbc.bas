' TEST_MODE : MULTI_MODULE_TEST

'' test that the instance argument of the caller
'' has same address as the instance parameter
'' in the callee


extern "c++"
	'' getters to retrieve call information
	'' from the c++ side
	declare sub resetChecks()
	declare function getPtr1() as any ptr
	declare function getPtr2() as any ptr
	declare function getPtr3() as any ptr
end extern

'' default calling convention
'' on the cpp side, we are not explicitly specifying calling
'' calling convention, and it varies by target/platform

extern "c++"

type UDT_DEFAULT

	value as long

	declare constructor ()
	declare destructor ()

	declare sub loadpointer1 ()
	declare sub loadpointer2 ( byval arg1 as any ptr )
	declare sub loadpointer3 ( byval arg1 as any ptr, byval arg2 as any ptr )

end type

'' thiscall calling convention
'' on the cpp side, we are explicitly specifying __atribute__((thiscall))
'' for all member procs.  We do the same here with __thiscall
type UDT_THISCALL

	value as long

	declare constructor __thiscall ()
	declare destructor __thiscall ()

	declare sub loadpointer1 __thiscall ()
	declare sub loadpointer2 __thiscall ( byval arg1 as any ptr )
	declare sub loadpointer3 __thiscall ( byval arg1 as any ptr, byval arg2 as any ptr )

end type

'' cdecl calling convention
'' on the cpp side, we are explicitly specifying __atribute__((cdecl))
'' for all member procs.  We do the same here with cdecl
type UDT_CDECL

	value as long

	declare constructor cdecl ()
	declare destructor cdecl ()

	declare sub loadpointer1 cdecl ()
	declare sub loadpointer2 cdecl ( byval arg1 as any ptr )
	declare sub loadpointer3 cdecl ( byval arg1 as any ptr, byval arg2 as any ptr )

end type

'' stdcall calling convention
'' on the cpp side, we are explicitly specifying __atribute__((stdcall))
'' for all member procs.  We do the same here with stdcall
type UDT_STDCALL

	value as long

	declare constructor stdcall ()

	'' mingw/gcc appears to have a bug and generates the
	'' wrong suffix '@8' for the destructor.  On win 32-bit
	'' just use cdecl instead
	declare destructor cdecl ()

	declare sub loadpointer1 stdcall ()
	declare sub loadpointer2 stdcall ( byval arg1 as any ptr )
	declare sub loadpointer3 stdcall ( byval arg1 as any ptr, byval arg2 as any ptr )

end type

end extern

#macro checkResults( r1, r2, r3 )
	assert( r1 = getPtr1() )
	assert( r2 = getPtr2() )
	assert( r3 = getPtr3() )
#endmacro

dim p1 as any ptr = any
dim p2 as any ptr = cast( any ptr, 1111 )
dim p3 as any ptr = cast( any ptr, 2222 )

'' default calling convention
scope
	resetChecks()
	dim x as UDT_DEFAULT
	checkResults( @x, 0, 0 )

	resetChecks()
	x.loadpointer1()
	checkResults( @x, 0, 0 )

	resetChecks()
	x.loadpointer2( p2 )
	checkResults( @x, p2, 0 )

	resetChecks()
	x.loadpointer3( p2, p3 )
	checkResults( @x, p2, p3 )

	resetChecks()
	p1 = @x
end scope

'' check results of destructor called
checkResults( p1, 0, 0 )

'' explicit use of thiscall on the cpp side
scope
	resetChecks()
	dim x as UDT_THISCALL
	checkResults( @x, 0, 0 )

	resetChecks()
	x.loadpointer1()
	checkResults( @x, 0, 0 )

	resetChecks()
	x.loadpointer2( p2 )
	checkResults( @x, p2, 0 )

	resetChecks()
	x.loadpointer3( p2, p3 )
	checkResults( @x, p2, p3 )

	resetChecks()
	p1 = @x
end scope

'' check results of destructor called
checkResults( p1, 0, 0 )

'' explicit use of thiscall on the cpp side
scope
	resetChecks()
	dim x as UDT_CDECL
	checkResults( @x, 0, 0 )

	resetChecks()
	x.loadpointer1()
	checkResults( @x, 0, 0 )

	resetChecks()
	x.loadpointer2( p2 )
	checkResults( @x, p2, 0 )

	resetChecks()
	x.loadpointer3( p2, p3 )
	checkResults( @x, p2, p3 )

	resetChecks()
	p1 = @x
end scope

'' check results of destructor called
checkResults( p1, 0, 0 )

'' explicit use of thiscall on the cpp side
scope
	resetChecks()
	dim x as UDT_STDCALL
	checkResults( @x, 0, 0 )

	resetChecks()
	x.loadpointer1()
	checkResults( @x, 0, 0 )

	resetChecks()
	x.loadpointer2( p2 )
	checkResults( @x, p2, 0 )

	resetChecks()
	x.loadpointer3( p2, p3 )
	checkResults( @x, p2, p3 )

	resetChecks()
	p1 = @x
end scope

'' check results of destructor called
checkResults( p1, 0, 0 )
