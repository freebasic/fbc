' TEST_MODE : COMPILE_AND_RUN_OK

'' check that no dtors are added for
'' expressions that should be discarded
'' as in TYPEOF( expr... )

dim shared ctor_call as integer = 0
dim shared dtor_call as integer = 0

type t
	s as string
	declare constructor()
	declare destructor()
end type

constructor T()
	ctor_call += 1
end constructor

destructor T()
	dtor_call += 1
end destructor

function f() as T
	return type<T>
end function

dim x as T
assert( ctor_call = 1 )
assert( dtor_call = 0 )

#print typeof(T)
#print typeof(f())
#print typeof(f().s)
#print typeof(iif(true,x,f()).s)
#print typeof(iif(false,x,f()).s)

assert( ctor_call = 1 )
assert( dtor_call = 0 )
