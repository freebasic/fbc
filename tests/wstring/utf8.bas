#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.utf8 )

	#define hello "Καλημέρα "
	#define world "κόσμε!"
	#define helloworld hello + world
	
	TEST( default )
	
		dim as wstring * 32 hw1 = "Καλημέρα κόσμε!"
		dim as wstring * 32 hw2 = helloworld
	
		CU_ASSERT( hw1 = hw2 )
	
		CU_ASSERT( hw1 = helloworld )
	
		CU_ASSERT( helloworld = hw2 )
	
	END_TEST

END_SUITE
