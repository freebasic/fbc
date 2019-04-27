#pragma once

#macro CU_ASSERT_WSTRING_EQUAL( u, w )

	'' length check
	CU_ASSERT( len(u) = len(w) )

	'' comparison check
	CU_ASSERT_EQUAL(u, w)

	'' byte-by-byte check
	scope
		if(len(u) = len(w)) then
			do
				for i as integer = 0 to len(u) - 1
					if(u[i] <> w[i]) then
						CU_FAIL()
						exit do
					end if
				next
				CU_PASS()
			loop until true
		end if
	end scope

#endmacro
