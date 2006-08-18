

const TEST_1 = wstr( "123" )
const TEST_2 = wstr( "456" )
const TEST_3 = wstr( "789" )

declare sub run_test( byval s1 as wstring ptr, byval s2 as wstring ptr )	

test_data:
data TEST_1, TEST_2, TEST_3	
data TEST_1, TEST_2, TEST_3	

sub test1	
	dim ws as wstring * 32
	dim i as integer

	restore test_data
	for i = 1 to 2		
		read ws
		run_test( ws, TEST_1 )

		read ws
		run_test( ws, TEST_2 )

		read ws
		run_test( ws, TEST_3 )
	next
end sub
	
sub test2	
	dim b as byte, s as short, i as integer, l as longint, f as single, d as double
	
	restore test_data
	
	read b
	assert( b = cbyte( TEST_1 ) )
	
	read s
	assert( s = cshort( TEST_2 ) )

	read i
	assert( i = cint( TEST_3 ) )

	read l
	assert( l = clngint( TEST_1 ) )

	read f
	assert( f = csng( TEST_2 ) )
	
	read d
	assert( d = cdbl( TEST_3 ) )
	
	
end sub	
	
sub run_test( byval s1 as wstring ptr, byval s2 as wstring ptr )	
	
	assert( len( *s1 ) = len( *s2 ) )
	
	assert( *s1 = *s2 )
	
end sub

	test1( )
	test2( ) 
	
