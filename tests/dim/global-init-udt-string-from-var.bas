' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
    s as string
end type

dim shared s as string
dim shared x as UDT = (s)
