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

'' getimage.bas - download images from the internet

'' chng: written [jeffm]

#include once "curl.bi"
#include once "crt/stdio.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"
#include once "funcs.bi"
#include once "cmd_opts.bi"
#include once "fbdoc_trace.bi"

''
const MAX_IMAGEFILES = 100

type ImageFile
	url as string
	filename as string
end type

dim shared curl as CURL ptr
dim shared ImageFiles(1 to MAX_IMAGEFILES ) as ImageFile
dim shared NumImageFiles as integer = 0

'' --------------------------------------------------------

'':::::
function writeFunction cdecl ( byval buf as any ptr, byval size as size_t, byval nmemb as size_t , byval stream as any ptr) as size_t
	fwrite( buf, size, nmemb, stream )
	function = nmemb * size										    
end function

'':::::
function GetImage( byref url as string, byref filename as string ) as integer


	dim as FILE ptr destFile
	dim as CURLcode result

	curl = curl_easy_init()

	if(curl) then

		if( fb.fbdoc.get_trace() ) then
			curl_easy_setopt( curl, CURLOPT_VERBOSE, TRUE )
		end if

		curl_easy_setopt( curl, CURLOPT_URL, url )
		curl_easy_setopt( curl, CURLOPT_FRESH_CONNECT, TRUE )

		destFile = fopen( filename, "wb" )

		if( destfile ) then

			curl_easy_setopt( curl, CURLOPT_WRITEFUNCTION, procptr(writeFunction) )
			curl_easy_setopt( curl, CURLOPT_WRITEDATA, destFile )

			result = curl_easy_perform( curl )

			fclose(destFile)

		else
			result = -1
		
		end if

		curl_easy_cleanup( curl )

	else
		result = -1

	end if

	function = result

end function

'':::::
function AddImageFile( byref url as string, byref filename as string ) as integer
	
	dim i as integer

	function = FALSE
	
	for i = 1 to NumImageFiles
		if( lcase( url ) = lcase( ImageFiles(i).url ) ) then
			exit for
		end if
	next

	if( i > NumImageFiles ) then

		if( NumImageFiles < MAX_IMAGEFILES ) then
			NumImageFiles += 1
			ImageFiles( NumImageFiles ).url = url
			ImageFiles( NumImageFiles ).filename = filename
			function = TRUE
		end if
	end if		

end function

'':::::
function GetFileName( byref url as string ) as string
	dim i as integer
	function = ""
	for i = len( url ) to 1 step - 1
		select case mid( url, i, 1 )
		case "/", "\"
			function = trim(mid(url,i+1))
			exit for
		end select
	next
end function

'' --------------------------------------------------------
'' MAIN
'' --------------------------------------------------------

'' private options
dim f as string

'' enable image dir
cmd_opts_init( CMD_OPTS_ENABLE_IMAGE or CMD_OPTS_ENABLE_TRACE )

dim i as integer = 1
while( command(i) > "" )
	if( cmd_opts_read( i ) ) then
		continue while
	elseif( left( command(i), 1 ) = "-" ) then
		cmd_opts_unrecognized_die( i )
	else
		f = command(i)
	end if
	i += 1
wend

if( app_opt.help ) then
	print "getimage imagelist.txt"
	print
	print "   imagelist.txt    text file listing images to get in the"
	print "                    following format, one image per line:"
	print
	print "                    PageName,URL"
	print
	cmd_opts_show_help( "" )
	print
	end 0
end if

cmd_opts_resolve()
cmd_opts_check_cache()
cmd_opts_check_url()

'' --------------------------------------------------------

dim as string filename, url
dim as integer h

h = freefile
if( open( f for input access read as #h ) <> 0 ) then
	print "unable to open '" & f & "'"
	end 1
end if

while eof(h) = 0
	line input #h, url
	url = trim(url)
	dim i as integer = instr( url, "," )
	if (i > 0) then
		url = trim(mid(url,i+1))
	end if
	if( (lcase(left( url, 7 )) = "http://") or (lcase(left( url, 8 )) = "https://") ) then
		filename = GetFileName( url )
		if( filename > "" ) then
			AddImageFile( url, app_opt.image_dir + filename )
		end if
	end if
	
wend

close #h

if( NumImageFiles > 0 ) then
	for i = 1 to NumImageFiles
		print "Getting '" & ImageFiles(i).filename & "': ";
		if( GetImage( ImageFiles(i).url, ImageFiles(i).filename ) = 0 ) then
			print "OK"
		else
			print "FAILED"
		end if
	next
else
	print "No image files specified"
end if
