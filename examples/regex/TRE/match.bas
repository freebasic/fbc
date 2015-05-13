''
'' regular expression example
''

#include "regex.bi"

sub printmatches( byval pattern as string, byval buffer as string )
	dim re as regex_t
	dim pm as regmatch_t
	dim pbuff as zstring ptr
	dim res as integer

	pbuff = strptr( buffer )

	'' compile the pattern
	regcomp( @re, pattern, 0 )

	'' first match
	res = regexec( @re, pbuff, 1, @pm, 0 )
	do while( res = 0 )
		print "<"; mid( *pbuff, 1 + pm.rm_so, pm.rm_eo - pm.rm_so ); ">"

		'' next match
		pbuff += pm.rm_eo
		res = regexec( @re, pbuff, 1, @pm, REG_NOTBOL )
	loop

	'' free the context
	regfree( @re )
end sub

printmatches( "[a-zA-Z_][a-zA-Z_0-9]*", "foo _bar 123 foo123 BAR 456 !!! Foo__ ???" )
sleep
