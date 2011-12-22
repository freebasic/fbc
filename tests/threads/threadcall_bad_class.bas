' TEST_MODE : COMPILE_ONLY_FAIL

dim shared Bad_Result as integer = 0

type BadClass
    declare static sub BadMember()
    x as integer
end type

sub BadClass.BadMember()
    Bad_Result = 1
end sub

dim as BadClass bc = Type( 42 )

Dim t1 As Any Ptr
t1 = threadcall  bc.BadMember( )
threadwait t1
