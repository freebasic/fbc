' TEST_MODE : COMPILE_ONLY_FAIL

dim as string s

'' Same but with an extra outer scope
goto label1:

scope
	select case( s + "1" )
	case "1"
		label1:
	end select
end scope
