''
'' regular expression example
''

#include  "regex.bi"

enum eFilePartKind
	eFPK_Full
	eFPK_Path
	eFPK_File
	eFPK_Basename
	eFPK_Extension
end enum

function get_filepart( byref buffer as string, byval kind as eFilePartKind ) as string
	dim re as regex_t
	dim pm as regmatch_t
	dim pbuff as zstring ptr
	dim res as integer
	dim nsub as integer

	if len(buffer)=0 then exit function

	pbuff = strptr( buffer )

	'' compile the pattern
	if regcomp( @re, "^(.*/)*([^/.]*)(((\.[^.]*)*)(\.[^.]*))?", REG_EXTENDED or REG_ICASE )<>0 then
		exit function
	end if

	nsub = re.re_nsub + 1
	redim match(1 to nsub) as regmatch_t

	'' first match
	res = regexec( @re, pbuff, nsub, @match(1), 0 )
	if ( res = 0 ) then

		select case kind
		case eFPK_Full
			function = buffer
		case eFPK_Path
			function = mid( *pbuff, 1 + match(2).rm_so, match(2).rm_eo - match(2).rm_so )
		case eFPK_File
			function = mid( *pbuff, 1 + match(3).rm_so, match(3).rm_eo - match(3).rm_so ) + _
			           mid( *pbuff, 1 + match(4).rm_so, match(4).rm_eo - match(4).rm_so )
		case eFPK_Basename
			function = mid( *pbuff, 1 + match(3).rm_so, match(3).rm_eo - match(3).rm_so ) + _
			           mid( *pbuff, 1 + match(5).rm_so, match(5).rm_eo - match(5).rm_so )
		case eFPK_Extension
			function = mid( *pbuff, 1 + match(7).rm_so, match(7).rm_eo - match(7).rm_so )
		end select
	end if
end function

private sub ShowAll( byref s as string )
	print "Full:", s
	print "Path:", get_filepart(s, eFPK_Path)
	print "File:", get_filepart(s, eFPK_File)
	print "Base:", get_filepart(s, eFPK_Basename)
	print "Ext :", get_filepart(s, eFPK_Extension)
	print
end sub

ShowAll "path/name.ext"
ShowAll "path/name.ext1.ext2"
ShowAll "path/name.ext1.ext2.ext3"
ShowAll "path/name"
ShowAll "path/"
ShowAll "name.ext"
ShowAll "name.ext1.ext2"
ShowAll "name.ext1.ext2.ext3"
ShowAll "name"
ShowAll ".ext"
ShowAll ".ext1.ext2"
ShowAll ".ext1.ext2.ext3"
ShowAll ""
