#include once "fbcunit.bi"

'' define namespace names to allow short names
'' in this source but avoid namespace collisions
'' in other sources

#define M iherit_type_4_M
#define N iherit_type_4_N

dim shared as zstring * 32 duplicate = "..duplicate"

namespace M
	dim as zstring * 32 duplicate = "M.duplicate"
end namespace

namespace N
	dim as zstring * 32 duplicate = "N.duplicate"
	type parent extends object
		dim as zstring * 32 duplicate = "N.parent.duplicate"
	end type
	type child extends parent
		declare sub proc()
	end type
end namespace

sub n.child.proc()
	using M
	CU_ASSERT_EQUAL( duplicate, "N.parent.duplicate" )
end sub

private sub module_proc
	dim as N.child c
	c.proc()
end sub

SUITE( fbc_tests.structs.inherit_type_4 )
	TEST( default )
		module_proc()
	END_TEST
END_SUITE
