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
		
		Dim x##__TYPE__##__ISPTR__ As __TYPE__##T##__ISPTR__
		#if __ISPTR__
			x##__TYPE__##__ISPTR__.a = 0
		#else
			x##__TYPE__##__ISPTR__.a = -1
		#endif
		
		if x##__TYPE__##__ISPTR__ then
			ASSERT( x##__TYPE__##__ISPTR__.a )
		else
			ASSERT( x##__TYPE__##__ISPTR__.a = 0 )
		end if
		
		#if __ISPTR__ = 0
			while (x##__TYPE__##__ISPTR__ < 10)
			    x##__TYPE__##__ISPTR__.a += 1
			wend
			ASSERT( x##__TYPE__##__ISPTR__.a = 10)
		#endif
	
	#endmacro
	
	sub testAll( )

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
	end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.structs.bool_expr_cast")
		fbcu.add_test("testAll", @testAll)
	
	end sub

end namespace
	
