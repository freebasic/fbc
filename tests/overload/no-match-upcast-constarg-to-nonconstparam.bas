' TEST_MODE : COMPILE_ONLY_FAIL

type T1 extends object
end type

type T2 extends T1
end type

type T3 extends T2
end type

function a overload( byref x as T1 ) as integer : function = &h01 : end function
function a overload( byref x as T2 ) as integer : function = &h02 : end function

dim cx3 as const T3 = T3( )
a( cx3 )
