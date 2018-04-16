#include "fbcunit.bi"

#define min1(a,b) iif(a <= b, a, b)
#define min2(a,b,c) iif(a <= b, min1(a,c), min1(b,c))
#define min3(a,b,c,d) iif(a <= b, min2(a,c,d), min2(b,c,d))
#define min4(a,b,c,d,e) iif(a <= b, min3(a,c,d,e), min3(b,c,d,e))
#define min5(a,b,c,d,e,f) iif(a <= b, min4(a,c,d,e,f), min4(b,c,d,e,f))
#define min6(a,b,c,d,e,f,g) iif(a <= b, min5(a,c,d,e,f,g), min5(b,c,d,e,f,g))
#define min7(a,b,c,d,e,f,g,h) iif(a <= b, min6(a,c,d,e,f,g,h), min6(b,c,d,e,f,g,h))
#define min8(a,b,c,d,e,f,g,h,i) iif(a <= b, min7(a,c,d,e,f,g,h,i), min7(b,c,d,e,f,g,h,i))
#define min9(a,b,c,d,e,f,g,h,i,j) iif(a <= b, min8(a,c,d,e,f,g,h,i,j), min8(b,c,d,e,f,g,h,i,j))
#define minA(a,b,c,d,e,f,g,h,i,j,k) iif(a <= b, min9(a,c,d,e,f,g,h,i,j,k), min9(b,c,d,e,f,g,h,i,j,k))

SUITE( fbc_tests.pp.min )

	TEST( all )

		dim res as integer = minA(9,8,7,6,5,4,3,2,1,0,-1)
		
		CU_ASSERT_EQUAL( res, -1 )

	END_TEST

END_SUITE
