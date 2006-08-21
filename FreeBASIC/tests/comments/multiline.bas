# include "fbcu.bi"




namespace fbc_tests.comments.multiline

sub test_1 cdecl ()
/'

#error this shouldn't be parsed

'/
end sub

sub test_2 cdecl ()
/'

	/'
		nested
	'/
	
#error this shouldn't be parsed
	
'/
end sub

sub proc /' no alias '/ ( byval bar as zstring ptr /' const '/ = 0, _
						 byref baz as integer /' in-out '/ = 0 ) /' void '/

	CU_ASSERT_EQUAL( bar, 0 /' this comment wouldn't appear in CU_ASSERT '/ )

end sub

sub ctor () constructor
end sub

end namespace
