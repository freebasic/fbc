' TEST_MODE : COMPILE_ONLY_FAIL

type foo
	
	protected:
	__ as integer
	
end type

dim as const foo baz2 = (3)
dim as integer n

with baz2
	n = .__
end with

