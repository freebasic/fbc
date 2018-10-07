
' TEST_MODE : COMPILE_ONLY_OK

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

Sub test_3 Cdecl ()
' /'
#define pass
''/
#ifndef pass
#error #define should have been parsed
#endif
End Sub

Sub test_4 Cdecl ()
'' /'
#define pass
''/
#ifndef pass
#error #define should have been parsed
#endif

End Sub

sub proc /' no alias '/ ( byval bar as zstring ptr /' const '/ = 0, _
						 byref baz as integer /' in-out '/ = 0 ) /' void '/

  ASSERT( bar = 0 /' this comment wouldn't appear in ASSERT '/ )

end sub

proc

/'

	multiline comments never check for '$' directives, 
	so suffixes should never matter
	
	${f!
	$=f# 
	$^f$
	$-f%
	$@f&
	
	'${f!
	'$=f# 
	'$^f$
	'$-f%
	'$@f&
	
	$include 'does_not_matter'
	$include "does_not_matter"

'/
