''
'' regular expression example
''

option explicit

'$include: "regex.bi"

function get_filepart( buffer as string, byval index as integer ) as string
    dim re as regex_t
    dim pm as regmatch_t
    dim pbuff as zstring ptr
    dim res as integer
    dim nsub as integer
    
	pbuff = strptr( buffer )
	
	'' compile the pattern
	regcomp( @re, "^(.*/)*([^/]*)\.([^.]*)$", REG_EXTENDED or REG_ICASE )

    nsub = re.re_nsub + 1
    redim match(1 to nsub) as regmatch_t
	
	'' first match
	res = regexec( @re, pbuff, nsub, @match(1), 0 )
	if ( res = 0 ) then

'        dim i as integer
'        for i=1 to nsub
'            print mid$( *pbuff, 1 + match(i).rm_so, match(i).rm_eo - match(i).rm_so )
'        next
    	function = mid$( *pbuff, 1 + match(index).rm_so, match(index).rm_eo - match(index).rm_so )
    	
    end if
    
end function

function get_filepath( buffer as string ) as string
	function = get_filepart( buffer, 2 )
end function

function get_filebase( buffer as string ) as string
	function = get_filepart( buffer, 3 )
end function

function get_fileext( buffer as string ) as string
	function = get_filepart( buffer, 4 )
end function

print "lib/win32/def/bass.dll.def"
print get_filepath("lib/win32/def/bass.dll.def")
print get_filebase("lib/win32/def/bass.dll.def")
print get_fileext("lib/win32/def/bass.dll.def")

print "lib/win32/def/winapi/advapi32.dll.def"
print get_filepath("lib/win32/def/winapi/advapi32.dll.def")
print get_filebase("lib/win32/def/winapi/advapi32.dll.def")
print get_fileext("lib/win32/def/winapi/advapi32.dll.def")
