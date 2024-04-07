#include "fbcunit.bi"

#include "fblimits.bi"

'' macro methods for producing min/max values (counting_pine)
'' used for testing against the constants in fblimits.bi
''

	#define is_float(T) (cast(T, 0.5) = 0.5)
	#define is_single(T) (is_float(T) and sizeof(T) = 4)
	#define is_double(T) (is_float(T) and sizeof(T) = 8)
	#define is_signed(T) (cast(T, -cast(T, 1)) < 0)
	#define min_unsigned(T) cast(T, 0)
	#define max_unsigned(T) cast(T, not 0)
	#define min_signed(T) cast(T, -1LL shl (sizeof(T)*8-1))
	#define max_signed(T) cast(T, iif(is_signed(T),not min_signed(T),0))
	#define min_int(T) cast(T, iif(is_signed(T), min_signed(T), min_unsigned(T)))
	#define max_int(T) cast(T, iif(is_signed(T), max_signed(T), max_unsigned(T)))
	#define max_single(T) cast(T, iif(is_single(T), 3.402823466e+38, 0))
	#define min_single(T) cast(T, -max_single(T))
	#define max_double(T) cast(T, iif(is_double(T), 1.7976931348623157D+308#, 0#))
	#define min_double(T) cast(T, -max_double(T))
	#define max_float(T) cast(T, iif(is_single(T), max_single(T), max_double(T)))
	#define min_float(T) cast(T, iif(is_single(T), min_single(T), min_double(T)))
	#define max_value(T) cast(T, iif(is_float(T), max_float(T), max_int(T)))
	#define min_value(T) cast(T, iif(is_float(T), min_float(T), min_int(T)))

SUITE( fbc_tests.numbers.limits )

	'' single bits
	const sng_min_bits = &hFF7FFFFF
	const sng_max_bits = &h7F7FFFFF

	'' double bits
	const dbl_min_bits = &hFFEFFFFFFFFFFFFF
	const dbl_max_bits = &h7FEFFFFFFFFFFFFF

	TEST( default )

		dim s8_min as byte       = min_value( byte )
		dim s8_max as byte       = max_value( byte )
		dim u8_min as ubyte      = min_value( ubyte )
		dim u8_max as ubyte      = max_value( ubyte )

		dim s16_min as short     = min_value( short )
		dim s16_max as short     = max_value( short )
		dim u16_min as ushort    = min_value( ushort )
		dim u16_max as ushort    = max_value( ushort )

		dim s32_min as long      = min_value( long )
		dim s32_max as long      = max_value( long )
		dim u32_min as ulong     = min_value( ulong )
		dim u32_max as ulong     = max_value( ulong )

		dim sint_min as integer  = min_value( integer )
		dim sint_max as integer  = max_value( integer )
		dim uint_min as uinteger = min_value( uinteger )
		dim uint_max as uinteger = max_value( uinteger )

		dim s64_min as longint   = min_value( longint )
		dim s64_max as longint   = max_value( longint )
		dim u64_min as ulongint  = min_value( ulongint )
		dim u64_max as ulongint  = max_value( ulongint )

		dim sng_min as single    = min_float( single )
		dim sng_max as single    = max_float( single )

		dim dbl_min as double    = min_float( double )
		dim dbl_max as double    = max_float( double )

		CU_ASSERT_EQUAL( s8_min  , fb.MIN_VALUE_BYTE )
		CU_ASSERT_EQUAL( s8_max  , fb.MAX_VALUE_BYTE )
		CU_ASSERT_EQUAL( u8_min  , fb.MIN_VALUE_UBYTE )
		CU_ASSERT_EQUAL( u8_max  , fb.MAX_VALUE_UBYTE )

		CU_ASSERT_EQUAL( s16_min , fb.MIN_VALUE_SHORT )
		CU_ASSERT_EQUAL( s16_max , fb.MAX_VALUE_SHORT )
		CU_ASSERT_EQUAL( u16_min , fb.MIN_VALUE_USHORT )
		CU_ASSERT_EQUAL( u16_max , fb.MAX_VALUE_USHORT )

		CU_ASSERT_EQUAL( s32_min , fb.MIN_VALUE_LONG )
		CU_ASSERT_EQUAL( s32_max , fb.MAX_VALUE_LONG )
		CU_ASSERT_EQUAL( u32_min , fb.MIN_VALUE_ULONG )
		CU_ASSERT_EQUAL( u32_max , fb.MAX_VALUE_ULONG )

		CU_ASSERT_EQUAL( sint_min, fb.MIN_VALUE_INTEGER )
		CU_ASSERT_EQUAL( sint_max, fb.MAX_VALUE_INTEGER )
		CU_ASSERT_EQUAL( uint_min, fb.MIN_VALUE_UINTEGER )
		CU_ASSERT_EQUAL( uint_max, fb.MAX_VALUE_UINTEGER )

		CU_ASSERT_EQUAL( s64_min , fb.MIN_VALUE_LONGINT )
		CU_ASSERT_EQUAL( s64_max , fb.MAX_VALUE_LONGINT )
		CU_ASSERT_EQUAL( u64_min , fb.MIN_VALUE_ULONGINT )
		CU_ASSERT_EQUAL( u64_max , fb.MAX_VALUE_ULONGINT )


		'' check floating point min/max using bit representation
		'' this helps to ensure that the constants (literals)
		'' were properly read from the include file

		scope
			dim chk_sng_min_bits as ulong = sng_min_bits
			dim chk_sng_max_bits as ulong = sng_max_bits
			dim as ulong ptr tst_sng_min_bits = cast( ulong ptr, @sng_min )
			dim as ulong ptr tst_sng_max_bits = cast( ulong ptr, @sng_max )

			CU_ASSERT_EQUAL( chk_sng_min_bits , *tst_sng_min_bits )
			CU_ASSERT_EQUAL( chk_sng_max_bits , *tst_sng_max_bits )
		end scope

		scope
			dim chk_dbl_min_bits as ulongint = dbl_min_bits
			dim chk_dbl_max_bits as ulongint = dbl_max_bits
			dim as ulongint ptr tst_dbl_min_bits = cast( ulongint ptr, @dbl_min )
			dim as ulongint ptr tst_dbl_max_bits = cast( ulongint ptr, @dbl_max )

			CU_ASSERT_EQUAL( chk_dbl_min_bits , *tst_dbl_min_bits )
			CU_ASSERT_EQUAL( chk_dbl_max_bits , *tst_dbl_max_bits )
		end scope

		'' check floating point min/max using expressions

		scope
			dim chk_sng_min as single = -(2^127) * (1 + (1 - 2^(-23)))
			dim chk_sng_max as single = (2^127) * (1 + (1 - 2^(-23)))

			CU_ASSERT_EQUAL( chk_sng_min , fb.MIN_VALUE_SINGLE )
			CU_ASSERT_EQUAL( chk_sng_max , fb.MAX_VALUE_SINGLE )
		end scope

		scope
			dim chk_dbl_min as double = -(2^1023) * (1 + (1 - 2^(-52)))
			dim chk_dbl_max as double = (2^1023) * (1 + (1 - 2^(-52)))

			CU_ASSERT_EQUAL( chk_dbl_min , fb.MIN_VALUE_DOUBLE )
			CU_ASSERT_EQUAL( chk_dbl_max , fb.MAX_VALUE_DOUBLE )
		end scope

	END_TEST

	TEST( sizes )
		'' constants are typed so we should expect sizeof() to match

		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_BYTE )    , sizeof(byte)     )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_BYTE )    , sizeof(byte)     )
		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_UBYTE )   , sizeof(ubyte)    )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_UBYTE )   , sizeof(ubyte)    )

		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_SHORT )   , sizeof(short)    )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_SHORT )   , sizeof(short)    )
		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_USHORT )  , sizeof(ushort)   )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_USHORT )  , sizeof(ushort)   )

		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_LONG )    , sizeof(long)     )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_LONG )    , sizeof(long)     )
		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_ULONG )   , sizeof(ulong)    )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_ULONG )   , sizeof(ulong)    )

		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_INTEGER ) , sizeof(integer)  )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_INTEGER ) , sizeof(integer)  )
		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_UINTEGER ), sizeof(uinteger) )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_UINTEGER ), sizeof(uinteger) )

		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_LONGINT ) , sizeof(longint)  )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_LONGINT ) , sizeof(longint)  )
		CU_ASSERT_EQUAL( sizeof( fb.MIN_VALUE_ULONGINT ), sizeof(ulongint) )
		CU_ASSERT_EQUAL( sizeof( fb.MAX_VALUE_ULONGINT ), sizeof(ulongint) )

	END_TEST

END_SUITE
