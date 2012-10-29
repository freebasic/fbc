' TEST_MODE : COMPILE_ONLY_FAIL

type T as FWDREF

dim a as T ptr
delete a

type FWDREF
	a as integer
end type
