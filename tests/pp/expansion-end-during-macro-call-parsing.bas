' TEST_MODE : COMPILE_ONLY_OK

#define A1

#macro A2(a,b,c,d)
	scope
		A1
		A1
	end scope
#endmacro

#macro test
	A2(,,,)
#endmacro

test

'' While parsing the call to "A2", we'll reach the end of the expansion text of
'' "test", causing us to reset the current macro status.
''
'' Since the current macro status can change while parsing a macro call, we have
'' to be careful to update it after expanding that macro, not before, otherwise
'' the reset while parsing the call would overwrite it.
