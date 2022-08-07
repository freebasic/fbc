''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008-2022 Jeffery R. Marshall (coder[at]execulink[dot]com)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.

'' replace.bas - replace text in wakka files

'' chng: written [jeffm]

'' fb headers
#include "file.bi"

'' fbdoc headers
#include "fbdoc_string.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"

using fb
using fbdoc

const def_index_file = hardcoded.default_index_file
const def_recent_file = hardcoded.default_recent_file

'' --------------------------------------------------------

'':::::
function xxReplaceSubStr _
	( _
		byval src as zstring ptr, _
		byval old as zstring ptr, _
		byval rep as zstring ptr _
	) as string 

	dim i as integer = 1, ret as string, b as integer
	ret = *src 
	do 
		b = 1

		i = instr(i, ret, *old) 
		if i = 0 then 
			exit do 
		end if

		if( i > 1 ) then
			select case mid(ret,i-1,1)
			case "A" to "Z", "a" to "z"
				b = 0
			end select
		end if

		if( i + len(*old) <= len(ret) ) then
			select case mid(ret,i+len(*old),1)
			case "A" to "Z", "a" to "z"
				b = 0
			end select
		end if

		if( b ) then
			ret = left(ret, i - 1) + *rep + mid(ret, i + len(*old)) 
			i += len(*rep) 
		else
			i += 1
		end if

	loop 
	return ret 
end function

''
sub loghtml( byref x as string, byval bNew as integer = FALSE )
	dim h as integer = freefile
	if( bNew ) then
		open "rename.html" for output as #h
	else
		open "rename.html" for append as #h
	end if

	print #h, x

	close #h
end sub


'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

'' private options
dim f as string
dim sComment as string
dim bNoSave as boolean = false
dim bHTML as boolean = false
dim bProcess as boolean = true
dim bUseRecent as boolean = false
dim index_file as string

index_file = def_index_file

'' enable cache
cmd_opts_init( CMD_OPTS_ENABLE_URL or CMD_OPTS_ENABLE_CACHE or CMD_OPTS_ENABLE_AUTOCACHE )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		select case lcase(command(i))
		case "-c"
			i += 1
			sComment = command(i)

		case "-f"
			i += 1
			f = command(i)

		case "-n"
			bNoSave = TRUE

		case "-s"
			bProcess = FALSE

		case "-r"
			bHTML = TRUE

		case "-recent"
			bUseRecent = TRUE
			index_file = def_recent_file

		case else
			cmd_opts_unrecognized_die( i )
		end select
	else
		f = command(i)
	end if
	i += 1
wend

if( app_opt.help ) then
	print "replace [-f] file.txt [-c comment] [-n] [-r] [-s] [options...]"
	print
	print "options:"
	print "   -f file.txt  specifies a file in the following format:"
	print "                    page,oldtext,newtext"
	print
	print "   -c comment   specifies the comment"
	print "   -s           skip processing"
	print "   -n           don't save the changes"
	print "   -r           create html page with clone and delete links"
	print "   -recent      use RecentChanges.txt instead of PageIndex.txt"
	print
	cmd_opts_show_help( "replace files in" )
	print
	print "   automatically writes 'changed.txt' with a list of changed page names"
	print "   (i.e. can then use 'putpage -web @changed.txt')"
	print
	end 0
end if

cmd_opts_resolve()

if f = "" then
	print "filename not specified"
end if

if( app_opt.cache_dir = "" ) then
	cmd_opts_die( "no cache directory specified" )
end if

'' generating HTML?
if( bHTML ) then
	'' URL must be set
	if( len( app_opt.wiki_url ) = 0 ) then
		cmd_opts_die( "wiki_url not set." )
	end if
end if


'' --------------------------------------------------------

type replace_t
	sName as string
	sOld as string
	sNew as string
end type

dim replace(1 to 1000) as replace_t
dim count as integer = 0
dim as string sName, sOld, sNew, x, text, newtext, cmt
dim as integer h
dim as long rev

if( open( f for input as #2 ) <> 0 ) then
	print "Unable to open '"; f; "'"
	end 1
end if

while eof(2) = 0
	count += 1
	input #2, sName, sOld, sNew
	print  sName, sOld, sNew
	with replace(count)
		.sName = sName
		.sOld = sOld
		.sNew = sNew
	end with
wend 
close #2

print count

if( bProcess ) then
	if( fileexists( "changed.txt" ) ) then
		kill "changed.txt"
	end if

	print "cache: "; app_opt.cache_dir

	if( open( index_file for input as #1 ) <> 0 ) then
		print "Unable to open '" + index_file + "'"
		end 1
	end if

	while eof(1) = 0
		line input #1, x
		x = Trim(x)
		x = ParsePageName( x, cmt, rev )
		if( x > "" ) then
			f = app_opt.cache_dir + x + ".wakka"
			text = LoadFileAsString( f )
			newtext = text

			for i = 1 to count
				if( replace(i).sOld <> "#delete" ) then
				if( replace(i).sName = "*" or lcase(replace(i).sName) = lcase(x) ) then
					print "Replace"
					newtext = xxReplaceSubStr(newtext, replace(i).sOld, replace(i).sNew )
				end if
				end if
			next

			if( newtext <> text ) then
				print f; ": "; "CHANGED"

				if( bNoSave = FALSE ) then
					kill f
					h = freefile
					open f for binary as #h
					put #h,,newtext
					close #h
				end if

				h = freefile
				open "changed.txt" for append as #h
				print #h, " - "; x; " ? ["; sComment; "]"
				close #h

			end if		
		end if
	wend
	close #1
end if

if( bHTML ) then
	loghtml( "", TRUE )
	loghtml( "<html><body>" )
	loghtml( "<table>" )
	for i = 1 to count
		loghtml( "<tr>" )

		loghtml( "<td>" )
		loghtml( "<a href=""" + app_opt.wiki_url + "?wakka=" + replace(i).sOld + "/clone"">" + replace(i).sOld + "/clone</a><br>" )

		loghtml( "<td>" )
		loghtml( "<a href=""" + app_opt.wiki_url + "?wakka=" + replace(i).sNew + """>" + replace(i).sNew + "</a><br>" )

		loghtml( "<td>" )
		loghtml( "<a href=""" + app_opt.wiki_url + "?wakka=" + replace(i).sOld + """>" + replace(i).sOld + "</a><br>" )

		loghtml( "<td>" )
		loghtml( "<a href=""" + app_opt.wiki_url + "?wakka=" + replace(i).sOld + "/delete"">" + replace(i).sOld + "/delete</a><br>" )

	next
	loghtml( "</table>" )
	loghtml( "" )
	loghtml( "</body></html>" )
end if

end
