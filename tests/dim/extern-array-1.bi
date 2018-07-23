extern externarray1(0 to 1) as integer
extern externarray2() as integer
extern externarray3(0 to 1) as integer
extern externarray4(10 to 10, 20 to 20, 30 to 30) as integer
extern externarray5(10 to 10, 20 to 20) as integer
extern externarray6() as integer
extern externarray7() as integer
extern externarray8(any) as integer
extern externarray9(any) as integer

#macro hInsertTest1( )
	TEST( testproc )
		CU_ASSERT( externarray1(0) = 1 )
		CU_ASSERT( externarray1(1) = 2 )
		CU_ASSERT( lbound( externarray1 ) = 0 )
		CU_ASSERT( ubound( externarray1 ) = 1 )

		redim externarray2(20 to 21)
		CU_ASSERT( lbound( externarray2 ) = 20 )
		CU_ASSERT( ubound( externarray2 ) = 21 )

		CU_ASSERT( externarray3(0) = 0 )
		CU_ASSERT( externarray3(1) = 0 )
		CU_ASSERT( lbound( externarray3 ) = 0 )
		CU_ASSERT( ubound( externarray3 ) = 1 )

		CU_ASSERT( externarray4(10, 20, 30) = 123 )
		CU_ASSERT( lbound( externarray4, 1 ) = 10 )
		CU_ASSERT( ubound( externarray4, 1 ) = 10 )
		CU_ASSERT( lbound( externarray4, 2 ) = 20 )
		CU_ASSERT( ubound( externarray4, 2 ) = 20 )
		CU_ASSERT( lbound( externarray4, 3 ) = 30 )
		CU_ASSERT( ubound( externarray4, 3 ) = 30 )

		CU_ASSERT( externarray5(10, 20) = 12 )
		CU_ASSERT( lbound( externarray5, 1 ) = 10 )
		CU_ASSERT( ubound( externarray5, 1 ) = 10 )
		CU_ASSERT( lbound( externarray5, 2 ) = 20 )
		CU_ASSERT( ubound( externarray5, 2 ) = 20 )

		CU_ASSERT( lbound( externarray6 ) = 6 )
		CU_ASSERT( ubound( externarray6 ) = 6 )

		CU_ASSERT( lbound( externarray7 ) = 7 )
		CU_ASSERT( ubound( externarray7 ) = 7 )

		redim externarray8(8 to 8)
		CU_ASSERT( lbound( externarray8 ) = 8 )
		CU_ASSERT( ubound( externarray8 ) = 8 )

		CU_ASSERT( lbound( externarray9 ) = 9 )
		CU_ASSERT( ubound( externarray9 ) = 9 )
	END_TEST
#endmacro
