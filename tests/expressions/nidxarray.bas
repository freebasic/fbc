#include "fbcunit.bi"

SUITE( fbc_tests.expressions.nidxarray )

	type UDT
		fix(0 to 0) as integer
	end type

	dim shared as integer gfix(0 to 0) = { 123 }
	dim shared as integer gdyn()
	dim shared as UDT x = ( { 789 } )

	sub hCheckArg( byval i as integer, byval expect as integer )
		CU_ASSERT( i = expect )
	end sub

	TEST( testproc )
		redim gdyn(0 to 0)
		gdyn(0) = 456

		'' Expression context
		CU_ASSERT(  gfix(ubound(  gfix )) = 123 )
		CU_ASSERT(  gfix(ubound(  gdyn )) = 123 )
		CU_ASSERT(  gfix(ubound( x.fix )) = 123 )
		CU_ASSERT(  gdyn(ubound(  gfix )) = 456 )
		CU_ASSERT(  gdyn(ubound(  gdyn )) = 456 )
		CU_ASSERT(  gdyn(ubound( x.fix )) = 456 )
		CU_ASSERT( x.fix(ubound(  gfix )) = 789 )
		CU_ASSERT( x.fix(ubound(  gdyn )) = 789 )
		CU_ASSERT( x.fix(ubound( x.fix )) = 789 )

		'' ARG context
		hCheckArg(  gfix(ubound(  gfix )), 123 )
		hCheckArg(  gfix(ubound(  gdyn )), 123 )
		hCheckArg(  gfix(ubound( x.fix )), 123 )
		hCheckArg(  gdyn(ubound(  gfix )), 456 )
		hCheckArg(  gdyn(ubound(  gdyn )), 456 )
		hCheckArg(  gdyn(ubound( x.fix )), 456 )
		hCheckArg( x.fix(ubound(  gfix )), 789 )
		hCheckArg( x.fix(ubound(  gdyn )), 789 )
		hCheckArg( x.fix(ubound( x.fix )), 789 )

		'' lhs of assignment
		 gfix(ubound(  gfix )) = 123
		 gfix(ubound(  gdyn )) = 123
		 gfix(ubound( x.fix )) = 123
		 gdyn(ubound(  gfix )) = 456
		 gdyn(ubound(  gdyn )) = 456
		 gdyn(ubound( x.fix )) = 456
		x.fix(ubound(  gfix )) = 789
		x.fix(ubound(  gdyn )) = 789
		x.fix(ubound( x.fix )) = 789

		'' In sizeof()
		CU_ASSERT( sizeof(  gfix(ubound(  gfix )) ) = sizeof( integer ) )
		CU_ASSERT( sizeof(  gfix(ubound(  gdyn )) ) = sizeof( integer ) )
		CU_ASSERT( sizeof(  gfix(ubound( x.fix )) ) = sizeof( integer ) )
		CU_ASSERT( sizeof(  gdyn(ubound(  gfix )) ) = sizeof( integer ) )
		CU_ASSERT( sizeof(  gdyn(ubound(  gdyn )) ) = sizeof( integer ) )
		CU_ASSERT( sizeof(  gdyn(ubound( x.fix )) ) = sizeof( integer ) )
		CU_ASSERT( sizeof( x.fix(ubound(  gfix )) ) = sizeof( integer ) )
		CU_ASSERT( sizeof( x.fix(ubound(  gdyn )) ) = sizeof( integer ) )
		CU_ASSERT( sizeof( x.fix(ubound( x.fix )) ) = sizeof( integer ) )
	END_TEST

END_SUITE

