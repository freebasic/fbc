' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
    a : 1 as integer
    b : 1 as integer
end type

dim shared x as UDT = (1, 1)
