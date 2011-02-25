# include once "fbcu.bi"




namespace fbc_tests.string_.mid_set

sub test_midset(byref s as const string, byref t as const string, byval n as integer, byval l as integer)

	dim as string s1, s2
	s1 = s: mid(s1, n, l) = t

	s2 = s
	for i as integer = 1 to l
		if i > len(t) orelse n > len(s2) then exit for

		mid(s2, n, 1) = mid(t, i, 1)

		n += 1
	next

	CU_ASSERT_EQUAL(s1, s2)

end sub

sub midSetTest cdecl ()

	dim h as string = "123"
	dim test as string * 3
	dim i as integer, l as integer
	dim s as string = "abcdefg", t as string = "12345"

	for i = 1 to 42
		for l = 0 to 42

			test_midset(s, t, i, l)

		next
	next

	for i = 1 to 260
	  mid(test,1) = h
	  CU_ASSERT_NOT_EQUAL( 0, len(str(i)) )
	next

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.mid_set")
	fbcu.add_test("midSetTest", @midSetTest)

end sub

end namespace
