''
'' regular expression example
''

option explicit

'$include: "regex.bi"

declare sub printmatches( pattern as string, buffer as string )

		
	printmatches( "[a-zA-Z_][a-zA-Z_0-9]*", "foo _bar 123 foo123 BAR 456 !!! Foo__ ???" )

	
'':::::
sub printmatches( pattern as string, buffer as string )
	dim re as regex_t
	dim pm as regmatch_t
	dim pbuff as byte ptr
	dim res as integer
	
	pbuff = strptr( buffer )
	
	'' compile the pattern
	regcomp( @re, pattern, 0 )
	
	'' first match
	res = regexec( @re, pbuff, 1, @pm, 0 )
	do while( res = 0 )
    	
    	print "<"; mid$( buffer, 1 + (pbuff - strptr( buffer )) + pm.rm_so, pm.rm_eo - pm.rm_so ); ">"
    	
    	'' next match
    	pbuff = pbuff + pm.rm_eo
    	res = regexec( @re, pbuff, 1, @pm, REG_NOTBOL )

    loop
    
    '' free the context
    regfree( @re )
    
end sub