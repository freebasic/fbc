extern externarray1(0 to 1) as integer
'extern externarray2() as integer
extern externarray3(0 to 1) as integer
extern externarray4(10 to 10, 20 to 20, 30 to 30) as integer
extern externarray5(10 to 10, 20 to 20) as integer

#macro hInsertTest1( )
	sub test1 cdecl( )
		CU_ASSERT( externarray1(0) = 1 )
		CU_ASSERT( externarray1(1) = 2 )
		CU_ASSERT( lbound( externarray1 ) = 0 )
		CU_ASSERT( ubound( externarray1 ) = 1 )

		'redim externarray2(20 to 21)
		'CU_ASSERT( lbound( externarray2 ) = 20 )
		'CU_ASSERT( ubound( externarray2 ) = 21 )

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
	end sub
#endmacro
