' TEST_MODE : COMPILE_ONLY_FAIL

dim as wstring * 10 w = wstr( "a" )

'' Jumping over SELECT CASE's temp wstring var's initialization would break
'' the implicit clean up code at scope end/breaks of SELECT CASE's implicit
'' outer scope.
goto label1:

select case( lcase( w ) )
case wstr( "a" )
	label1:
end select
