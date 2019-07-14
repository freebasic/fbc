# include "fbcunit.bi"

#if (__FB_BACKEND__ = "gas")
	#define DOTEST
#endif

'' for other targets, see var_args-gcc.bas

#ifdef DOTEST

SUITE( fbc_tests.functions.var_args )

	const TEST_B as byte = -128
	const TEST_UB as ubyte = 255
	const TEST_S as short = -32768
	const TEST_US as ushort = 65535
	const TEST_I as integer = -2147483648
	const TEST_UI as uinteger = 4294967295U
	const TEST_L as longint = 9223372036854775808
	const TEST_UL as ulongint = 18446744073709551615ULL
	const TEST_F as single = 1.234567
	const TEST_D as double = 1.23456789012345
	const TEST_Z as string = "FoO BaR!"

	sub test_proc cdecl (fmtstr as string, ...)
		dim as any ptr arg
		dim as zstring ptr p
		dim as integer i, char

		arg = va_first()
		p = strptr( fmtstr )
		i = len( fmtstr )
		do while( i > 0 ) 
			char = *p
			p += 1
			i -= 1

			if( char = asc( "%" ) ) then
				char = *p
				p += 1
				i -= 1

				select case as const char
				case asc( "b" )
					CU_ASSERT( va_arg( arg, byte ) = TEST_B )
					arg = va_next( arg, integer )

				case asc( "c" )
					CU_ASSERT( va_arg( arg, ubyte ) = TEST_UB )
					arg = va_next( arg, uinteger )

				case asc( "s" )
					CU_ASSERT( va_arg( arg, short ) = TEST_S )
					arg = va_next( arg, integer )

				case asc( "r" )
					CU_ASSERT( va_arg( arg, ushort ) = TEST_US )
					arg = va_next( arg, uinteger )

				case asc( "i" )
					CU_ASSERT( va_arg( arg, integer ) = TEST_I )
					arg = va_next( arg, integer )

				case asc( "j" )
					CU_ASSERT( va_arg( arg, uinteger ) = TEST_UI )
					arg = va_next( arg, uinteger )

				case asc( "l" )
					CU_ASSERT( va_arg( arg, longint ) = TEST_L )
					arg = va_next( arg, longint )

				case asc( "m" )
					CU_ASSERT( va_arg( arg, ulongint ) = TEST_UL )
					arg = va_next( arg, ulongint )
				
				case asc( "f" )
					CU_ASSERT( va_arg( arg, double ) = TEST_F )
					arg = va_next( arg, double )

				case asc( "d" )
					CU_ASSERT( va_arg( arg, double ) = TEST_D )
					arg = va_next( arg, double )

				case asc( "z" )
					CU_ASSERT( *va_arg( arg, zstring ptr ) = TEST_Z )
					arg = va_next( arg, zstring ptr )
				end select
			end if
		loop
	end sub

	TEST( allTypes )
		dim as byte b = TEST_B
		dim as ubyte ub = TEST_UB
		dim as short s = TEST_S
		dim as ushort us = TEST_US
		dim as integer i = TEST_I
		dim as uinteger ui = TEST_UI
		dim as longint l = TEST_L
		dim as ulongint ul = TEST_UL
		dim as single f = TEST_F
		dim as double d = TEST_D
		dim as string vs = TEST_Z
		dim as zstring * 32 z = TEST_Z

		test_proc( "%b %c %s %r %i %j %l %m %f %d %z %z", _
			   b, ub, s, us, i, ui, l, ul, f, d, vs, z )
	END_TEST

	sub hVaFirstBehindByte cdecl( byval n as byte, ... )
		'' va_first() was returning @n + 1, but it should do @n + 4 in this case,
		'' because 4 bytes are pushed for 'n'.
		dim as integer ptr p = va_first()
		CU_ASSERT( *p = &hAABBCCDD )
	end sub

	sub hVaFirstBehindShort cdecl( byval n as short, ... )
		'' sizeof(n) = 2, but 4 bytes pushed...
		dim as integer ptr p = va_first()
		CU_ASSERT( *p = &h44332211 )
	end sub

	type T field = 1
		as integer a
		as byte b
	end type

	sub hVaFirstBehindUdt cdecl( byval n as T, ... )
		'' sizeof(n) = 5, but 8 bytes pushed...
		dim as integer ptr p = va_first()
		CU_ASSERT( *p = &hFF006622 )
	end sub

	type NonTrivialUDT
		'' Huge field so that the param will be much bigger than an ANY PTR,
		'' so if va_first() assumes passing BYVAL when it's actually BYREF,
		'' we notice the difference, because then va_first() and thus the
		'' va_arg() will be way off...
		array(0 to 64-1) as integer
		declare constructor( )
		declare constructor( byref as NonTrivialUDT )
		declare destructor( )
	end type

	constructor NonTrivialUDT( )
	end constructor

	constructor NonTrivialUDT( byref rhs as NonTrivialUDT )
	end constructor

	destructor NonTrivialUDT( )
	end destructor

	function hVaFirstBehindByvalNonTrivialUdt cdecl _
		( _
			byval x as NonTrivialUDT, _
			... _
		) as integer

		dim arg as any ptr = any

		arg = va_first( )
		CU_ASSERT( va_arg( arg, integer ) = 123 )

		arg = va_next( arg, integer )
		CU_ASSERT( va_arg( arg, integer ) = 456 )

		arg = va_next( arg, integer )
		CU_ASSERT( va_arg( arg, integer ) = 789 )

		function = 321
	end function

	'' va_first()
	TEST( va_first_ )
		hVaFirstBehindByte( -1, &hAABBCCDD )
		hVaFirstBehindShort( -1, &h44332211 )
		hVaFirstBehindUdt( type<T>( -1, -1 ), &hFF006622 )

		dim x as NonTrivialUDT
		CU_ASSERT( hVaFirstBehindByvalNonTrivialUdt( x, 123, 456, 789 ) = 321 )
	END_TEST

	sub hVaNext cdecl( byval n as integer, ... )
		#macro case_T(T) _
		case sizeof(T)
			CU_ASSERT_EQUAL(*cptr(T ptr, p), i)
			p = va_next(p, T)
		#endmacro

		dim as integer ptr p = va_first()

		for i as integer = 1 to n
			dim as integer siz = *p
			p = va_next(p, integer)
			select case siz
			case_T(byte)
			case_T(short)
			case_T(integer)
			case_T(longint)
			case else
				CU_FAIL( "Unexpected argument size" )
			end select
		next
	end sub

	'' va_next()
	TEST( va_next_ )
		hVaNext( 4, _
			sizeof(byte), cbyte(1), _
			sizeof(short), cshort(2), _
			sizeof(integer), cint(3), _
			sizeof(longint), clngint(4) )

		hVaNext( 4, _
			sizeof(ulongint), culngint(1), _
			sizeof(uinteger), cuint(2), _
			sizeof(ushort), cushort(3), _
			sizeof(ubyte), cubyte(4) )
	END_TEST

END_SUITE

#endif
