' TEST_MODE : MULTI_MODULE_TEST

'' test mapping of mangling and calling convention
'' between fbc extern "rtlib" and c

'' helper macro to track progress
#define DLOG( msg ) '' print #msg

extern "c++"
	'' getters to retrieve call information
	'' from the c/c++ side
	declare sub resetChecks()
	declare function getPtr1() as any ptr
	declare function getPtr2() as any ptr
	declare function getPtr3() as any ptr
	declare function getMsg1() as zstring ptr
end extern

type UDT
	value as long
end type

#macro DECL_PROCS()

extern "rtlib"
	declare sub sub1_rtlib_default( byref a as const UDT )
	declare sub sub1_rtlib_cdecl cdecl( byref a as const UDT )
	declare sub sub1_rtlib_stdcall stdcall( byref a as const UDT )
	declare function func1_rtlib_default( byref a as const UDT ) as UDT
	declare function func1_rtlib_cdecl cdecl( byref a as const UDT ) as UDT
	declare function func1_rtlib_stdcall stdcall( byref a as const UDT ) as UDT

	declare sub sub2_rtlib_default( byref a as const UDT, byref b as const UDT )
	declare sub sub2_rtlib_cdecl cdecl( byref a as const UDT, byref b as const UDT )
	declare sub sub2_rtlib_stdcall stdcall( byref a as const UDT, byref b as const UDT )
	declare function func2_rtlib_default( byref a as const UDT, byref b as const UDT ) as UDT
	declare function func2_rtlib_cdecl cdecl( byref a as const UDT, byref b as const UDT ) as UDT
	declare function func2_rtlib_stdcall stdcall( byref a as const UDT, byref b as const UDT ) as UDT

	declare sub sub3_rtlib_default( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare sub sub3_rtlib_cdecl cdecl( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare sub sub3_rtlib_stdcall stdcall( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare function func3_rtlib_default( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
	declare function func3_rtlib_cdecl cdecl( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
	declare function func3_rtlib_stdcall stdcall( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
end extern

#endmacro

'' fbc declarations in global namespace
DECL_PROCS()

'' fbc declarations in a namespace
namespace NS
	DECL_PROCS()
end namespace

#macro chksub( count, n, ns )
	DLOG( n )
	resetChecks()
	scope
	#if count = 1
		dim a as UDT
		ns##n( a )
		assert( @a = getPtr1() )
	#elseif count = 2
		dim a as UDT, b as UDT
		ns##n( a, b )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
	#else
		dim a as UDT, b as UDT, c as UDT
		ns##n( a, b, c )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
		assert( @c = getPtr3() )
	#endif
		assert( #n = *getMsg1() )
	end scope
#endmacro

#macro chkfunc( count, n, ns )
	DLOG( n )
	resetChecks()
	scope
	#if count = 1
		dim a as UDT, r as UDT
		r = ns##n( a )
		assert( @a = getPtr1() )
	#elseif count = 2
		dim a as UDT, b as UDT, r as UDT
		r = ns##n( a, b )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
	#else
		dim a as UDT, b as UDT, c as UDT, r as UDT
		r = ns##n( a, b, c )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
		assert( @c = getPtr3() )
	#endif
		assert( #n = *getMsg1() )
	end scope
#endmacro

'' top level declaration inside extern "rtlib"
'' to link to c functions

chksub( 1, sub1_rtlib_default, )
chksub( 1, sub1_rtlib_cdecl, )
chksub( 1, sub1_rtlib_stdcall, )
chkfunc( 1, func1_rtlib_default, )
chkfunc( 1, func1_rtlib_cdecl, )
chkfunc( 1, func1_rtlib_stdcall, )

chksub( 2, sub2_rtlib_default, )
chksub( 2, sub2_rtlib_cdecl, )
chksub( 2, sub2_rtlib_stdcall, )
chkfunc( 2, func2_rtlib_default, )
chkfunc( 2, func2_rtlib_cdecl, )
chkfunc( 2, func2_rtlib_stdcall, )

chksub( 3, sub3_rtlib_default, )
chksub( 3, sub3_rtlib_cdecl, )
chksub( 3, sub3_rtlib_stdcall, )
chkfunc( 3, func3_rtlib_default, )
chkfunc( 3, func3_rtlib_cdecl, )
chkfunc( 3, func3_rtlib_stdcall, )

'' fbc declarations in a namespace
'' however, c functions are not

chksub( 1, sub1_rtlib_default, ns. )
chksub( 1, sub1_rtlib_cdecl, ns. )
chksub( 1, sub1_rtlib_stdcall, ns. )
chkfunc( 1, func1_rtlib_default, ns. )
chkfunc( 1, func1_rtlib_cdecl, ns. )
chkfunc( 1, func1_rtlib_stdcall, ns. )

chksub( 2, sub2_rtlib_default, ns. )
chksub( 2, sub2_rtlib_cdecl, ns. )
chksub( 2, sub2_rtlib_stdcall, ns. )
chkfunc( 2, func2_rtlib_default, ns. )
chkfunc( 2, func2_rtlib_cdecl, ns. )
chkfunc( 2, func2_rtlib_stdcall, ns. )

chksub( 3, sub3_rtlib_default, ns. )
chksub( 3, sub3_rtlib_cdecl, ns. )
chksub( 3, sub3_rtlib_stdcall, ns. )
chkfunc( 3, func3_rtlib_default, ns. )
chkfunc( 3, func3_rtlib_cdecl, ns. )
chkfunc( 3, func3_rtlib_stdcall, ns. )
