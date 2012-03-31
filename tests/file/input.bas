# include "fbcu.bi"

namespace fbc_tests.file.inputTests



const filename = ".\file\input.csv"

	dim shared as string g_field1(1 to 3)
	dim shared as double g_field2(1 to 3), g_field3(1 to 3), g_field4(1 to 3), g_field5(1 to 3)

sub integerTest cdecl ()
	dim as string field1(1 to 3)
	dim as integer field2(1 to 3), field3(1 to 3), field4(1 to 3), field5(1 to 3)
	dim as integer i

	open filename for input as #1 

	for i = 1 to 3 
   		input #1, field1(i), field2(i), field3(i), field4(i), field5(i)
   		CU_ASSERT_EQUAL( field1(i), g_field1(i) )
   		CU_ASSERT_EQUAL( field2(i), cint( g_field2(i) ) )
   		CU_ASSERT_EQUAL( field3(i), cint( g_field3(i) ) )
   		CU_ASSERT_EQUAL( field4(i), cint( g_field4(i) ) )
   		CU_ASSERT_EQUAL( field5(i), cint( g_field5(i) ) )
	next 

	close #1
	
end sub

sub doubleTest cdecl ()
	dim as string field1(1 to 3)
	dim as double field2(1 to 3), field3(1 to 3), field4(1 to 3), field5(1 to 3)
	dim as integer i

	open filename for input as #1 

	for i = 1 to 3 
   		input #1, field1(i), field2(i), field3(i), field4(i), field5(i)
   		CU_ASSERT_EQUAL( field1(i), g_field1(i) )
   		CU_ASSERT_EQUAL( field2(i), g_field2(i) )
   		CU_ASSERT_EQUAL( field3(i), g_field3(i) )
   		CU_ASSERT_EQUAL( field4(i), g_field4(i) )
   		CU_ASSERT_EQUAL( field5(i), g_field5(i) )
	next 

	close #1
	
end sub

sub load_data
end sub
   	
'// TODO: error checking
private function init cdecl () as integer
	open filename for input as #1 
	dim as integer i

	for i = 1 to 3 
		input #1, g_field1(i), g_field2(i), g_field3(i), g_field4(i), g_field5(i)
	next

	close #1
	
	return 0
end function

sub fixlenZstring cdecl( )
	dim as zstring * 32 z

	if( open( "file/2bytes.txt", for input, as #1 ) ) then
		CU_FAIL( )
	end if

	input #1, z

	close #1

	CU_ASSERT( z = "bb" )
end sub

sub fixlenWstring cdecl( )
	dim as wstring * 32 w

	if( open( "file/2bytes.txt", for input, as #1 ) ) then
		CU_FAIL( )
	end if

	input #1, w

	close #1

	CU_ASSERT( w = wstr( "bb" ) )
end sub

sub derefZstring cdecl( )
	dim as zstring * 32 z
	dim as zstring ptr pz = @z

	if( open( "file/2bytes.txt", for input, as #1 ) ) then
		CU_FAIL( )
	end if

	'' Note: this is dangerous, since the buffer length isn't being checked
	'' and will be overflown if the data in the file is long enough.
	input #1, *pz

	close #1

	CU_ASSERT( z = "bb" )
end sub

sub derefWstring cdecl( )
	dim as wstring * 32 w
	dim as wstring ptr pw = @w

	if( open( "file/2bytes.txt", for input, as #1 ) ) then
		CU_FAIL( )
	end if

	'' Note: this is dangerous, since the buffer length isn't being checked
	'' and will be overflown if the data in the file is long enough.
	input #1, *pw

	close #1

	CU_ASSERT( w = wstr( "bb" ) )
end sub

sub wstringOverflow cdecl( )
	type T field = 1
		as wstring * 2 w
		as integer i
	end type

	dim as T x
	x.w = wstr( "a" )
	x.i = -1

	CU_ASSERT( x.i = -1 )

	if( open( "file/2bytes.txt", for input, as #1 ) ) then
		CU_FAIL( )
	end if
	input #1, x.w
	close #1

	CU_ASSERT( x.w = wstr( "b" ) )
	CU_ASSERT( x.i = -1 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.file.input", @init )
	fbcu.add_test( "integerTest", @integerTest )
	fbcu.add_test( "doubleTest", @doubleTest )
	fbcu.add_test( "Input to user-allocated zstring", @derefZstring )
	fbcu.add_test( "Input to user-allocated wstring", @derefWstring )
	fbcu.add_test( "Input to fixed-length zstring", @fixlenZstring )
	fbcu.add_test( "Input to fixed-length wstring", @fixlenWstring )
	fbcu.add_test( "wstring buffer overflow regression test", @wstringOverflow )
end sub

end namespace
