' TEST_MODE : COMPILE_ONLY_FAIL

type ArrayUDT
    a(0 to 1) as integer
end type

dim shared Bad_Result as integer = 0

sub BadArrayField( byval au as ArrayUDT )
    if au.a(0) = 5 and au.a(1) = 4 then Bad_Result = 1    
end sub

dim as ArrayUDT au = Type( {1, 2} )
Dim t1 As Any Ptr
t1 = threadcall BadArrayField( au )
threadwait t1
