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
#include once "fbhelp_textbuffer.bi"

'':::::
public sub TextBuffer_Clear _
	( _
		byval txt as textbuffer_t ptr _
	)

	dim as integer i

	if( txt = NULL ) then
		exit sub
	end if

	for i = 0 to txt->rowcount - 1
		if( txt->rowindex[i].userdata <> NULL ) then
			deallocate txt->rowindex[i].userdata
			txt->rowindex[i].userdata = NULL
			txt->rowindex[i].usercount = 0
		end if
	next i	

	if( txt->text <> NULL ) then
		deallocate txt->text
		txt->text = NULL
	end if
	
	if( txt->rowindex <> NULL ) then
		deallocate txt->rowindex
		txt->rowindex = NULL
	end if

	txt->rowcount = 0
	txt->size = 0

end sub

'':::::
public function TextBuffer_GenerateRowIndex _
	( _
		byval txt as textbuffer_t ptr, _
		byval wordwrap as integer, _
		byval escaped as integer _
	) as integer

	dim as integer i, lc, n, lp
	dim as textrow_t ptr rowindex
	dim as ubyte ptr p

	lc = -1
	n = 0

	for i = 0 to txt->size - 1
		if( txt->text[i] = 13 ) then
			if( escaped = FALSE or lc <> 27 ) then
				n += 1
			end if
		elseif( txt->text[i] = 10 ) then
			if( escaped = FALSE or lc <> 27 ) then
				if( lc <> 13 ) then
					n += 1
				end if
			end if
		end if
		lc = txt->text[i]
	next i
	n += 1

	rowindex = reallocate( txt->rowindex, sizeof( textrow_t ) * n )
	if( rowindex = NULL ) then
		return FALSE
	end if

	txt->rowcount = n
	txt->rowindex = rowindex

	p = txt->text

	n = 0
	txt->rowindex[n].text = p
	txt->rowindex[n].userdata = 0
	txt->rowindex[n].usercount = 0

	lc = -1
	lp = 0

	for i = 0 to txt->size - 1
		if( txt->text[i] = 13 ) then
			if( escaped = FALSE or lc <> 27 ) then
				txt->rowindex[n].size = i - lp
				n += 1
				txt->rowindex[n].text = p + 1
				txt->rowindex[n].userdata = 0
				txt->rowindex[n].usercount = 0
				lp = i + 1
			end if
		elseif( txt->text[i] = 10 ) then
			if( escaped = FALSE or lc <> 27 ) then
				if( lc <> 13 ) then
					txt->rowindex[n].size = i - lp
					n += 1
				end if
				txt->rowindex[n].text = p + 1
				txt->rowindex[n].userdata = 0
				txt->rowindex[n].usercount = 0
				lp = i + 1
			end if
		end if
		lc = txt->text[i]
		p += 1
	next i
	txt->rowindex[n].size = txt->size - lp
	txt->rowindex[n].userdata = 0
	txt->rowindex[n].usercount = 0
	n += 1

	return TRUE

end function

'':::::
public function TextBuffer_LoadTextFile _
	( _
		byval txt as textbuffer_t ptr, _
		byval filename as zstring ptr _
	) as integer

	dim as integer h, r

	h = freefile
	if( open( *filename for binary access read as #h ) <> 0 )then
		return FALSE
	end if

	TextBuffer_Clear txt

	r = lof(h)

	txt->text = callocate( r + 1 )
	if( txt->text = NULL ) then
		close #h
		return FALSE
	end if

	Get #h, , *txt->text, r
	close #h

	txt->text[r] = 0
	txt->size = r

	return TRUE

end function


'':::::
public function TextBuffer_Resize _
	( _
		byval txt as textbuffer_t ptr, _
		byval r as integer _
	) as integer

	TextBuffer_Clear txt

	txt->text = callocate( r + 1 )
	if( txt->text = NULL ) then
		return FALSE
	end if

	txt->size = r

	return TRUE

end function

