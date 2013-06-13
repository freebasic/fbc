' TEST_MODE : COMPILE_ONLY_OK

'' Even though the two procptrs are equal, the symbols shouldn't internally be
'' re-used, because they're in completely different procedures.
'' Re-using local symbols from another procedure is not safe,
'' because they are deleted after the first procedure is emitted,
'' and it doesn't work with the C backend either.

'' -gen gcc regression test
sub subfoo1( )
	dim p1 as sub( )
end sub

sub subfoo2( )
	dim p2 as sub( )
end sub
