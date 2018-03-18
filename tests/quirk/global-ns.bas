#include "fbcunit.bi"

SUITE( fbc_tests.quirk.global_ns )

	'' Only fb_* ids should be reserved. As long as BASIC mangling is used,
	'' __main becomes __MAIN, thus there is no collision with the real __main().
	''
	'' Only when using case-preserving mangling such as Extern "C" you have to be
	'' careful to not shadow any CRT/system symbols (at least the rtlib ones are
	'' prefixed with fb_*).

	sub __main( )
	end sub

	sub mcount( )
	end sub

	sub _monstartup( )
	end sub

	sub rename( )
	end sub

	sub __divdi3( )
	end sub

	sub __udivdi3( )
	end sub

	sub __moddi3( )
	end sub

	sub __umoddi3( )
	end sub

	sub __fixunsdfdi( )
	end sub

	TEST( compile )
		CU_PASS( )
	END_TEST

END_SUITE
