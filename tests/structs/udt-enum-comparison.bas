' TEST_MODE : COMPILE_ONLY_FAIL

enum e_
	e1
end enum

type t_
	as integer t1
end type

dim t as t_, e as e_

'' This should cause an error to be shown, but not trigger assertion failures
print (t = e1)
