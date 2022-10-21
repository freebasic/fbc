' TEST_MODE : COMPILE_ONLY_OK

'' related bug https://sourceforge.net/p/fbc/bugs/944/
'' regression test - reverted some changes by #944 fix

	function bar( a as long ) as long
		return( 1 )
	end function

	function baz( a as long ) as long
		return( 2 )
	end function

	sub foo()
		static as function( as long ) as long f( ... ) = { @bar, @baz }
	end sub
