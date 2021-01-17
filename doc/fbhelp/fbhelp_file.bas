''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006-2021 Jeffery R. Marshall (coder[at]execulink.com)

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

'' chng: jul/2006 written [coderJeff]

#include once "common.bi"
#include once "fbhelp_file.bi"

#ifdef NO_COMPRESSION

	#include "crt.bi"

	type HFILE as FILE ptr

	#define hf_open( _filename, _mode )     fopen( _filename, _mode )
	#define hf_seek( _h, _offset, _origin ) fseek( _h, _offset, _origin )
	#define hf_read( _h, _buffer, _length ) fread( _buffer, 1, _length, _h )
	#define hf_close( _h )                  fclose(_h)

#else

	#include "zlib.bi"

	type HFILE as gzfile
	dim shared hf_is_uncompressed as integer = FALSE

	#define hf_open( _filename, _mode )     gzopen( _filename, _mode )

	#if defined( __FB_WIN32__ )
		'' on windows, gzseek() is bugged on uncompressed streams and only succeed after a gzrewind()
		private sub hf_rewind( byval h as HFILE )
			if( hf_is_uncompressed <> 0 ) then
				gzrewind( h )
			end if
		end sub
		#define hf_seek( _h, _offset, _origin )  hf_rewind( _h ) : gzseek( _h, _offset, _origin )
	#else
		#define hf_seek( _h, _offset, _origin ) gzseek( _h, _offset, _origin )
	#endif

	#define hf_read( _h, _buffer, _length ) gzread( _h, _buffer, _length )
	#define hf_close( _h )                  gzclose(_h)

#endif

#define mkID( _t ) (    (cuint(cubyte(asc(_t,1)))) _
                     or (cuint(cubyte(asc(_t,2))) shl 8 ) _
                     or (cuint(cubyte(asc(_t,3))) shl 16 ) _
                     or (cuint(cubyte(asc(_t,4))) shl 24 ) )

#define ID_INDX mkID( "INDX" )
#define ID_NAME mkID( "NAME" )
#define ID_PAGE mkID( "PAGE" )

type INTEGER32 as long

type head_t field=1
	index_start as INTEGER32
	names_start as INTEGER32
	pages_start as INTEGER32
	reserved as INTEGER32
end type

type index_read_t field=1
	nameposn as INTEGER32
	fileposn as INTEGER32
end type

type index_t field=1
	pagename as zstring ptr
	fileposn as INTEGER32
end type


dim shared hf_handle as HFILE

dim shared hf_count as integer
dim shared hf_index as index_t ptr
dim shared hf_names as ubyte ptr

dim shared head as head_t

'':::::
private function ReadHeader( byval h as HFILE ) as integer

	dim b as string

	hf_seek(h, 0, SEEK_SET)

	b = string(20, 0)	
	hf_read(h, strptr( b ), 20)

	if( b = "FreeBASIC Manual" + chr(13) + chr(10) + chr(26) + chr(0) ) then
		
		hf_read(h, @head, sizeof(head_t))

		return TRUE
	end if

	return FALSE

end function

'':::::
private function ReadNames ( byval h as HFILE ) as integer

	dim id as INTEGER32
	dim size as INTEGER32

	hf_seek(h, head.names_start, SEEK_SET)

	hf_read(h, @id, sizeof(id))

	if( id <> ID_NAME ) then
		return FALSE
	end if

	hf_read(h,@size,sizeof(size))

	hf_names = callocate( size + 1)

	if( hf_names = NULL ) then
		return FALSE
	end if

	hf_read(h,hf_names,size)

	return TRUE

end function

'':::::
private function Readindex ( byval h as HFILE ) as integer

	dim id as INTEGER32
	dim count as INTEGER32
	dim size as INTEGER32
	dim i as integer
	dim rec as index_read_t

	hf_seek( h, head.index_start, SEEK_SET )

	hf_read(h,@id,sizeof(id))

	if( id <> ID_INDX ) then
		return FALSE
	end if

	hf_read(h,@count,sizeof(count))

	hf_index = callocate( count * sizeof( index_t ) )

	if( hf_index = NULL ) then
		return FALSE
	end if

	for i = 0 to count - 1
		hf_read(h,@rec,sizeof( index_read_t ))

		hf_index[i].pagename = cast( zstring ptr, hf_names + rec.nameposn )
		hf_index[i].fileposn = rec.fileposn

	next i

	hf_count = count

	return TRUE

end function

'':::::
public sub HelpFile_Close ( )
	
	if( hf_handle <> 0 ) then
		hf_close( hf_handle )
		hf_handle = 0
	end if

	if( hf_names <> NULL ) then
		deallocate hf_names
		hf_names = NULL
	end if

	if( hf_index <> NULL ) then
		deallocate hf_index
		hf_index = NULL
	end if

end sub

'':::::
public function HelpFile_Open _
	( _
		byval filename as zstring ptr, _
		byval uncompressed as integer = 0 _
	) as integer

	dim as HFILE h

	HelpFile_Close ( )

	hf_is_uncompressed = uncompressed

	h = hf_open( filename, "rb" )
	if( h = NULL ) then
		return FALSE
	end if

	if( ReadHeader( h ) = FALSE ) then
		hf_close( h )
		return FALSE
	end if

	if( ReadNames( h ) = FALSE ) then
		hf_close( h )
		return FALSE
	end if

	if( ReadIndex( h ) = FALSE ) then
		hf_close( h )
		return FALSE
	end if
	
	hf_handle = h

	return TRUE

end function

'':::::
public function HelpFile_SeekPage( byval pagename as zstring ptr ) as integer

	dim i as integer
	dim id as INTEGER32
	dim size as INTEGER32

	if( hf_handle = 0 ) then
		return -1
	end if

	for i = 0 to hf_count - 1

		if( lcase(*hf_index[i].pagename) = lcase(*pagename) ) then

			hf_seek( hf_handle, head.pages_start + hf_index[i].fileposn, SEEK_SET )

			hf_read( hf_handle, @id, sizeof(id))

			if( id = ID_PAGE ) then
				hf_read( hf_handle, @size, sizeof(size))
				return size
			end if

		end if
	next i

	return -1

end function

'':::::
public function HelpFile_Read _
	( _
		byval buf as ubyte ptr, _
		byval size as integer _
	) as integer

	if( hf_handle = NULL ) then
		return FALSE
	end if

	if( buf = NULL ) then
		return FALSE
	end if

	hf_read( hf_handle, buf, size )

	return TRUE

end function

'':::::
private function HelpFile_ConvertToText( byval text as ubyte ptr, byval size as integer ) as string
	dim as integer i, hide
	dim as string t = ""

	i = 0
	hide = FALSE

	while( i < size )
		select case text[i]
		case 27
			i += 1
			if( (text[i] and &h80) = 0 ) then
				if( hide = FALSE ) then
					t += chr(text[i])
				end if
			end if

		case 16
			hide = TRUE

		case 29
			'

		case 2, 23
			hide = FALSE

		case else

			if( hide = FALSE ) then
				t += chr(text[i])
			end if

		end select
		i += 1
	wend 

	return( t )

end function

'':::::
public function HelpFile_SaveTopicAsText _
	( _
		byval pagename as zstring ptr, _
		byval filename as zstring ptr _
	) as integer

	dim as integer size, h
	dim as ubyte ptr txt

	size = HelpFile_SeekPage( pagename )
	if( size >= 0 ) then

		txt = callocate( size + 1 )
		if( txt ) then
			hf_read( hf_handle, txt, size )

			h = freefile
			if( open( *filename for output as #h ) = 0 ) then
				print #h, HelpFile_ConvertToText( txt, size );
				close #h
			end if

			deallocate txt

			return( TRUE )

		end if

	end if

	return( FALSE )

end function
