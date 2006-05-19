option explicit

const TEST_VAL = 1234

function dupfunc( ) as integer
	function = 0
end function 

type duptype field=1
	a as byte
end type

namespace type_ns
	'' dup should be allowed, different ns'
	type duptype
		a as integer
	end type
end namespace

namespace outer
	'' dup should be allowed, diff ns'
	function dupfunc( ) as integer
		function = 0
	end function
	
	'' import a ns
	using type_ns

	'' just proto
	extern dupvar as duptype

	namespace inner

		'' just a prototype
		declare function dupfunc( ) as integer
		
	end namespace

end namespace

	'' a dup var declared in the global ns
	dim dupvar as integer = 0

	''
	using outer

'' defining a prototyped function outside the original ns (as in C++)
function outer.inner.dupfunc( ) as integer
	function = dupvar.a
end function

'' creating more ns symbols (as in C++)
namespace outer
	namespace inner
	
		sub resetvar( )
			dupvar.a = 0
	
			'' because the "using type_ns", the global "duptype" shouldn't be accessed
			assert( len( duptype ) = len( integer ) )
		end sub
	
	end namespace
end namespace

	'' defining an extern outside the orignal ns (as in C++)
	dim outer.dupvar as outer.duptype = ( TEST_VAL )

	scope 
   		'' see the "using outer" above
   		using inner

   		'' calling the dup function defined in global ns
   		assert( dupfunc( ) = 0 )
   		
   		assert( outer.inner.dupfunc( ) = TEST_VAL )

   		'' outer.inner
   		resetvar
   		
   		assert( outer.inner.dupfunc( ) = 0 )
	end scope

