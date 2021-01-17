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

'' chng: aug/2006 written [coderJeff]

#include once "common.bi"
#include once "fbhelp_linebuffer.bi"

#include once "crt.bi"
#define mstr_Move(dst,src,count) memmove(dst,src,count)
#define mstr_Copy(dst,src,count) memcpy(dst,src,count)

'':::::
public function LINE_BUFFER_Create alias "LINE_BUFFER_Create"  (byval startsize as integer) as LINE_BUFFER_T Ptr
	dim buf as LINE_BUFFER_T Ptr
	buf = Allocate(sizeof(LINE_BUFFER_T))
	if (buf) then
		buf->msize = (startsize + 1 + 3) and (not 3)
		buf->mindex = 0
		buf->mlength = 0
		buf->mdata = Allocate(buf->msize)
		if (buf->mdata) then
			buf->mdata[0] = 0
			buf->mflags = 0
		else
			Deallocate buf
			buf = 0
		end if
	end if
	function = buf
end function

'':::::
public sub LINE_BUFFER_Destroy alias "LINE_BUFFER_Destroy" (ByVal buf as LINE_BUFFER_T Ptr)
	if (buf) then
		if buf->mdata then
			deallocate buf->mdata
		end if
		deallocate buf
	end if
end sub

'':::::
public sub LINE_BUFFER_Clear alias "LINE_BUFFER_Clear" (byval buf as LINE_BUFFER_T Ptr)
	if (buf) then
		buf->mindex = 0
		buf->mlength = 0
		buf->mdata[0] = 0
		buf->mflags or= LINE_BUFFER_FLAG_CHANGED
	end if	
end sub

'':::::
public function LINE_BUFFER_GetBufferSize alias "LINE_BUFFER_GetBufferSize" (byval buf as LINE_BUFFER_T ptr) As integer
  function = buf->msize - 1
End function

'':::::
public sub LINE_BUFFER_SetBufferSize alias "LINE_BUFFER_SetBufferSize" (byval buf as LINE_BUFFER_T ptr, byval size As integer)
	If (size <> buf->msize - 1) and (size > 0) Then
		buf->msize = (size + 1 + 3) and (not 3)
		buf->mdata = Reallocate(buf->mdata, buf->msize)
		if buf->mlength >= buf->msize then	buf->mlength = buf->msize - 1
		if buf->mindex > buf->mlength then buf->mindex = buf->mlength
		buf->mdata[buf->mlength] = 0
	End If
End sub

'':::::
public function LINE_BUFFER_GetLength alias "LINE_BUFFER_GetLength" (byval buf as LINE_BUFFER_T Ptr) as integer
	if (buf) then
		function = buf->mlength
	end if
end function

'':::::
public function LINE_BUFFER_GetIndex alias "LINE_BUFFER_GetIndex" (ByVal buf as LINE_BUFFER_T Ptr) as integer
	if (buf) then
		function = buf->mindex
	end if
end function

'':::::
public function LINE_BUFFER_SetIndex alias "LINE_BUFFER_SetIndex" (ByVal buf as LINE_BUFFER_T Ptr, byval index as integer) as integer
	function = -1
	if (buf) then
		if index < 0 then
			buf->mindex = 0
		elseif index > buf->mlength then
			buf->mindex = buf->mlength
		else
			buf->mindex = index
		end if
		function = index
	end if
end function

'':::::
public sub LINE_BUFFER_InsertChar alias "LINE_BUFFER_InsertChar" (ByVal buf as LINE_BUFFER_T Ptr, byval ch as integer)
	dim i as integer
	if (buf) then
		if buf->mlength < buf->msize - 1 then
			if buf->mindex < buf->mlength then
				mstr_Move(buf->mdata + buf->mindex + 1, buf->mdata + buf->mindex, buf->mlength - buf->mindex + 1)
			end if
			buf->mdata[buf->mindex] = (ch and 255)
			buf->mindex += 1
			buf->mlength += 1
			buf->mdata[buf->mlength] = 0
			buf->mflags or= LINE_BUFFER_FLAG_CHANGED
		end if
	end if										
end sub

'':::::
public sub LINE_BUFFER_BackChar alias "LINE_BUFFER_BackChar" (ByVal buf as LINE_BUFFER_T Ptr)
	dim i as integer
	if (buf) then
		if buf->mindex > 0 then
			mstr_Move(buf->mdata + buf->mindex - 1, buf->mdata + buf->mindex, buf->mlength - buf->mindex + 1)
			buf->mindex -= 1
			buf->mlength -= 1
			buf->mflags or= LINE_BUFFER_FLAG_CHANGED
		end if
	end if
end sub

'':::::
public Sub LINE_BUFFER_DeleteChar alias "LINE_BUFFER_DeleteChar" (ByVal buf as LINE_BUFFER_T Ptr)
	dim i as integer
	if (buf) then
		if buf->mindex < buf->mlength then
			mstr_Move(buf->mdata + buf->mindex, buf->mdata + buf->mindex + 1, buf->mlength - buf->mindex)
			buf->mlength -= 1
			buf->mflags or= LINE_BUFFER_FLAG_CHANGED
		end if
	end if
End Sub

'':::::
public function LINE_BUFFER_GetChar alias "LINE_BUFFER_GetChar" (byval buf as LINE_BUFFER_T Ptr, byval Index As integer) As Integer
	function = -1
	if (buf) then
		if Index >= 0 and Index < buf->mlength then
			function = buf->mdata[index]
		end if
	end if
end function

'':::::
public sub LINE_BUFFER_SetChar alias "LINE_BUFFER_SetChar" (byval buf as LINE_BUFFER_T Ptr, byval Index As integer, byval ch As Integer)
	if (buf) then
		if Index >= 0 and Index < buf->mlength then
			buf->mdata[index] = ch
		end if
	end if
end sub

'':::::
public function LINE_BUFFER_GetTextPtr alias "LINE_BUFFER_GetTextPtr" (ByVal buf as LINE_BUFFER_T Ptr) as zstring ptr
	function = 0
	if (buf) then
		function = buf->mdata
	end if 
end Function

'':::::
public function LINE_BUFFER_GetText alias "LINE_BUFFER_GetText" (ByVal buf as LINE_BUFFER_T Ptr, ByVal txt as ubyte ptr, ByVal size as integer) as integer
	dim i as integer
	function = 0
	if (buf) then
		if (txt <> 0) and (size > 0) then
			if size > buf->mlength then
				mstr_Copy(txt, buf->mdata, buf->mlength + 1)
				function = buf->mlength
			else
				mstr_Copy(txt, buf->mdata, size - 1)
				txt[size - 1] = 0
				function = size - 1
			end if
		else
			function = buf->mlength
		end if
	end if
end function

'':::::
public function LINE_BUFFER_SetText alias "LINE_BUFFER_SetText" (ByVal buf as LINE_BUFFER_T Ptr, ByVal txt as ubyte ptr, ByVal size as integer) as integer
	dim i as integer
	function = 0
	if (txt <> 0) and (size > 0) then
		if size > buf->msize - 1 then
			size = buf->msize - 1
		end if
		mstr_Copy(buf->mdata, txt, size)
		buf->mdata[size] = 0
		buf->mlength = size
		if buf->mindex > size then
			buf->mindex = size
		end if
		buf->mflags or= LINE_BUFFER_FLAG_CHANGED
		function = size
	else
		LINE_BUFFER_Clear(buf)
	end if
end function

'':::::
public sub LINE_BUFFER_ClearChanged alias "LINE_BUFFER_ClearChanged" (ByVal buf as LINE_BUFFER_T Ptr)
	buf->mflags and= (NOT LINE_BUFFER_FLAG_CHANGED)
end sub

'':::::
public function LINE_BUFFER_IsChanged alias "LINE_BUFFER_IsChanged" (ByVal buf as LINE_BUFFER_T Ptr) as integer
	function = (buf->mflags and LINE_BUFFER_FLAG_CHANGED)
	buf->mflags and= (NOT LINE_BUFFER_FLAG_CHANGED)
end function

