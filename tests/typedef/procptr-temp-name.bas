' TEST_MODE : COMPILE_ONLY_OK

'' This should compile fine even under -gen gcc

namespace ns
	type a as function( ) as integer

	sub mythread( byval userdata as any ptr ) 
	end sub

	sub foo( )
		threadcreate( @mythread ) 
	end sub

	dim shared as sub( ) global
end namespace
