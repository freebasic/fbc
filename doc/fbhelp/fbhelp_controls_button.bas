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
public sub Button_Update _
	( _
		byval ctl as button_t ptr _
	)

	dim as integer xx,yy,ww
	dim as string t

	with ctl->ctl.rect

		if( ctl->ctl.flags and BUTTON_FLAG_DOWN ) then
			Screen_SetColor ctl->ctl.fc, ctl->ctl.bc
		else
			Screen_SetColor ctl->ctl.bc, ctl->ctl.fc
		end if

		t = space( ( .w - len( ctl->text )) \ 2 )
		t += ctl->text
		t += space( .w - len( t ))

		Screen_DrawText .x, .y, t

	end with

	CtlClrUpdate( ctl )

end sub

'':::::
public sub Button_Draw _
	( _
		byval ctl as button_t ptr _
	)

	dim as integer xx,yy,ww
	dim as string t

	with ctl->ctl.rect
		Screen_SetColor ctl->ctl.fc, ctl->ctl.bc
		
		'Screen_DrawText .x - 1 , .y - 1, string( .w + 2, 220 )
		Screen_DrawText .x - 1 , .y    , chr(219)
		Screen_DrawText .x + .w, .y    , chr(219)
		'Screen_DrawText .x - 1 , .y + 1, string( .w + 2, 223 )

	end with

	Button_Update( ctl )

	CtlClrRedraw( ctl )

end sub

'':::::
public function Button_Default_Handler _
	( _
		byval ctl_in as control_t ptr, _
		byval msg as message_t ptr _
	) as integer

	dim ctl as button_t ptr = cast( button_t ptr, ctl_in )

	static btn_cap as integer

	if( ctl = NULL ) then
		return FALSE
	end if

	if( msg = NULL ) then
		return FALSE
	end if

	select case msg->id
	case MSG_PAINT
		Button_Draw( ctl )

	case MSG_UPDATE
		Button_Update( ctl )

	case MSG_MOUSE_DOWN
		if( Controls_IsPointInRect( @ctl->ctl.rect, msg->mx, msg->my ) ) then
			btn_cap = 1
			ctl->ctl.flags or= BUTTON_FLAG_DOWN
		end if
		CtlSetUpdate( ctl )

	case MSG_MOUSE_UP
		if( btn_cap = 1 ) then
			if( Controls_IsPointInRect( @ctl->ctl.rect, msg->mx, msg->my ) ) then
				Controls_SendMsg( cast( control_t ptr, ctl->ctl.parent), MSG_CLICK, ctl->ctl.id, 0, 0, 0, NULL )	
			end if
		end if
		btn_cap = 0
		ctl->ctl.flags and= not BUTTON_FLAG_DOWN
		CtlSetUpdate( ctl )

	case MSG_MOUSE_UPDATE, MSG_MOUSE_MOVE
		if( btn_cap = 1 ) then
			if( Controls_IsPointInRect( @ctl->ctl.rect, msg->mx, msg->my ) ) then
				if( ( ctl->ctl.flags and BUTTON_FLAG_DOWN ) = 0 ) then
					ctl->ctl.flags or= BUTTON_FLAG_DOWN
					CtlSetUpdate( ctl )
				end if
			else
				if( ( ctl->ctl.flags and BUTTON_FLAG_DOWN ) <> 0 ) then
					ctl->ctl.flags and= not BUTTON_FLAG_DOWN
					CtlSetUpdate( ctl )
				end if
			end if
			
		end if

	end select

	return FALSE

end function
