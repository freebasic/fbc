'[ ] add the ... subscript when initializing array so
'    "dim array(0 to ...) = {1, 2, 3, 4}" could be allowed

# include "fbcunit.bi"

SUITE( fbc_tests.dim_.array_ellipsis_init )

	TEST( test_dim )
		
		'-------------------------------------------------------------------------------
		' DIM
		'-------------------------------------------------------------------------------
		
		scope
			dim array(0 to 1, 0 to 3) as integer = _
			{ _
				{1, 2, 3, 4}, _
				{5, 6, 7, 8} _
			}
		
			for x as integer = 0 to 1
				for y as integer = 0 to 3
					CU_ASSERT_EQUAL( array(x, y), ((x * 4) + y + 1) )
				next y
			next x
			
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 1 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 3 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			dim array(0 to 1, 0 to ...) as integer = _
			{ _
				{1, 2, 3, 4, 5}, _
				{6, 7, 8, 9, 10} _
			}
			
			for x as integer = 0 to 1
				for y as integer = 0 to 4
					CU_ASSERT_EQUAL( array(x, y), ((x * 5) + y + 1) )
				next y
			next x
			
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 1 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 4 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			dim array(0 to ..., 0 to ...) as integer = _
			{ _
				{1, 2, 3, 4, 5}, _
				{6, 7, 8, 9, 10} _
			}
			
			for x as integer = 0 to 1
				for y as integer = 0 to 4
					CU_ASSERT_EQUAL( array(x, y), ((x * 5) + y + 1) )
				next y
			next x
			
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 1 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 4 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			dim array(0 to ..., 0 to 4) as integer = _
			{ _
				{0, 1, 2, 3, 4}, _
				{5, 6, 7, 8, 9} _
			}
			
			for x as integer = 0 to 1
				for y as integer = 0 to 4
					CU_ASSERT_EQUAL( array(x, y), ((x * 5) + y) )
				next y
			next x
			
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 1 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 4 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			dim array(0 to ..., 0 to ...) as integer = _
			{ _
				{5, 6, 7, 8}, _
				{1, 2, 3}, _
				{3, 2, 1} _
			}
			
			CU_ASSERT_EQUAL( array(0, 0), 5 )
			CU_ASSERT_EQUAL( array(0, 1), 6 )
			CU_ASSERT_EQUAL( array(0, 2), 7 )
			CU_ASSERT_EQUAL( array(0, 3), 8 )
		
			CU_ASSERT_EQUAL( array(1, 0), 1 )
			CU_ASSERT_EQUAL( array(1, 1), 2 )
			CU_ASSERT_EQUAL( array(1, 2), 3 )
			CU_ASSERT_EQUAL( array(1, 3), 0 )
		
			CU_ASSERT_EQUAL( array(2, 0), 3 )
			CU_ASSERT_EQUAL( array(2, 1), 2 )
			CU_ASSERT_EQUAL( array(2, 2), 1 )
			CU_ASSERT_EQUAL( array(2, 3), 0 )
		
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 2 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 3 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			dim array(...) as integer = {1, 2, 3, 4}
			
			for y as integer = 0 to 3
				CU_ASSERT_EQUAL( array(y), y + 1)
			next y
		
			CU_ASSERT_EQUAL( lbound( array ), 0 )
			CU_ASSERT_EQUAL( ubound( array ), 3 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			dim array(1 to ...) as integer = {0, 1, 2, 3, 4}
			
			for y as integer = 1 to 5
				CU_ASSERT_EQUAL( array(y), y - 1)
			next y
		
			CU_ASSERT_EQUAL( lbound( array ), 1 )
			CU_ASSERT_EQUAL( ubound( array ), 5 )
		end scope

	END_TEST

	TEST( test_static )
		
		'-------------------------------------------------------------------------------
		' STATIC
		'-------------------------------------------------------------------------------
		
		scope
			static array(0 to 1, 0 to 3) as integer = _
			{ _
				{1, 2, 3, 4}, _
				{5, 6, 7, 8} _
			}
		
			for x as integer = 0 to 1
				for y as integer = 0 to 3
					CU_ASSERT_EQUAL( array(x, y), ((x * 4) + y + 1) )
				next y
			next x
			
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 1 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 3 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			static array(0 to 1, 0 to ...) as integer = _
			{ _
				{1, 2, 3, 4, 5}, _
				{6, 7, 8, 9, 10} _
			}
			
			for x as integer = 0 to 1
				for y as integer = 0 to 4
					CU_ASSERT_EQUAL( array(x, y), ((x * 5) + y + 1) )
				next y
			next x
			
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 1 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 4 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			static array(0 to ..., 0 to ...) as integer = _
			{ _
				{1, 2, 3, 4, 5}, _
				{6, 7, 8, 9, 10} _
			}
			
			for x as integer = 0 to 1
				for y as integer = 0 to 4
					CU_ASSERT_EQUAL( array(x, y), ((x * 5) + y + 1) )
				next y
			next x
			
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 1 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 4 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			static array(0 to ..., 0 to 4) as integer = _
			{ _
				{0, 1, 2, 3, 4}, _
				{5, 6, 7, 8, 9} _
			}
			
			for x as integer = 0 to 1
				for y as integer = 0 to 4
					CU_ASSERT_EQUAL( array(x, y), ((x * 5) + y) )
				next y
			next x
			
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 1 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 4 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			static array(0 to ..., 0 to ...) as integer = _
			{ _
				{5, 6, 7, 8}, _
				{1, 2, 3}, _
				{3, 2, 1} _
			}
			
			CU_ASSERT_EQUAL( array(0, 0), 5 )
			CU_ASSERT_EQUAL( array(0, 1), 6 )
			CU_ASSERT_EQUAL( array(0, 2), 7 )
			CU_ASSERT_EQUAL( array(0, 3), 8 )
		
			CU_ASSERT_EQUAL( array(1, 0), 1 )
			CU_ASSERT_EQUAL( array(1, 1), 2 )
			CU_ASSERT_EQUAL( array(1, 2), 3 )
			CU_ASSERT_EQUAL( array(1, 3), 0 )
		
			CU_ASSERT_EQUAL( array(2, 0), 3 )
			CU_ASSERT_EQUAL( array(2, 1), 2 )
			CU_ASSERT_EQUAL( array(2, 2), 1 )
			CU_ASSERT_EQUAL( array(2, 3), 0 )
		
			CU_ASSERT_EQUAL( lbound( array, 1 ), 0 )
			CU_ASSERT_EQUAL( lbound( array, 2 ), 0 )
			CU_ASSERT_EQUAL( ubound( array, 1 ), 2 )
			CU_ASSERT_EQUAL( ubound( array, 2 ), 3 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			static array(...) as integer = {1, 2, 3, 4}
			
			for y as integer = 0 to 3
				CU_ASSERT_EQUAL( array(y), y + 1)
			next y
		
			CU_ASSERT_EQUAL( lbound( array ), 0 )
			CU_ASSERT_EQUAL( ubound( array ), 3 )
		end scope
		
		'-------------------------------------------------------------------------------
		
		scope
			static array(1 to ...) as integer = {0, 1, 2, 3, 4}
			
			for y as integer = 1 to 5
				CU_ASSERT_EQUAL( array(y), y - 1)
			next y
		
			CU_ASSERT_EQUAL( lbound( array ), 1 )
			CU_ASSERT_EQUAL( ubound( array ), 5 )
		end scope

	END_TEST

	dim shared array1(0 to 1, 0 to 3) as integer = _
	{ _
		{1, 2, 3, 4}, _
		{5, 6, 7, 8} _
	}

	dim shared array2(0 to 1, 0 to ...) as integer = _
	{ _
		{1, 2, 3, 4, 5}, _
		{6, 7, 8, 9, 10} _
	}

	dim shared array3(0 to ..., 0 to ...) as integer = _
	{ _
		{1, 2, 3, 4, 5}, _
		{6, 7, 8, 9, 10} _
	}

	dim shared array4(0 to ..., 0 to 4) as integer = _
	{ _
		{0, 1, 2, 3, 4}, _
		{5, 6, 7, 8, 9} _
	}

	dim shared array5(0 to ..., 0 to ...) as integer = _
	{ _
		{5, 6, 7, 8}, _
		{1, 2, 3}, _
		{3, 2, 1} _
	}

	dim shared array6(...) as integer = {1, 2, 3, 4}

	dim shared array7(1 to ...) as integer = {0, 1, 2, 3, 4}

	TEST( dim_shared )

		'-------------------------------------------------------------------------------
		' DIM SHARED
		'-------------------------------------------------------------------------------

		for x as integer = 0 to 1
			for y as integer = 0 to 3
				CU_ASSERT_EQUAL( array1(x, y), ((x * 4) + y + 1) )
			next y
		next x
		
		CU_ASSERT_EQUAL( lbound( array1, 1 ), 0 )
		CU_ASSERT_EQUAL( lbound( array1, 2 ), 0 )
		CU_ASSERT_EQUAL( ubound( array1, 1 ), 1 )
		CU_ASSERT_EQUAL( ubound( array1, 2 ), 3 )

	'-------------------------------------------------------------------------------

		for x as integer = 0 to 1
			for y as integer = 0 to 4
				CU_ASSERT_EQUAL( array2(x, y), ((x * 5) + y + 1) )
			next y
		next x
		
		CU_ASSERT_EQUAL( lbound( array2, 1 ), 0 )
		CU_ASSERT_EQUAL( lbound( array2, 2 ), 0 )
		CU_ASSERT_EQUAL( ubound( array2, 1 ), 1 )
		CU_ASSERT_EQUAL( ubound( array2, 2 ), 4 )

	'-------------------------------------------------------------------------------
		
		for x as integer = 0 to 1
			for y as integer = 0 to 4
				CU_ASSERT_EQUAL( array3(x, y), ((x * 5) + y + 1) )
			next y
		next x
		
		CU_ASSERT_EQUAL( lbound( array3, 1 ), 0 )
		CU_ASSERT_EQUAL( lbound( array3, 2 ), 0 )
		CU_ASSERT_EQUAL( ubound( array3, 1 ), 1 )
		CU_ASSERT_EQUAL( ubound( array3, 2 ), 4 )

	'-------------------------------------------------------------------------------

		for x as integer = 0 to 1
			for y as integer = 0 to 4
				CU_ASSERT_EQUAL( array4(x, y), ((x * 5) + y) )
			next y
		next x
		
		CU_ASSERT_EQUAL( lbound( array4, 1 ), 0 )
		CU_ASSERT_EQUAL( lbound( array4, 2 ), 0 )
		CU_ASSERT_EQUAL( ubound( array4, 1 ), 1 )
		CU_ASSERT_EQUAL( ubound( array4, 2 ), 4 )

	'-------------------------------------------------------------------------------

		CU_ASSERT_EQUAL( array5(0, 0), 5 )
		CU_ASSERT_EQUAL( array5(0, 1), 6 )
		CU_ASSERT_EQUAL( array5(0, 2), 7 )
		CU_ASSERT_EQUAL( array5(0, 3), 8 )

		CU_ASSERT_EQUAL( array5(1, 0), 1 )
		CU_ASSERT_EQUAL( array5(1, 1), 2 )
		CU_ASSERT_EQUAL( array5(1, 2), 3 )
		CU_ASSERT_EQUAL( array5(1, 3), 0 )

		CU_ASSERT_EQUAL( array5(2, 0), 3 )
		CU_ASSERT_EQUAL( array5(2, 1), 2 )
		CU_ASSERT_EQUAL( array5(2, 2), 1 )
		CU_ASSERT_EQUAL( array5(2, 3), 0 )

		CU_ASSERT_EQUAL( lbound( array5, 1 ), 0 )
		CU_ASSERT_EQUAL( lbound( array5, 2 ), 0 )
		CU_ASSERT_EQUAL( ubound( array5, 1 ), 2 )
		CU_ASSERT_EQUAL( ubound( array5, 2 ), 3 )

	'-------------------------------------------------------------------------------

		for y as integer = 0 to 3
			CU_ASSERT_EQUAL( array6(y), y + 1)
		next y

		CU_ASSERT_EQUAL( lbound( array6 ), 0 )
		CU_ASSERT_EQUAL( ubound( array6 ), 3 )

	'-------------------------------------------------------------------------------

		for y as integer = 1 to 5
			CU_ASSERT_EQUAL( array7(y), y - 1)
		next y

		CU_ASSERT_EQUAL( lbound( array7 ), 1 )
		CU_ASSERT_EQUAL( ubound( array7 ), 5 )

	END_TEST

END_SUITE

'-------------------------------------------------------------------------------
' THINGS THAT SHOULDN'T WORK
'-------------------------------------------------------------------------------

/'
	' can't have any with ...!!!!
	dim array8(0 to ...) as integer = any

	' can't have any with ...!!!!
	static array9(0 to ...) as integer = any

	' because ... works by the size of the first row, any other row can't be
	' bigger!
	dim array10(0 to 1, 0 to ...) as integer = _
	{ _
		{5, 6}, _
		{1, 2, 3} _
	}

	' because ... works by the size of the first row, any other row can't be
	' bigger!
	static array11(0 to 1, 0 to ...) as integer = _
	{ _
		{5, 6}, _
		{1, 2, 3} _
	}

	dim a1(...) as integer
	dim a2(... to 10) as integer
	dim a3(... to ...) as integer

	static a4(...) as integer
	static a5(... to 10) as integer
	static a6(... to ...) as integer
'/

