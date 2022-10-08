#macro t ? ( n, stmt... )
#print stmt
stmt
#if( n = 0 )
#print OK
#endif
#endmacro

'' ------------------------------------
'' check that field type is not also parent type

namespace n1
type T1
	__ as integer
	type T2
		t( 1, member1 as T1 )
		t( 1, as T1 member2 )
	end type
end type
end namespace
