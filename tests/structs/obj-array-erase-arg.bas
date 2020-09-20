#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_array_erase_arg )

	'' ERASE for fixed-size arrays = fb_ArrayClear[Obj] =
	'' 1) dtor calls 2) clear 3) ctor calls (reinit)
	TEST_GROUP( fixedsize )
		dim shared as integer T1_ctors = 0
		dim shared as integer T2_dtors = 0
		dim shared as integer T3_ctors = 0
		dim shared as integer T3_dtors = 0

		type T0
			as integer i
		end type

		type T1
			as integer i
			declare constructor()
		end type

		type T2
			as integer i
			declare destructor()
		end type

		type T3
			as integer i
			declare constructor()
			declare destructor()
		end type

		constructor T1()
			T1_ctors += 1
		end constructor

		destructor T2()
			T2_dtors += 1
		end destructor

		constructor T3()
			T3_ctors += 1
		end constructor

		destructor T3()
			T3_dtors += 1
		end destructor

		sub erase_T0( arg() as T0 )
			erase arg 
		end sub 

		sub erase_T1( arg() as T1 )
			erase arg 
		end sub 

		sub erase_T2( arg() as T2 )
			erase arg 
		end sub 

		sub erase_T3( arg() as T3 )
			erase arg 
		end sub 

		TEST( default )
			scope
				'' Local fixed-size array, POD
				dim as T0 x0(0 to 1)
				CU_ASSERT( x0(0).i = 0 )
				CU_ASSERT( x0(1).i = 0 )
				x0(0).i = 5
				x0(1).i = 6
				erase_T0 x0() '' clear
				CU_ASSERT( x0(0).i = 0 )
				CU_ASSERT( x0(1).i = 0 )
			end scope

			scope
				'' Local fixed-size array, ctor only
				CU_ASSERT( T1_ctors = 0 )
				dim as T1 x1(0 to 1)
				CU_ASSERT( T1_ctors = 2 )
				erase_T1 x1() '' clear & ctors
				CU_ASSERT( T1_ctors = 4 )
			end scope

			scope
				'' Local fixed-size array, dtor only
				scope
					dim as T2 x2(0 to 1)
					CU_ASSERT( T2_dtors = 0 )
					erase_T2 x2() '' dtors & clear
					CU_ASSERT( T2_dtors = 2 )
				end scope
				CU_ASSERT( T2_dtors = 4 )
			end scope

			scope
				'' Local fixed-size array, ctor & dtor
				scope
					CU_ASSERT( T3_ctors = 0 )
					dim as T3 x3(0 to 1)
					CU_ASSERT( T3_ctors = 2 )
					CU_ASSERT( T3_dtors = 0 )
					erase_T3 x3() '' dtors & clear & ctors
					CU_ASSERT( T3_dtors = 2 )
					CU_ASSERT( T3_ctors = 4 )
				end scope
				CU_ASSERT( T3_dtors = 4 )
			end scope
		END_TEST
	END_TEST_GROUP

	'' ERASE for dynamic arrays = fb_ArrayErase[Obj]() = dtor calls & deallocate
	TEST_GROUP( dynamic_ )

		dim shared as integer T1_ctors = 0
		dim shared as integer T2_dtors = 0
		dim shared as integer T3_ctors = 0
		dim shared as integer T3_dtors = 0

		type T0
			as integer i
		end type

		type T1
			as integer i
			declare constructor()
		end type

		type T2
			as integer i
			declare destructor()
		end type

		type T3
			as integer i
			declare constructor()
			declare destructor()
		end type

		constructor T1()
			T1_ctors += 1
		end constructor

		destructor T2()
			T2_dtors += 1
		end destructor

		constructor T3()
			T3_ctors += 1
		end constructor

		destructor T3()
			T3_dtors += 1
		end destructor

		sub erase_T0( arg() as T0 )
			erase arg 
		end sub 

		sub erase_T1( arg() as T1 )
			erase arg 
		end sub 

		sub erase_T2( arg() as T2 )
			erase arg 
		end sub 

		sub erase_T3( arg() as T3 )
			erase arg 
		end sub 

		TEST( default )
			scope
				'' Local dynamic array, POD
				redim as T0 x0(0 to 1)
				CU_ASSERT( x0(0).i = 0 )
				CU_ASSERT( x0(1).i = 0 )
				erase_T0 x0() '' deallocate
			end scope

			scope
				'' Local dynamic array, ctor only
				CU_ASSERT( T1_ctors = 0 )
				redim as T1 x1(0 to 1)
				CU_ASSERT( T1_ctors = 2 )
				erase_T1 x1() '' deallocate
				CU_ASSERT( T1_ctors = 2 )
			end scope

			scope
				'' Local dynamic array, dtor only
				scope
					redim as T2 x2(0 to 1)
					CU_ASSERT( T2_dtors = 0 )
					erase_T2 x2() '' dtors & deallocate
					CU_ASSERT( T2_dtors = 2 )
				end scope
				CU_ASSERT( T2_dtors = 2 )
			end scope

			scope
				'' Local dynamic array, ctor & dtor
				scope
					CU_ASSERT( T3_ctors = 0 )
					redim as T3 x3(0 to 1)
					CU_ASSERT( T3_ctors = 2 )
					erase_T3 x3() '' dtors & deallocate
					CU_ASSERT( T3_ctors = 2 )
					CU_ASSERT( T3_dtors = 2 )
				end scope
				CU_ASSERT( T3_dtors = 2 )
			end scope
		END_TEST
	END_TEST_GROUP

END_SUITE
