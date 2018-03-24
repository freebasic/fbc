#include "fbcunit.bi"

SUITE( fbc_tests.structs.bool_expr_cast )

	#macro buildCheck( __TYPE__, __ISPTR__ )
		#undef __PTROPT__
		#if __ISPTR__
			#define __PTROPT__ ptr
		#else
			#define __PTROPT__
		#endif
	
		Type __TYPE__##T##__ISPTR__
		  a As __TYPE__ __PTROPT__
		  Declare operator cast() As __TYPE__ __PTROPT__
		End Type
		
		operator __TYPE__##T##__ISPTR__.cast() As __TYPE__ __PTROPT__
		  Return a
		End operator
	#endmacro
		
	#macro doTest( __TYPE__, __ISPTR__ )
		#undef __PTROPT__
		#if __ISPTR__
			#define __PTROPT__ ptr
		#else
			#define __PTROPT__
		#endif

		Dim x##__TYPE__##__ISPTR__ As __TYPE__##T##__ISPTR__
		#if __ISPTR__
			x##__TYPE__##__ISPTR__.a = 0
		#else
			x##__TYPE__##__ISPTR__.a = -1
		#endif
		
		if x##__TYPE__##__ISPTR__ then
			CU_ASSERT( x##__TYPE__##__ISPTR__.a <> 0 )
		else
			CU_ASSERT( x##__TYPE__##__ISPTR__.a = 0 )
		end if
		
		#if __ISPTR__ = 0
			while (x##__TYPE__##__ISPTR__ < 10)
			    x##__TYPE__##__ISPTR__.a += 1
			wend
			CU_ASSERT( x##__TYPE__##__ISPTR__.a = 10)
		#endif
	
	#endmacro
	
	buildCheck( byte   , 0 )
	buildCheck( short  , 0 )
	buildCheck( integer, 0 )
	buildCheck( longint, 0 )
	buildCheck( single , 0 )
	buildCheck( double , 0 )
		
	buildCheck( any   , 1 )
	buildCheck( short  , 1 )
	buildCheck( integer, 1 )
	buildCheck( longint, 1 )
	buildCheck( single , 1 )
	buildCheck( double , 1 )

	TEST( byte_ )
		doTest( byte   , 0 )
	END_TEST
	
	TEST( short_ )
		doTest( short  , 0 )
	END_TEST

	TEST( integer_ )
		doTest( integer, 0 )
	END_TEST

	TEST( long_ )
		doTest( longint, 0 )
	END_TEST

	TEST( single_ )
		doTest( single , 0 )
	END_TEST

	TEST( double_ )
		doTest( double , 0 )
	END_TEST

	TEST( ptr_any )
		doTest( any   , 1 )
	END_TEST
	
	TEST( ptr_short )
		doTest( short  , 1 )
	END_TEST

	TEST( ptr_int )
		doTest( integer, 1 )
	END_TEST

	TEST( ptr_long )
		doTest( longint, 1 )
	END_TEST

	TEST( ptr_single )
		doTest( single , 1 )
	END_TEST

	TEST( ptr_double )
		doTest( double , 1 )
	END_TEST

END_SUITE
