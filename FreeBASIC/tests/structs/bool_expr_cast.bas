# include "fbcu.bi"

namespace fbc_tests.structs.bool_expr_cast

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

	sub test_byte cdecl( )
		doTest( byte   , 0 )
	end sub
	
	sub test_short cdecl
		doTest( short  , 0 )
	end sub

	sub test_int cdecl
		doTest( integer, 0 )
	end sub

	sub test_long cdecl
		doTest( longint, 0 )
	end sub

	sub test_single cdecl
		doTest( single , 0 )
	end sub

	sub test_dbl cdecl
		doTest( double , 0 )
	end sub

	sub test_ptr_any cdecl( )
		doTest( any   , 1 )
	end sub
	
	sub test_ptr_short cdecl
		doTest( short  , 1 )
	end sub

	sub test_ptr_int cdecl
		doTest( integer, 1 )
	end sub

	sub test_ptr_long cdecl
		doTest( longint, 1 )
	end sub

	sub test_ptr_single cdecl
		doTest( single , 1 )
	end sub

	sub test_ptr_dbl cdecl
		doTest( double , 1 )
	end sub

	private sub ctor () constructor
		fbcu.add_suite("fbc_tests.structs.bool_expr_cast")
		
		fbcu.add_test("byte", @test_byte)
		fbcu.add_test("short", @test_short)
		fbcu.add_test("integer", @test_int)
		fbcu.add_test("longint", @test_long)
		fbcu.add_test("single", @test_single)
		fbcu.add_test("double", @test_dbl)
	
		fbcu.add_test("any ptr", @test_ptr_any)
		fbcu.add_test("short ptr", @test_ptr_short)
		fbcu.add_test("integer ptr", @test_ptr_int)
		fbcu.add_test("longint ptr", @test_ptr_long)
		fbcu.add_test("single ptr", @test_ptr_single)
		fbcu.add_test("double ptr", @test_ptr_dbl)
	end sub

end namespace
	
