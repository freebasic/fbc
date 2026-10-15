# include "fbcunit.bi"

'' SCREENLIST keeps its enumeration cursor in thread-local storage, so a
'' thread running its own enumeration must not disturb another thread's.
''
'' The runtime only has real thread-local storage when built with -mt, which
'' is how the unit tests are compiled (except on DOS). Without -mt the state
'' is process-global, so the check is skipped there.

SUITE( fbc_tests.gfx.screenlist_threads )

	const DEPTH = 32
	const MAXMODES = 256

	type MODELIST
		count as integer
		modes(0 to MAXMODES-1) as long
	end type

	sub enumerate( byval lst as MODELIST ptr )
		dim as long m = screenlist( DEPTH )
		lst->count = 0
		while( (m <> 0) andalso (lst->count < MAXMODES) )
			lst->modes(lst->count) = m
			lst->count += 1
			m = screenlist( )
		wend
	end sub

	sub threadproc( byval param as any ptr )
		enumerate( cptr( MODELIST ptr, param ) )
	end sub

	TEST( otherThreadDoesNotResetCursor )
	#ifdef __FB_MT__
		dim as MODELIST mainlist, threadlist

		'' Full enumeration on the main thread, used as reference
		enumerate( @mainlist )

		'' Nothing to check if no driver reports modes (e.g. headless CI)
		if( mainlist.count < 2 ) then
			CU_PASS( "fewer than two modes available, nothing to test" )
		else
			'' Start a new enumeration here and consume the first entry only
			dim as long first = screenlist( DEPTH )
			CU_ASSERT_EQUAL( first, mainlist.modes(0) )

			'' Let another thread run a complete enumeration of its own
			dim as any ptr t = threadcreate( @threadproc, @threadlist )
			CU_ASSERT_NOT_EQUAL( t, 0 )
			if( t <> 0 ) then
				threadwait( t )
			end if

			'' It must have seen the same list
			CU_ASSERT_EQUAL( threadlist.count, mainlist.count )
			for i as integer = 0 to mainlist.count - 1
				CU_ASSERT_EQUAL( threadlist.modes(i), mainlist.modes(i) )
			next

			'' and the main thread's cursor must still be on the second entry
			dim as long second = screenlist( )
			CU_ASSERT_EQUAL( second, mainlist.modes(1) )
		end if
	#else
		CU_PASS( "requires -mt" )
	#endif
	END_TEST

END_SUITE
