' TEST_MODE : COMPILE_ONLY_FAIL

dim shared Bad_Result as integer = 0

type BadUnionType
	union
		x as integer
		y as double
	end union
end type

sub BadUnion( byval bu as BadUnionType )
    Bad_Result = 1
end sub

dim as BadUnionType bu
bu.y = 2.4

Dim t1 As Any Ptr
t1 = threadcall BadUnion( bu )
threadwait t1
