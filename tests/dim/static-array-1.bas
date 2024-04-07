' TEST_MODE : COMPILE_ONLY_OK

'' related bug https://sourceforge.net/p/fbc/bugs/944/
'' regression test - reverted some changes by #944 fix

/'
fbc       gas32    gas64    gcc32    gcc64
-------  -------  -------  -------  -------
1.10.1     ok       ok       ok       ok
1.10.0     ok       ok       ok       ok
1.09.0     ok       ok      fail     fail
1.08.1     ok       ok       ok       ok
1.07.3     ok       ok       ok       ok
1.06.0     ok       n/a      ok       ok
1.05.0     ok       n/a      ok       ok
'/

function bar( a as long ) as long
	return( 1 )
end function

function baz( a as long ) as long
	return( 2 )
end function

sub foo()
	static as function( as long ) as long f( ... ) = { @bar, @baz }
end sub
