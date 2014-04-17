' TEST_MODE : COMPILE_ONLY_OK

'' Should be allowed for backwards compatibility, and also because () bydesc
'' parameters don't check the dimension count.

sub f( array() as integer )
	print array(0)
	print array(0, 0)
end sub
