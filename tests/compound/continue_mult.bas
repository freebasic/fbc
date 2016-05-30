# include "fbcu.bi"

namespace fbc_tests.compound.continue_mult

sub test_for cdecl
	dim as integer cnt = 0
	
	for i as integer = 1 to 1
		for j as integer = 1 to 1
			cnt += 1
			continue for, for
			cnt += 1
		next
		cnt += 1
	next
	
	CU_ASSERT_EQUAL( cnt, 1 )
end sub

sub test_do cdecl
	dim as integer cnt = 0
	
	do while cnt = 0
		do while cnt = 0
			cnt += 1
			continue do, do
			cnt += 1
		loop
		cnt += 1
	loop 
	
	CU_ASSERT_EQUAL( cnt, 1 )
end sub

sub test_while cdecl
	dim as integer cnt = 0
	
	while cnt = 0
		while cnt = 0
			cnt += 1
			continue while, while
			cnt += 1
		wend
		cnt += 1
	wend
	
	CU_ASSERT_EQUAL( cnt, 1 )
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.compound.continue_mult")
	fbcu.add_test("for", @test_for)
	fbcu.add_test("do", @test_do)
	fbcu.add_test("while", @test_while)

end sub

end namespace
