#pragma once

#macro CU_ASSERT_WSTRING_EQUAL( a, b )

	'' length check
	CU_ASSERT( len(a) = len(b) )

	'' comparison check
	CU_ASSERT_EQUAL(a, b)

	'' byte-by-byte check
	scope
		if(len(a) = len(b)) then
			do
				for i as integer = 0 to len(a) - 1
					if(a[i] <> b[i]) then
						CU_FAIL()
						exit do
					end if
				next
				CU_PASS()
			loop until true
		end if
	end scope

#endmacro
