# include "fbcu.bi"

namespace fbc_tests.structs.obj_property_dup

type foo
    '' set
    declare property bar ( v as integer )
    
    '' get, indexed
    declare property bar ( index as integer ) as integer
    
private:
	m_bar(0) as integer
end type

property foo.bar ( v as integer )
	m_bar(0) = v
end property

property foo.bar ( index as integer ) as integer
	property = m_bar(0)
end property

sub test_1 cdecl
	dim f as foo
	
	f.bar = 1234
	CU_ASSERT_EQUAL( f.bar(0), 1234 )

end sub
	
private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.obj_property_dup")
	fbcu.add_test( "#1", @test_1)

end sub
	
end namespace			