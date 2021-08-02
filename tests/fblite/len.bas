' TEST_MODE : COMPILE_AND_RUN_OK

#lang "fblite"

type inner_t
	member as string
end type

type outer_t
	inner as inner_t
end type

sub test_scoped
	dim outer as outer_t
	outer.inner.member = "blarg"
	
	ASSERT( len( outer.inner.member ) = 5 )
	
	with outer
		ASSERT( len(.inner.member) = 5 )
	end with
	
	with outer.inner
		ASSERT( len(.member) = 5 )
	end with
	
	ASSERT( len(inner_t) = sizeof(string) )
	ASSERT( len(outer_t) = sizeof(string) )
	
	
	dim variable.string as string
	variable.string = "klonk"
	
	ASSERT( len(variable.string) = 5 )
	ASSERT( len(short) = 2 )
end sub

namespace NS
	type inner_t
		member as string
	end type
	
	type outer_t
		inner as inner_t
	end type

	dim shared outer as outer_t

	sub test_NS_implicit		
		outer.inner.member = "blarg"
		
		ASSERT( len( outer.inner.member ) = 5 )
		
		with outer
			ASSERT( len(.inner.member) = 5 )
		end with
		
		with outer.inner
			ASSERT( len(.member) = 5 )
		end with
		
		ASSERT( len(inner_t) = sizeof(string) )
		ASSERT( len(outer_t) = sizeof(string) )
	end sub
end namespace

sub test_NS_explicit
	NS.outer.inner.member = "blarg"
	
	ASSERT( len( NS.outer.inner.member ) = 5 )
	
	with NS.outer
		ASSERT( len(.inner.member) = 5 )
	end with
	
	with NS.outer.inner
		ASSERT( len(.member) = 5 )
	end with
	
	ASSERT( len(NS.inner_t) = sizeof(string) )
	ASSERT( len(NS.outer_t) = sizeof(string) )
end sub

test_scoped
NS.test_NS_implicit
test_NS_explicit
