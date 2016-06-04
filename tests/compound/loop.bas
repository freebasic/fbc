#include "fbcu.bi"

namespace fbc_tests.compound.loop_

sub testWhile cdecl( )
	dim as integer i

	i = 0
	while( i = 0 )
		i += 1
	wend
	CU_ASSERT( i = 1 )

	i = 0
	while( i = 5 )
		i += 1
	wend
	CU_ASSERT( i = 0 )

	i = 0
	while( i <> 5 )
		i += 1
	wend
	CU_ASSERT( i = 5 )

	i = 0
	while( i < 5 )
		i += 1
	wend
	CU_ASSERT( i = 5 )

	i = 0
	while( i <= 5 )
		i += 1
	wend
	CU_ASSERT( i = 6 )

	i = 5
	while( i > 0 )
		i -= 1
	wend
	CU_ASSERT( i = 0 )

	i = 5
	while( i >= 0 )
		i -= 1
	wend
	CU_ASSERT( i = -1 )
end sub

sub testDoWhile cdecl( )
	dim as integer i

	i = 0
	do while( i = 0 )
		i += 1
	loop
	CU_ASSERT( i = 1 )

	i = 0
	do while( i = 5 )
		i += 1
	loop
	CU_ASSERT( i = 0 )

	i = 0
	do while( i <> 5 )
		i += 1
	loop
	CU_ASSERT( i = 5 )

	i = 0
	do while( i < 5 )
		i += 1
	loop
	CU_ASSERT( i = 5 )

	i = 0
	do while( i <= 5 )
		i += 1
	loop
	CU_ASSERT( i = 6 )

	i = 5
	do while( i > 0 )
		i -= 1
	loop
	CU_ASSERT( i = 0 )

	i = 5
	do while( i >= 0 )
		i -= 1
	loop
	CU_ASSERT( i = -1 )
end sub

sub testLoopWhile cdecl( )
	dim as integer i

	i = 0
	do
		i += 1
	loop while( i = 0 )
	CU_ASSERT( i = 1 )

	i = 0
	do
		i += 1
	loop while( i = 5 )
	CU_ASSERT( i = 1 )

	i = 0
	do
		i += 1
	loop while( i <> 5 )
	CU_ASSERT( i = 5 )

	i = 0
	do
		i += 1
	loop while( i < 5 )
	CU_ASSERT( i = 5 )

	i = 0
	do
		i += 1
	loop while( i <= 5 )
	CU_ASSERT( i = 6 )

	i = 5
	do
		i -= 1
	loop while( i > 0 )
	CU_ASSERT( i = 0 )

	i = 5
	do
		i -= 1
	loop while( i >= 0 )
	CU_ASSERT( i = -1 )
end sub

sub testDoUntil cdecl( )
	dim as integer i

	i = 0
	do until( i = 0 )
		i += 1
	loop
	CU_ASSERT( i = 0 )

	i = 0
	do until( i = 5 )
		i += 1
	loop
	CU_ASSERT( i = 5 )

	i = 5
	do until( i <> 5 )
		i -= 1
	loop
	CU_ASSERT( i = 4 )

	i = 5
	do until( i < 5 )
		i -= 1
	loop
	CU_ASSERT( i = 4 )

	i = 5
	do until( i <= 5 )
		i -= 1
	loop
	CU_ASSERT( i = 5 )

	i = 0
	do until( i > 0 )
		i += 1
	loop
	CU_ASSERT( i = 1 )

	i = 0
	do until( i >= 0 )
		i += 1
	loop
	CU_ASSERT( i = 0 )
end sub

sub testLoopUntil cdecl( )
	dim as integer i

	i = 0
	do
		i += 1
	loop until( i = 1 )
	CU_ASSERT( i = 1 )

	i = 0
	do
		i += 1
	loop until( i = 5 )
	CU_ASSERT( i = 5 )

	i = 5
	do
		i -= 1
	loop until( i <> 5 )
	CU_ASSERT( i = 4 )

	i = 5
	do
		i -= 1
	loop until( i < 5 )
	CU_ASSERT( i = 4 )

	i = 5
	do
		i -= 1
	loop until( i <= 5 )
	CU_ASSERT( i = 4 )

	i = 0
	do
		i += 1
	loop until( i > 0 )
	CU_ASSERT( i = 1 )

	i = 0
	do
		i += 1
	loop until( i >= 0 )
	CU_ASSERT( i = 1 )
end sub

sub testContinueWhile cdecl( )
	dim as string s = ""
	dim as integer i = 0

	while i < 10
		if i = 5 then
			s = str(i)
			i += 1
			continue while
		end if
		i += 1
	wend

	CU_ASSERT_EQUAL( s, "5" )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.compound.loop" )
	fbcu.add_test( "while", @testWhile )
	fbcu.add_test( "do while", @testDoWhile )
	fbcu.add_test( "loop while", @testLoopWhile )
	fbcu.add_test( "do until", @testDoUntil )
	fbcu.add_test( "loop until", @testLoopUntil )
	fbcu.add_test( "continue while", @testContinueWhile )
end sub

end namespace
