#include "fbcunit.bi"

SUITE( fbc_tests.numbers.cast_nullptr )

	private sub f_b   ( byval i as byte     ) : end sub
	private sub f_sh  ( byval i as short    ) : end sub
	private sub f_l   ( byval i as long     ) : end sub
	private sub f_ll  ( byval i as longint  ) : end sub
	private sub f_i   ( byval i as integer  ) : end sub
	private sub f_ub  ( byval i as ubyte    ) : end sub
	private sub f_ush ( byval i as ushort   ) : end sub
	private sub f_ul  ( byval i as ulong    ) : end sub
	private sub f_ull ( byval i as ulongint ) : end sub
	private sub f_ui  ( byval i as uinteger ) : end sub

	TEST( all )
		dim p as any ptr
		p = 0l
		p = 0ul
		p = 0ll
		p = 0ull
		p = 0
		p = 0u
		p = cbyte   ( 0 )
		p = cshort  ( 0 )
		p = clng    ( 0 )
		p = clngint ( 0 )
		p = cint    ( 0 )
		p = cubyte  ( 0 )
		p = cushort ( 0 )
		p = culng   ( 0 )
		p = culngint( 0 )
		p = cuint   ( 0 )
		p = cptr( integer ptr, 0 )
		p = cptr( any ptr, 0 )

		dim b as byte
		dim sh as short
		dim l as long
		dim ll as longint
		dim i as integer
		dim ub as ubyte
		dim ush as ushort
		dim ul as ulong
		dim ull as ulongint
		dim ui as uinteger

		b   = cptr( any ptr, 0 )
		sh  = cptr( any ptr, 0 )
		l   = cptr( any ptr, 0 )
		ll  = cptr( any ptr, 0 )
		i   = cptr( any ptr, 0 )
		ub  = cptr( any ptr, 0 )
		ush = cptr( any ptr, 0 )
		ul  = cptr( any ptr, 0 )
		ull = cptr( any ptr, 0 )
		ui  = cptr( any ptr, 0 )

		b   = cptr( integer ptr, 0 )
		sh  = cptr( integer ptr, 0 )
		l   = cptr( integer ptr, 0 )
		ll  = cptr( integer ptr, 0 )
		i   = cptr( integer ptr, 0 )
		ub  = cptr( integer ptr, 0 )
		ush = cptr( integer ptr, 0 )
		ul  = cptr( integer ptr, 0 )
		ull = cptr( integer ptr, 0 )
		ui  = cptr( integer ptr, 0 )

		f_b  ( cptr( any ptr, 0 ) )
		f_sh ( cptr( any ptr, 0 ) )
		f_l  ( cptr( any ptr, 0 ) )
		f_ll ( cptr( any ptr, 0 ) )
		f_i  ( cptr( any ptr, 0 ) )
		f_ub ( cptr( any ptr, 0 ) )
		f_ush( cptr( any ptr, 0 ) )
		f_ul ( cptr( any ptr, 0 ) )
		f_ull( cptr( any ptr, 0 ) )
		f_ui ( cptr( any ptr, 0 ) )

		f_b  ( cptr( integer ptr, 0 ) )
		f_sh ( cptr( integer ptr, 0 ) )
		f_l  ( cptr( integer ptr, 0 ) )
		f_ll ( cptr( integer ptr, 0 ) )
		f_i  ( cptr( integer ptr, 0 ) )
		f_ub ( cptr( integer ptr, 0 ) )
		f_ush( cptr( integer ptr, 0 ) )
		f_ul ( cptr( integer ptr, 0 ) )
		f_ull( cptr( integer ptr, 0 ) )
		f_ui ( cptr( integer ptr, 0 ) )
	END_TEST

END_SUITE
