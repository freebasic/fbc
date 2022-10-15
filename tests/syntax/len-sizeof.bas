#macro t ? ( n, stmt... )
#print stmt
stmt
#if( n = 0 )
#print OK
#endif
#endmacro

'' ------------------------------------

type TOuter
	a as byte
	type TInner
		a as short
	end type
	m as TInner
end type

dim n as integer
dim x as TOuter

t( 0, n = sizeof( TOuter ) )
t( 0, n = sizeof( TOuter.a ) )
t( 0, n = sizeof( TOuter.TInner ) )
t( 0, n = sizeof( TOuter.TInner.a ) )
t( 0, n = sizeof( x ) )
t( 0, n = sizeof( x.a ) )
t( 0, n = sizeof( x.m ) )
t( 0, n = sizeof( x.m.a ) )

t( 1, n = sizeof( x.TInner ) )
t( 1, n = sizeof( x.TInner.a ) )
