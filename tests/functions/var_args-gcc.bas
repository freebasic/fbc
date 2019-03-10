# include "fbcunit.bi"

SUITE( fbc_tests.functions.var_args_gcc )

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
		dim as cva_list arg = any
		dim as zstring ptr p
		dim as integer i, char

		cva_start( arg, fmtstr )
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
					CU_ASSERT( cva_arg( arg, byte ) = TEST_B )

				case asc( "c" )
					CU_ASSERT( cva_arg( arg, ubyte ) = TEST_UB )

				case asc( "s" )
					CU_ASSERT( cva_arg( arg, short ) = TEST_S )

				case asc( "r" )
					CU_ASSERT( cva_arg( arg, ushort ) = TEST_US )

				case asc( "i" )
					CU_ASSERT( cva_arg( arg, integer ) = TEST_I )

				case asc( "j" )
					CU_ASSERT( cva_arg( arg, uinteger ) = TEST_UI )

				case asc( "l" )
					CU_ASSERT( cva_arg( arg, longint ) = TEST_L )

				case asc( "m" )
					CU_ASSERT( cva_arg( arg, ulongint ) = TEST_UL )
				
				case asc( "f" )
					CU_ASSERT( cva_arg( arg, double ) = TEST_F )

				case asc( "d" )
					CU_ASSERT( cva_arg( arg, double ) = TEST_D )

				case asc( "z" )
					CU_ASSERT( *cva_arg( arg, zstring ptr ) = TEST_Z )

				end select
			end if
		loop
		cva_end( arg )
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
		dim as cva_list p = any
		cva_start( p, n )
		CU_ASSERT( cva_arg( p, integer ) = &hAABBCCDD )
		cva_end( p )
	end sub

	sub hVaFirstBehindShort cdecl( byval n as short, ... )
		dim as cva_list p = any
		cva_start( p, n )
		CU_ASSERT( cva_arg( p, integer ) = &h44332211 )
		cva_end( p )
	end sub

	type T field = 1
		as integer a
		as byte b
	end type

	sub hVaFirstBehindUdt cdecl( byval n as T, ... )
		dim as cva_list p = any
		cva_start( p, n )
		CU_ASSERT( cva_arg( p, integer ) = &hFF006622 )
		cva_end( p )
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

		dim arg as cva_list = any

		cva_start( arg, x )

		CU_ASSERT( cva_arg( arg, integer ) = 123 )

		CU_ASSERT( cva_arg( arg, integer ) = 456 )

		CU_ASSERT( cva_arg( arg, integer ) = 789 )

		cva_end( arg )

		function = 321
	end function

	TEST( first_args )
		hVaFirstBehindByte( -1, &hAABBCCDD )
		hVaFirstBehindShort( -1, &h44332211 )
		hVaFirstBehindUdt( type<T>( -1, -1 ), &hFF006622 )

		dim x as NonTrivialUDT
		CU_ASSERT( hVaFirstBehindByvalNonTrivialUdt( x, 123, 456, 789 ) = 321 )
	END_TEST

	sub hVaNext cdecl( byval n as integer, ... )
		#macro case_T(T) _
		case sizeof(T)
			CU_ASSERT_EQUAL( cva_arg( p, T ), i )
		#endmacro

		dim as cva_list p = any
		cva_start( p, n )

		for i as integer = 1 to n
			dim as integer siz = cva_arg( p, integer )
			select case siz
			case_T(byte)
			case_T(short)
			case_T(integer)
			case_T(longint)
			case else
				CU_FAIL( "Unexpected argument size" )
			end select
		next
		cva_end( p )
	end sub

	TEST( next_args )
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
