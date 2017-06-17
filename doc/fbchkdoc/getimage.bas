''  fbchkdoc - FreeBASIC Wiki Management Tools
''	Copyright (C) 2008 Jeffery R. Marshall (coder[at]execulink[dot]com)
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

'' fbdoc headers
#include once "COptions.bi"

'' fbchkdoc headers
#include once "fbchkdoc.bi"

''
const MAX_IMAGEFILES = 100

type ImageFile
	url as string
	filename as string
end type

dim shared curl as CURL ptr
dim shared ImageFiles(1 to MAX_IMAGEFILES ) as ImageFile
dim shared NumImageFiles as integer = 0

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

		curl_easy_setopt( curl, CURLOPT_URL, url )
		curl_easy_setopt( curl, CURLOPT_FRESH_CONNECT, TRUE )
		''curl_easy_setopt( curl, CURLOPT_VERBOSE, 1 )

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

dim as string f, filename, url, image_dir
dim as integer h, i = 1

if( command(1) = "" ) then
	print "getimage imagelist.txt"
	print
	print "   imagelist.txt    text file listing images to get in the"
	print "                    following format, one image per line:"
	print
	print "                    PageName,URL"
	end 0
end if

'' read defaults from the configuration file (if it exists)
scope
	dim as fb.fbdoc.COptions ptr opts = new fb.fbdoc.COptions( default_optFile )
	if( opts <> NULL ) then
		image_dir = opts->Get( "image_dir", default_image_dir )
		delete opts
	else
		'' print "Warning: unable to load options file '" + default_optFile + "'"
		'' end 1
		image_dir = default_image_dir
	end if
end scope

f = command(1)

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
	if( lcase(left( url, 7 )) = "http://" ) then
		filename = GetFileName( url )
		if( filename > "" ) then
			AddImageFile( url, image_dir + filename )
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
