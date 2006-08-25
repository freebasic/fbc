# include "fbcu.bi"

const TEST_VAL = 1234

private function dupfunc( ) as integer
	function = 0
end function 

type duptype field=1
	a as byte
end type

namespace fbc_tests.ns.dups.type_ns
	'' dup should be allowed, different ns'
	type duptype
		a as integer
	end type
end namespace

namespace fbc_tests.ns.dups.outer
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
	using fbc_tests.ns.dups.outer

'' defining a prototyped function outside the original ns (as in C++)
private function fbc_tests.ns.dups.outer.inner.dupfunc( ) as integer
	function = dupvar.a
end function

'' creating more ns symbols (as in C++)
namespace fbc_tests.ns.dups.outer
	namespace inner
	
		sub resetvar( )
			dupvar.a = 0
	
			'' because the "using type_ns", the global "duptype" shouldn't be accessed
			CU_ASSERT( len( duptype ) = len( integer ) )
		end sub
	
	end namespace
end namespace

	'' defining an extern outside the orignal ns (as in C++)
	dim fbc_tests.ns.dups.outer.dupvar as fbc_tests.ns.dups.outer.duptype = ( TEST_VAL )

private sub test cdecl 	

	scope 
   		'' see the "using outer" above
   		using inner

   		'' calling the dup function defined in global ns
   		CU_ASSERT( dupfunc( ) = 0 )
   		
   		CU_ASSERT( fbc_tests.ns.dups.outer.inner.dupfunc( ) = TEST_VAL )

   		'' outer.inner
   		resetvar
   		
   		CU_ASSERT( fbc_tests.ns.dups.outer.inner.dupfunc( ) = 0 )
	end scope

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.namespace.dups")
	fbcu.add_test("test 1", @test)
	
end sub
