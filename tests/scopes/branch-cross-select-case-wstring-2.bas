' TEST_MODE : COMPILE_ONLY_FAIL

dim as wstring * 10 w = wstr( "a" )

'' Same but with extra outer scope
goto label1:

scope
	select case( lcase( w ) )
	case wstr( "a" )
		label1:
	end select
end scope
