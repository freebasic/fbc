# include "fbcunit.bi"

SUITE( fbc_tests.functions.fwdref_in_signature )

	''
	'' C/LLVM backend compile-time test:
	''
	'' Some public (non-private) procedures, with forward references in their
	'' signatures, that aren't resolved until after the procedure bodies/calls.
	''
	'' This causes problems for the C/LLVM backends, because they can't emit the
	'' procedure body while the forward references are still unsolved. If they did
	'' that, they'd have to emit them as ANY PTRs but then there'd be type conflicts
	'' with calls to that procedure, or with the prototype that may be emitted
	'' later.
	''
	'' I.e. fbc needs to do some special work to compile this when using the C/LLVM
	'' backends, while it's easy with the ASM backend for which a pointers exact
	'' type doesn't matter.
	''

	type T as T_

	function f1( ) as T ptr
		function = 0
	end function

	sub f2( byval p as T ptr )
	end sub

	function f3( byval p as T ptr ) as T ptr
		function = 0
	end function

	sub f4( byval a as integer, byval b as T ptr, byval c as integer )
	end sub

	sub f5( byval p as sub( byval as T ptr ) )
	end sub

	function f6( ) as sub( byval as T ptr )
		function = 0
	end function

	function f7( ) as function( ) as T ptr
		function = 0
	end function

	TEST( allFuncTypes )
		f1( )
		f2( 0 )
		f3( 0 )
		f4( 0, 0, 0 )
		f5( 0 )
		f6( )
		f7( )
		CU_PASS( )
	END_TEST

	'' Only now resolving the forward reference, behind the bodies/calls
	type T_ as integer

END_SUITE
