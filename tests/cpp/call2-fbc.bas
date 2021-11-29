' TEST_MODE : MULTI_MODULE_TEST

'' test mapping of mangling and calling convention 
'' between fbc and c/c++ class procedures

'' helper macro to track progress
#define DLOG( msg ) '' print #msg

#if ENABLE_CHECK_BUGS
	#define DOTEST
	#define DOFUNCS
#else
	'' strutures returned by value from c++
	'' needs some work on arm targets (bugs!)
	#if not defined( __FB_ARM__ )
		#define DOFUNCS
	#endif
#endif

'' !!! TODO !!! this default should be handled in fbc
#if defined(__FB_WIN32__) and not defined(__FB_64BIT__)
	#define thiscall __thiscall
#else
	#define thiscall
#endif

#ifndef NULL
#define NULL 0
#endif

extern "c++"
	'' getters to retrieve call information
	'' from the c++ side
	declare sub resetChecks()
	declare function getPtr1() as any ptr
	declare function getPtr2() as any ptr
	declare function getPtr3() as any ptr
	declare function getMsg1() as zstring ptr

type UDT
	value as long
	declare constructor thiscall ()
	declare constructor thiscall ( byval rhs as long )
	declare constructor thiscall ( byref rhs as const UDT )
	declare destructor thiscall ()
end type

end extern

extern "c"
	declare sub sub1_c_default( byref a as const UDT )
	declare sub sub1_c_cdecl cdecl( byref a as const UDT )
	declare sub sub1_c_stdcall stdcall( byref a as const UDT )
	declare function func1_c_default( byref a as const UDT ) as UDT
	declare function func1_c_cdecl cdecl( byref a as const UDT ) as UDT
	declare function func1_c_stdcall stdcall( byref a as const UDT ) as UDT

	declare sub sub2_c_default( byref a as const UDT, byref b as const UDT )
	declare sub sub2_c_cdecl cdecl( byref a as const UDT, byref b as const UDT )
	declare sub sub2_c_stdcall stdcall( byref a as const UDT, byref b as const UDT )
	declare function func2_c_default( byref a as const UDT, byref b as const UDT ) as UDT
	declare function func2_c_cdecl cdecl( byref a as const UDT, byref b as const UDT ) as UDT
	declare function func2_c_stdcall stdcall( byref a as const UDT, byref b as const UDT ) as UDT

	declare sub sub3_c_default( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare sub sub3_c_cdecl cdecl( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare sub sub3_c_stdcall stdcall( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare function func3_c_default( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
	declare function func3_c_cdecl cdecl( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
	declare function func3_c_stdcall stdcall( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
end extern

extern "c++"
	declare sub sub1_cpp_default( byref a as const UDT )
	declare sub sub1_cpp_cdecl cdecl( byref a as const UDT )
	declare sub sub1_cpp_stdcall stdcall( byref a as const UDT )
	declare function func1_cpp_default( byref a as const UDT ) as UDT
	declare function func1_cpp_cdecl cdecl( byref a as const UDT ) as UDT
	declare function func1_cpp_stdcall stdcall( byref a as const UDT ) as UDT

	declare sub sub2_cpp_default( byref a as const UDT, byref b as const UDT )
	declare sub sub2_cpp_cdecl cdecl( byref a as const UDT, byref b as const UDT )
	declare sub sub2_cpp_stdcall stdcall( byref a as const UDT, byref b as const UDT )
	declare function func2_cpp_default( byref a as const UDT, byref b as const UDT ) as UDT
	declare function func2_cpp_cdecl cdecl( byref a as const UDT, byref b as const UDT ) as UDT
	declare function func2_cpp_stdcall stdcall( byref a as const UDT, byref b as const UDT ) as UDT

	declare sub sub3_cpp_default( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare sub sub3_cpp_cdecl cdecl( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare sub sub3_cpp_stdcall stdcall( byref a as const UDT, byref b as const UDT, byref c as const UDT )
	declare function func3_cpp_default( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
	declare function func3_cpp_cdecl cdecl( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
	declare function func3_cpp_stdcall stdcall( byref a as const UDT, byref b as const UDT, byref c as const UDT ) as UDT
end extern

#macro chksub( count, n )
	DLOG( n )
	resetChecks()
	scope
	#if count = 1
		dim a as UDT
		n( a )
		assert( @a = getPtr1() )
	#elseif count = 2
		dim a as UDT, b as UDT
		n( a, b )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
	#else
		dim a as UDT, b as UDT, c as UDT
		n( a, b, c )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
		assert( @c = getPtr3() )
	#endif
		assert( #n = *getMsg1() )
	end scope
#endmacro

#macro chkfunc( count, n )
	DLOG( n )
	resetChecks()
	scope
	#if count = 1
		dim a as UDT, r as UDT
		r = n( a )
		assert( @a = getPtr1() )
	#elseif count = 2
		dim a as UDT, b as UDT, r as UDT
		r = n( a, b )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
	#else
		dim a as UDT, b as UDT, c as UDT, r as UDT
		r = n( a, b, c )
		assert( @a = getPtr1() )
		assert( @b = getPtr2() )
		assert( @c = getPtr3() )
	#endif
		assert( #n = *getMsg1() )
	end scope
#endmacro

#ifdef DOTEST


chksub( 1, sub1_c_default )
chksub( 1, sub1_c_cdecl )
chksub( 1, sub1_c_stdcall )
#ifdef DOFUNCS
chkfunc( 1, func1_c_default )
chkfunc( 1, func1_c_cdecl )
chkfunc( 1, func1_c_stdcall )
#endif

chksub( 1, sub1_cpp_default )
chksub( 1, sub1_cpp_cdecl )
chksub( 1, sub1_cpp_stdcall )
#ifdef DOFUNCS
chkfunc( 1, func1_cpp_default )
chkfunc( 1, func1_cpp_cdecl )
chkfunc( 1, func1_cpp_stdcall )
#endif

chksub( 2, sub2_c_default )
chksub( 2, sub2_c_cdecl )
chksub( 2, sub2_c_stdcall )
#ifdef DOFUNCS
chkfunc( 2, func2_c_default )
chkfunc( 2, func2_c_cdecl )
chkfunc( 2, func2_c_stdcall )
#endif

chksub( 2, sub2_cpp_default )
chksub( 2, sub2_cpp_cdecl )
chksub( 2, sub2_cpp_stdcall )
#ifdef DOFUNCS
chkfunc( 2, func2_cpp_default )
chkfunc( 2, func2_cpp_cdecl )
chkfunc( 2, func2_cpp_stdcall )
#endif

chksub( 3, sub3_c_default )
chksub( 3, sub3_c_cdecl )
chksub( 3, sub3_c_stdcall )
#ifdef DOFUNCS
chkfunc( 3, func3_c_default )
chkfunc( 3, func3_c_cdecl )
chkfunc( 3, func3_c_stdcall )
#endif

chksub( 3, sub3_cpp_default )
chksub( 3, sub3_cpp_cdecl )
chksub( 3, sub3_cpp_stdcall )
#ifdef DOFUNCS
chkfunc( 3, func3_cpp_default )
chkfunc( 3, func3_cpp_cdecl )
chkfunc( 3, func3_cpp_stdcall )
#endif

#endif
