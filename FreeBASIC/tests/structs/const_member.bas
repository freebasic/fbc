' TEST_MODE : COMPILE_ONLY_FAIL

type foo
	
	__ as integer
	
end type

dim as const foo baz2 = (3)
baz2.__ = 4

