' TEST_MODE : COMPILE_ONLY_FAIL

type BitfieldUDT
    a:4 as integer
    b:4 as integer
end type

dim shared Bad_Result as integer = 0

sub BadBitField( byval bu as BitfieldUDT )
    if bu.a = 7 and bu.b = 2 then Bad_Result = 1
end sub

Dim t1 As Any Ptr
t1 = threadcall BadBitField( Type( 0, 0 ) )
threadwait t1
