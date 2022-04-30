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

'' funcsdir.bas - directory and file scanning functions

'' chng: written [jeffm]

'' fb headers
#include once "dir.bi"

'' fbchkdoc headers
#include once "funcs.bi"

''
sub AddString( byref s as string, a() as string, byref n as integer )
	dim i as integer
	for i = 1 to n
		if( s = a(i) ) then
			exit for
		end if
	next
	if( i > n ) then
		n += 1
		if( n = 1 ) then
			redim a(1 to n)
		else
			redim preserve a(1 to n)
		end if
		a(n) = s
	end if
end sub

''
function ReadFileAsText( byref filename as string ) as string
	dim h as integer, x as string
	h = freefile
	if( open( filename for input access read as #h ) = 0 ) then
		close #h
		open filename for binary access read as #h
		x = space( lof(h) )
		get #h,,x
		close #h
	end if
	function = x
end function

''
function WriteFileAsText( byref filename as string, byref text as string, byval overwrite as integer = FALSE ) as integer

	dim h as integer = freefile
	function = FALSE
	if( open( filename for input access read as #h ) = 0 ) then
		close #h
		if( overwrite = FALSE ) then
			print "File already exists"
			exit function
		else
			open filename for output as #h
			close #h
		end if
	end if

	if( open( filename for binary as #h ) = 0 ) then
		put #h,,text
		close #h
		function = TRUE
	end if

end function

''
sub AddSourceDir( byref path as string, dirs() as string, byref ndirs as integer )
	AddString( path, dirs(), ndirs )
end sub

''
function ScanSourceDirs( byref path as string, byref path2 as string, dirs() as string, byref ndirs as integer, exfilters() as string, byval nexfilters as integer ) as integer
	
	dim d as string
	dim count as integer = 0
	dim i as integer, start as integer

	start = ndirs + 1
	d = dir(path & path2 & "*.*",fbDirectory)
	while d > ""
		if( d <> "." and d <> ".." ) then
			for i = 1 to nexfilters
				if( lcase( path2 & d & "/" ) = lcase(exfilters(i)) ) then
					exit for
				end if
			next
			if( nexfilters <= 0 or i > nexfilters ) then
				AddSourceDir( path2 & d & "/", dirs(), ndirs )
				count += 1
			end if
		end if
		d = dir()
	wend

	for i = start to ndirs
		ScanSourceDirs( path, path2 & dirs(i), dirs(), ndirs, exfilters(), nexfilters )
	next

	function = count

end function

''
function ScanSourceFiles( byref path as string, byref src_dir as string, files() as string, byref nfiles as integer ) as integer

	dim d as string
	dim count as integer = 0
	
	d = dir(path & src_dir & "*.*")
	while d > ""
	  if( right(d,2) = ".c" or right(d,4) = ".bas" or right(d,3) = ".bi" ) then
		  nfiles += 1
		  count += 1
		  files(nfiles) = src_dir & d
	  end if
	  d = dir()
	wend

	function = count

end function

''
function ScanSourceDirsAndFiles( byref path as string, dirs() as string, byref ndirs as integer, files() as string, byref nfiles as integer, filters() as string, byval nfilters as integer, exfilters() as string, byval nexfilters as integer ) as integer

	dim count as integer = 0
	dim i as integer

	ndirs = 0
	if( nfilters > 0 ) then
		for i = 1 to nfilters
			AddSourceDir( filters(i), dirs(), ndirs )
			ScanSourceDirs( path, filters(i), dirs(), ndirs, exfilters(), nexfilters )
		next
	else
		ScanSourceDirs( path, "", dirs(), ndirs, exfilters(), nexfilters )
	end if
	

	for i = 1 to ndirs
		count += ScanSourceFiles( path, dirs(i), files(), nfiles )
	next

	function = count
	
end function
