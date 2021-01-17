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
#include once "fbhelp_screen.bi"
#include once "fbhelp_controls.bi"

'':::::
public sub Static_Draw _
	( _
		byval ctl as static_t ptr _
	)

	dim as integer xx,yy,ww, n, i
	dim as string a(0 to 9), t
	dim as zstring ptr p

	n = 0
	p = @ctl->text[0]
	while( len( *p ) > 0 )
		i = instr( *p, chr(10) )
		if i = 0 then
			i = len( *p )
		else
			i -= 1
		end if
		if i > ctl->ctl.rect.w then
			i = ctl->ctl.rect.w
		end if
		if( n < 10 ) then
			a(n) = left(*p, i)
			n += 1
			p += i
			if( *p = 10 ) then
				p += 1
			end if
		else
			exit while
		endif
	wend


	with ctl->ctl.rect

		Screen_SetColor ctl->ctl.fc, ctl->ctl.bc

		for i = 0 to .h - 1
			
			if i = n then
				exit for
			end if

			t = space( ( .w - len( a(i) )) \ 2 )
			t += a(i)
			t += space( .w - len( t ))

			Screen_DrawText .x, .y + i, t

		next i

	end with

	CtlClrRedraw( ctl )

end sub

'':::::
public function Static_Default_Handler _
	( _
		byval ctl_in as control_t ptr, _
		byval msg as message_t ptr _
	) as integer

	dim ctl as static_t ptr = cast( static_t ptr, ctl_in )

	if( ctl = NULL ) then
		return FALSE
	end if

	if( msg = NULL ) then
		return FALSE
	end if

	select case msg->id
	case MSG_PAINT
		Static_Draw( ctl )

	end select

	return FALSE

end function
