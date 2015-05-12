' TEST_MODE : COMPILE_ONLY_FAIL

type foo
	__ as integer
end type

dim as const foo kah = (0)
kah.__ = 69

