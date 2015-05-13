' TEST_MODE : COMPILE_ONLY_OK

'' '()' params shouldn't do dimension count checking at compile-time
'' (so e.g. rtlib functions like lbound() can keep working)

declare sub f( array() as integer )

dim array1(any) as integer
f( array1() )

sub f( array() as integer )
	print array(0, 0)
end sub
