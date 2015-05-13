' TEST_MODE : COMPILE_ONLY_FAIL

'' Only a default ctor should be implicitly added here,
'' no implicit Let overload, no copy ctor, no dtor.
type T
	as integer i = 0
	declare constructor( byval as integer )
end type

constructor T( byval i as integer )
end constructor

dim as T x = T( 0 )

'' An implicit T.Let( byref as T ) overload shouldn't exist,
'' it would allow this to work:
x = 0
