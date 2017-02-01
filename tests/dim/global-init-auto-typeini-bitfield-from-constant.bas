' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
    a : 1 as integer
    b : 1 as integer
end type

var shared x = type<UDT>(1, 1)
