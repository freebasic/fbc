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

'' buffer.bas - line based text buffer class

'' chng: written [jeffm]

#include once "buffer.bi"

'' --------------------------------------------------------
'' BUFFER
'' --------------------------------------------------------

#ifdef __FB_LINUX__
	const eol as string = chr(10)
#else
	const eol as string = chr(13,10)
#endif

''
constructor string_item()
	_value = ""
	_nxt = NULL
end constructor

''
constructor string_item( byref x as string )
	_value = x
	_nxt = NULL
end constructor

''
constructor string_item( byref x as string, byval nxt as string_item ptr )
	_value = x
	_nxt = nxt
end constructor

''
destructor string_item()
	_value = ""
end destructor

''
constructor buffer()
	_head = NULL
	_count = 0
end constructor

''
property buffer.count() as integer
	property = _count
end property

''
sub buffer.clear()
	while( _head )
		dim p as string_item ptr = _head->_nxt
		delete _head
		_head = p
	wend
	_count = 0
end sub

''
property buffer.text( byref x as string )
	this.clear()

	dim tmp as string, i as integer

	tmp = ""
	for i = 1 to len(x)
		select case mid( x, i, 1 )
		case chr(10)
			append tmp
			tmp = ""
		case chr(13)
		case else
			tmp = tmp & mid( x, i, 1 )
		end select
	next
	if( tmp > "" ) then
		append tmp
		tmp = ""
	end if
end property

''
function buffer.gettext( byref eol as string ) as string
	dim p as string_item ptr
	dim tmp as string
	tmp = ""
	p = _head
	while( p )
		tmp &= p->_value & eol
		p = p->_nxt
	wend
	function = tmp
end function

''
property buffer.text_lf() as string
	property = gettext( chr(10) )
end property

''
property buffer.text_crlf() as string
	property = gettext( chr(13,10) )
end property

''
property buffer.text() as string
	#ifdef __FB_LINUX__
		property = gettext( chr(10) )
	#else
		property = gettext( chr(13,10) )
	#endif
end property

''
private function buffer.getitem( byval index as integer ) as string_item ptr
	if( index >= 1 and index <= _count ) then
		dim p as string_item ptr = _head
		for i as integer = 1 to index - 1
			p = p->_nxt
		next
		function = p
	else
		function = NULL
	end if
end function

''
property buffer.item( byval index as integer ) as string
	dim p as string_item ptr = getitem( index )
	if( p ) then
		property = p->_value
	else
		property = ""
	end if
end property

''
property buffer.item( byval index as integer, byref x as string )
	dim p as string_item ptr = getitem( index )
	if( p ) then
		p->_value = x
	end if
end property

''
function buffer.append( byref x as string ) as integer
	if( _head ) then
		dim p as string_item ptr = _head
		while( p->_nxt )
			p = p->_nxt
		wend
		p->_nxt = new string_item( x )
	else
		_head = new string_item( x )
	end if
	_count += 1
	function = _count
end function

''
function buffer.insert( byval index as integer, byref x as string ) as integer
	if( index <= 1 ) then
		_head = new string_item( x, _head )
		_count += 1
		function = 2
	elseif( index > _count ) then
		function = append( x )
	else
		dim p as string_item ptr = getitem( index - 1 )
		if( p ) then
			p->_nxt = new string_item( x, p->_nxt )
			_count += 1
			function = index + 1
		else
			'' ERROR?
			function = 0
		end if
	end if
end function

''
sub buffer.remove( byval index as integer )
	if( index = 1 ) then
		if( _head ) then
			dim nxt as string_item ptr = _head->_nxt
			delete _head
			_head = nxt
			_count -= 1
		end if
	elseif( index > 1 and index <= _count ) then
		dim p as string_item ptr = getitem( index - 1 )
		if( p ) then
			dim nxt as string_item ptr = p->_nxt->_nxt
			delete p->_nxt
			p->_nxt = nxt
			_count -= 1
		end if
	end if
end sub

''
sub buffer.dump( byval h as integer )
	dim p as string_item ptr = _head
	if( h ) then
		print #h, "Items = "; _count
	else
		print "Items = "; _count
	end if
	while( p )
		if( h ) then
			'' print #h, hex(p) & "," & hex(p->_nxt) & ": '" & p->_value & "'"
			print #h, p->_value
		end if
		'' print hex(p) & "," & hex(p->_nxt) & ": '" & p->_value & "'"
		print p->_value
		p = p->_nxt
	wend
end sub
