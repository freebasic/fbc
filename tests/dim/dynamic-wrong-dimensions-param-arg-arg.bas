' TEST_MODE : COMPILE_ONLY_OK

'' '()' params shouldn't do dimension count checking at compile-time
'' (so e.g. rtlib functions like lbound() can keep working)

sub f( array() as integer )
end sub

dim array1(any) as integer
dim array2(any, any) as integer
f( array1() )
f( array2() )
