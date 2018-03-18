#include "fbcunit.bi"

SUITE( fbc_tests.quirk.open_methods )

	type foo
		declare function binary() as integer
		declare function access() as integer
		declare function read() as integer
		declare function input() as integer
		declare function lock() as integer
		declare function output() as integer
		declare function write() as integer
		declare function random() as integer
		declare function append() as integer
		__ as integer
	end type
	
	function foo.binary() as integer
		function = 0
		if( Open(" ", for binary, access read, as 1 ) <> 0 ) then
		end if
		if( Open(" ", for input, lock read, as 1 ) <> 0 ) then
		end if
		if( Open(" ", for output, lock write, as 1 ) <> 0 ) then
		end if
		if( Open(" ", for random, lock write, as 1 ) <> 0 ) then
		end if
		if( Open(" ", for append, lock write, as 1 ) <> 0 ) then
		end if
	end function
    
	TEST( compile )
		CU_PASS()
	END_TEST
    
END_SUITE
