#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_ctor_coercion_ref )

	enum TEST_TYPE
		TEST_TYPE_BYTE = 1
		TEST_TYPE_SHORT
		TEST_TYPE_INTEGER
		TEST_TYPE_LONG
		TEST_TYPE_LONGINT
		TEST_TYPE_UBYTE
		TEST_TYPE_USHORT
		TEST_TYPE_UINTEGER
		TEST_TYPE_ULONG
		TEST_TYPE_ULONGINT
		TEST_TYPE_SINGLE
		TEST_TYPE_DOUBLE
		TEST_TYPE_BAR
	end enum

	const TEST_VAL_BYTE as byte = 1
	const TEST_VAL_SHORT as short = 2
	const TEST_VAL_INTEGER as integer = 3
	const TEST_VAL_LONG as long = 4
	const TEST_VAL_LONGINT as longint = 5
	const TEST_VAL_UBYTE as ubyte = 6
	const TEST_VAL_USHORT as ushort = 7
	const TEST_VAL_UINTEGER as uinteger = 8
	const TEST_VAL_ULONG as ulong = 9
	const TEST_VAL_ULONGINT as ulongint = 10
	const TEST_VAL_SINGLE as single = 11
	const TEST_VAL_DOUBLE as double = 12
		
	type bar
		as byte pad
	end type

	type foo
		as TEST_TYPE _type = any
		declare constructor( )
		declare constructor( byref v as byte )
		declare constructor( byref v as short )
		declare constructor( byref v as integer )
		declare constructor( byref v as long )
		declare constructor( byref v as longint )
		declare constructor( byref v as ubyte )
		declare constructor( byref v as ushort )
		declare constructor( byref v as uinteger )
		declare constructor( byref v as ulong )
		declare constructor( byref v as ulongint )
		declare constructor( byref v as single )
		declare constructor( byref v as double )
		declare constructor( byref v as bar )
	end type

	constructor foo( )
		_type = 0
	end constructor

		dim shared as bar TEST_VAL_BAR

	#macro gen_test( tp )
		constructor foo( byref v as tp )
			_type = TEST_TYPE_##tp
		end constructor

		sub tp##_ref( byref f as foo )
			CU_ASSERT_EQUAL( f._type, TEST_TYPE_##tp )
		end sub
		
		sub tp##_val( byval f as foo )
			CU_ASSERT_EQUAL( f._type, TEST_TYPE_##tp )
		end sub

		TEST( tp##_test )
			dim f as foo
			
			tp##_ref( TEST_VAL_##tp )
			tp##_val( TEST_VAL_##tp )
			
		END_TEST
	#endmacro

	gen_test( byte )
	gen_test( short )
	gen_test( integer )
	gen_test( long )
	gen_test( longint )
	gen_test( single )
	gen_test( double )
	gen_test( ubyte )
	gen_test( ushort )
	gen_test( uinteger )
	gen_test( ulong )
	gen_test( ulongint )
	gen_test( bar )

END_SUITE
