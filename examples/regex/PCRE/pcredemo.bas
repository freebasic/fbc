''
'' PCRE example, translated by jofers (spam[at]betterwebber.com)
''

#include once "pcre.bi"

dim OVECCOUNT as const uinteger = 30    '' should be a multiple of 3

	dim as pcre ptr re 
	dim as zstring ptr error_ 
	dim as integer erroffset 
	dim as integer ovector(OVECCOUNT-1) 
	dim as integer rc, i 
	
	dim as string pattern, buffer
	
	pattern = "[a-zA-Z_][a-zA-Z_0-9]*"
	buffer = "foo _bar 123 foo123 BAR 456 !!! Foo__ ???"
	
	'' compile the regular expression
	re = pcre_compile( pattern,   		_ ''   the pattern 
					   0,               _ ''   default options 
					   @error_,         _ ''   for error message 
					   @erroffset,      _ ''   for error offset 
					   NULL )           _ ''   use default character tables 
	
	'' compilation failed: print the error message and exit 
	if re = NULL then 
		print "pcre compilation failed at offset "; str(erroffset); ": "; *error_ 
		end 
	end if 
	
	'' compilation succeeded: match the subject
	rc = pcre_exec( re,                 _ '' the compiled pattern 
					NULL,               _ '' no extra data - we didn't study the pattern 
					buffer,        		_ '' the subject string 
					len( buffer ),      _ '' the length of the subject 
					0,                  _ '' start at offset 0 in the subject 
					0,                  _ '' default options 
					@ovector(0),        _ '' output vector for substring information 
					OVECCOUNT )         _ '' number of elements in the output vector 
	
	'' matching failed: handle error cases 
	if rc < 0 then 
	    select case rc 
	    case pcre_error_nomatch
	        print "no match" 
	    'handle other special cases if you like 
	    case else
	    	print "matching error"; rc
	    end select 
	    end 
	end if 
	
	'' match succeded 
	print "match succeeded" 
	
	print "rc = " & rc
	
	'' the output vector wasn't big enough 
	if rc = 0 then 
		rc = OVECCOUNT \ 3
		print "ovector only has room for"; rc-1; " captured substrings" 
	end if 
	
	'' show substrings stored in the output vector 
	dim as zstring ptr substring_start  
	dim as integer substring_length
	for i = 0 to rc-1
	    substring_start = @buffer[ovector(2*i)]
	    substring_length = ovector(2*i+1) - ovector(2*i) 
	    print i; ": "; mid(buffer, ovector(2*i)+1, substring_length) 
	next
	
	end 

