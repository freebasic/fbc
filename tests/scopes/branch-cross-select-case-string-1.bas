' TEST_MODE : COMPILE_ONLY_FAIL

dim as string s

'' Jumping over SELECT CASE's temp string var's initialization would break
'' the implicit clean up code at scope end/breaks of SELECT CASE's implicit
'' outer scope.
goto label1:

select case( s + "1" )
case "1"
	label1:
end select
