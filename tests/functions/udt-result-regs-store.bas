#include "fbcunit.bi"

'' UDTs of 9 to 16 bytes are returned in two registers on x86_64 SysV
'' (rax/rdx, xmm0/xmm1 or a mix). Storing such a result into a target that
'' is not a named variable (an array element with a variable index, a
'' pointer deref) and storing the second part of odd sizes was wrong with
'' gas64: some fields were lost or garbage, and fbc itself crashed on
'' '*p = f( )'.

SUITE( fbc_tests.functions.udt_result_regs_store )

	#macro hDefineBytes( N )
		type TB##N field = 1
			as ubyte b(0 to N - 1)
		end type

		private function getTB##N( byval seed as integer ) as TB##N
			dim as TB##N r
			for i as integer = 0 to N - 1
				r.b(i) = seed + i
			next
			return r
		end function

		private sub hCheckTB##N( byref r as TB##N, byval seed as integer )
			for i as integer = 0 to N - 1
				CU_ASSERT_EQUAL( r.b(i), seed + i )
			next
		end sub

		TEST( bytes##N )
			dim as TB##N v
			v = getTB##N( 10 )
			hCheckTB##N( v, 10 )

			dim as TB##N arr(0 to 3)
			dim as integer idx = 2
			arr(idx) = getTB##N( 20 )
			hCheckTB##N( arr(2), 20 )

			dim as TB##N ptr p = new TB##N
			*p = getTB##N( 30 )
			hCheckTB##N( *p, 30 )
			delete p
		END_TEST
	#endmacro

	hDefineBytes( 9 )
	hDefineBytes( 10 )
	hDefineBytes( 11 )
	hDefineBytes( 12 )
	hDefineBytes( 13 )
	hDefineBytes( 14 )
	hDefineBytes( 15 )
	hDefineBytes( 16 )

	type TLong3
		as long a, b, c
	end type

	type TDblInt
		as double x
		as longint y
	end type

	type TIntDbl
		as longint x
		as double y
	end type

	type TDbl2
		as double x, y
	end type

	private function getLong3( ) as TLong3
		return type( 11, 22, 33 )
	end function

	private function getDblInt( ) as TDblInt
		return type( 1.5, 77 )
	end function

	private function getIntDbl( ) as TIntDbl
		return type( 88, 2.5 )
	end function

	private function getDbl2( ) as TDbl2
		return type( 3.5, 4.5 )
	end function

	TEST( mixedRegs )
		dim as integer idx = 2

		dim as TLong3 l3(0 to 3)
		l3(idx) = getLong3( )
		CU_ASSERT_EQUAL( l3(2).a, 11 )
		CU_ASSERT_EQUAL( l3(2).b, 22 )
		CU_ASSERT_EQUAL( l3(2).c, 33 )

		dim as TLong3 ptr pl3 = new TLong3
		*pl3 = getLong3( )
		CU_ASSERT_EQUAL( pl3->a, 11 )
		CU_ASSERT_EQUAL( pl3->c, 33 )
		delete pl3

		dim as TDblInt di(0 to 3)
		di(idx) = getDblInt( )
		CU_ASSERT_EQUAL( di(2).x, 1.5 )
		CU_ASSERT_EQUAL( di(2).y, 77 )

		dim as TDblInt ptr pdi = new TDblInt
		*pdi = getDblInt( )
		CU_ASSERT_EQUAL( pdi->x, 1.5 )
		CU_ASSERT_EQUAL( pdi->y, 77 )
		delete pdi

		dim as TIntDbl id(0 to 3)
		id(idx) = getIntDbl( )
		CU_ASSERT_EQUAL( id(2).x, 88 )
		CU_ASSERT_EQUAL( id(2).y, 2.5 )

		dim as TDbl2 d2(0 to 3)
		d2(idx) = getDbl2( )
		CU_ASSERT_EQUAL( d2(2).x, 3.5 )
		CU_ASSERT_EQUAL( d2(2).y, 4.5 )

		dim as TDblInt v
		v = getDblInt( )
		CU_ASSERT_EQUAL( v.x, 1.5 )
		CU_ASSERT_EQUAL( v.y, 77 )
	END_TEST

END_SUITE
