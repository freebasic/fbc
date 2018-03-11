# include "fbcunit.bi"

SUITE( fbc_tests.functions.odd_arg )

	dim shared as integer fbytecalls

	sub fbyte _
		( _
			byval pre as uinteger, _
			byval a as byte, _
			byval post as uinteger _
		)
		CU_ASSERT( pre = &hAABBAABB )
		CU_ASSERT( post = &hCCDDCCDD )
		fbytecalls += 1
		CU_ASSERT( a = 15 )
	end sub

	'' BYTE parameters
	TEST( byteParam )
		dim as uinteger pre = &hAABBAABB
		dim as uinteger post = &hCCDDCCDD

		CU_ASSERT( fbytecalls = 0 )

		fbyte( pre, 15, post )
		CU_ASSERT( fbytecalls = 1 )

		scope
			dim as byte a = 15
			fbyte( pre, a, post )
			CU_ASSERT( fbytecalls = 2 )
		end scope

		scope
			dim as byte ptr p = callocate( 1 )
			*p = 15
			fbyte( pre, *p, post )
			CU_ASSERT( fbytecalls = 3 )
			deallocate( p )
		end scope

		scope
			dim as byte ptr p = callocate( 1 )
			dim as integer i = 0
			p[i] = 15
			fbyte( pre, p[i], post )
			CU_ASSERT( fbytecalls = 4 )
			deallocate( p )
		end scope

		scope
			dim as byte ptr p = callocate( 3 )
			dim as integer i = 2
			p[2] = 15
			fbyte( pre, p[i], post )
			CU_ASSERT( fbytecalls = 5 )
			deallocate( p )
		end scope

		scope
			dim as byte a(0 to 0)
			dim as integer i = 0
			a(0) = 15
			fbyte( pre, a(0), post )
			CU_ASSERT( fbytecalls = 6 )
		end scope

		scope
			dim as byte a(0 to 0)
			dim as integer i = 0
			a(0) = 15
			fbyte( pre, a(i), post )
			CU_ASSERT( fbytecalls = 7 )
		end scope

		scope
			dim as byte a(0 to 2)
			dim as integer i = 2
			a(2) = 15
			fbyte( pre, a(i), post )
			CU_ASSERT( fbytecalls = 8 )
		end scope
	END_TEST

	dim shared as integer fshortcalls

	sub fshort _
		( _
			byval pre as uinteger, _
			byval a as short, _
			byval post as uinteger _
		)
		CU_ASSERT( pre = &hAABBAABB )
		CU_ASSERT( post = &hCCDDCCDD )
		fshortcalls += 1
		CU_ASSERT( a = 15 )
	end sub

	'' BYTE parameters
	TEST( shortParam )
		dim as uinteger pre = &hAABBAABB
		dim as uinteger post = &hCCDDCCDD

		CU_ASSERT( fshortcalls = 0 )

		fshort( pre, 15, post )
		CU_ASSERT( fshortcalls = 1 )

		scope
			dim as short a = 15
			fshort( pre, a, post )
			CU_ASSERT( fshortcalls = 2 )
		end scope

		scope
			dim as short ptr p = callocate( 2 )
			*p = 15
			fshort( pre, *p, post )
			CU_ASSERT( fshortcalls = 3 )
			deallocate( p )
		end scope

		scope
			dim as short ptr p = callocate( 2 )
			dim as integer i = 0
			p[i] = 15
			fshort( pre, p[i], post )
			CU_ASSERT( fshortcalls = 4 )
			deallocate( p )
		end scope

		scope
			dim as short ptr p = callocate( 2 * 3 )
			dim as integer i = 2
			p[2] = 15
			fshort( pre, p[i], post )
			CU_ASSERT( fshortcalls = 5 )
			deallocate( p )
		end scope

		scope
			dim as short a(0 to 0)
			dim as integer i = 0
			a(0) = 15
			fshort( pre, a(0), post )
			CU_ASSERT( fshortcalls = 6 )
		end scope

		scope
			dim as short a(0 to 0)
			dim as integer i = 0
			a(0) = 15
			fshort( pre, a(i), post )
			CU_ASSERT( fshortcalls = 7 )
		end scope

		scope
			dim as short a(0 to 2)
			dim as integer i = 2
			a(2) = 15
			fshort( pre, a(i), post )
			CU_ASSERT( fshortcalls = 8 )
		end scope
	END_TEST

	#macro build( N )
		type UDT##N field = 1
			a(0 to (N)-1) as byte
		end type

		sub fudt##N _
			( _
				byval pre as uinteger, _
				byval x as UDT##N, _
				byval post as uinteger _
			)

			CU_ASSERT( pre = &hAABBAABB )
			CU_ASSERT( post = &hCCDDCCDD )

			for i as integer = 0 to (N)-1
				CU_ASSERT( x.a(i) = i + 1 )
			next

		end sub
	#endmacro

	build( 1 )
	build( 2 )
	build( 3 )
	build( 4 )
	build( 5 )
	build( 6 )
	build( 7 )
	build( 8 )

	'' odd-sized UDT parameters
	TEST( oddSizedUdtParam )
		dim as integer pre = &hAABBAABB
		dim as integer post = &hCCDDCCDD

		'' Testing pushing of various UDTs with weird sizes like
		'' sizeof( UDT ) = 3 etc., where the ASM backend has to take care
		'' to not access more memory than it should...

		#macro test_params( N )
			CU_ASSERT( sizeof( UDT##N ) = N )

			dim as UDT##N x##N
			for i as integer = 0 to (N)-1
				x##N.a(i) = i + 1
			next
			fudt##N( pre, x##N, post )

			dim as UDT##N ptr p##N = callocate( sizeof( UDT##N ) )
			for i as integer = 0 to (N)-1
				p##N->a(i) = i + 1
			next
			fudt##N( pre, *p##N, post )
			deallocate( p##N )

			dim as UDT##N array##N(0 to 7)
			for j as integer = 0 to 7
				for i as integer = 0 to (N)-1
					array##N(j).a(i) = i + 1
				next
				fudt##N( pre, array##N(j), post )
			next

			dim as UDT##N ptr parray##N = callocate( sizeof( UDT##N ) * 8 )
			for j as integer = 0 to 7
				for i as integer = 0 to (N)-1
					parray##N[j].a(i) = i + 1
				next
				fudt##N( pre, parray##N[j], post )
			next
			deallocate( parray##N )
		#endmacro

		test_params( 1 )
		test_params( 2 )
		test_params( 3 )
		test_params( 4 )
		test_params( 5 )
		test_params( 6 )
		test_params( 7 )
		test_params( 8 )
	END_TEST

END_SUITE
