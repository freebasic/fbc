#include once "fbcunit.bi"

'' define namespace names to allow short names
'' in this source but avoid namespace collisions
'' in other sources

#define M iherit_type_5_M
#define N iherit_type_5_N

dim shared as zstring * 32 duplicate = "..duplicate"

namespace M
	dim as zstring * 32 duplicate = "M.duplicate"
end namespace

namespace N
	type parent extends object
		declare sub proc()
	end type
	type child extends parent
		declare sub proc()
	end type
end namespace

sub N.parent.proc()
	using M
	CU_ASSERT_EQUAL( duplicate, "..duplicate" )
end sub

sub N.child.proc()
	using M
	CU_ASSERT_EQUAL( duplicate, "..duplicate" )
end sub

private sub module_proc
	dim as n.child c
	c.proc()
	cast(n.parent,c).proc()
end sub

SUITE( fbc_tests.structs.inherit_type_5 )
	TEST( default )
		module_proc()
	END_TEST
END_SUITE
