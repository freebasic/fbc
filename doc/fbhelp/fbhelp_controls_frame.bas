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
public sub Frame_Draw _
	( _
		byval ctl as frame_t ptr _
	)

	dim as integer xx,yy,ww

		with ctl->ctl.rect

			Screen_SetColor ctl->ctl.fc, ctl->ctl.bc
			if( len(ctl->title) > 0 ) then
				
				dim as integer w1, w2

				w1 = ( .w - 4 - len(ctl->title) ) \ 2

				xx = .x
				ww = .w
								
				Screen_DrawText xx, .y, chr(218) + string(w1, 196)
				xx += w1 + 1
				ww -= w1 + 1

				Screen_SetColor ctl->ctl.bc, ctl->ctl.fc
				Screen_DrawText xx, .y, " " + ctl->title + " "
				xx += len( ctl->title ) + 2
				ww -= len( ctl->title ) + 2

				Screen_SetColor ctl->ctl.fc, ctl->ctl.bc

				if( ctl->ctl.flags and FRAME_FLAG_CLOSEBUTTON ) then
					Screen_DrawText xx, .y,  string(ww - 5, 196) + chr(180, 254, 195, 196, 191)
				else
					Screen_DrawText xx, .y,  string(ww - 1, 196) + chr(191)
				end if

			else
				Screen_DrawText .x, .y, chr(218) + string(.w - 2, 196) + chr(191)
			end if

			if( ctl->ctl.flags and FRAME_FLAG_NOFILL) then
				for yy = 1 to .h - 2
					Screen_DrawText .x, .y + yy, chr(179)
					Screen_DrawText .x + .w - 1, .y + yy, chr(179)
				next yy
			else
				for yy = 1 to .h - 2
					Screen_DrawText .x, .y + yy, chr(179) + string(.w - 2,  32) + chr(179)
				next yy
			end if

			if( len(ctl->status) > 0 ) then
				Screen_SetColor ctl->ctl.bc, ctl->ctl.fc
				Screen_DrawText .x, .y + .h - 1, "  " + ctl->status + string(.w - 2 - len(ctl->status), 32)
			else
				Screen_DrawText .x, .y + .h - 1, chr(192) + string(.w - 2, 196) + chr(217)
			end if

		end with

		CtlClrRedraw( ctl )

end sub

'':::::
public function Frame_Default_Handler _
	( _
		byval ctl_in as control_t ptr, _
		byval msg as message_t ptr _
	) as integer

	dim ctl as frame_t ptr = cast( frame_t ptr, ctl_in )

	static cap_close as integer

	if( ctl = NULL ) then
		return FALSE
	end if

	if( msg = NULL ) then
		return FALSE
	end if

	select case msg->id
	case MSG_PAINT
		Frame_Draw( ctl )

	case MSG_MOUSE_DOWN
		if( msg->my = ctl->ctl.rect.y )	then
			if( msg->mx = ctl->ctl.rect.x + ctl->ctl.rect.w - 4 ) then
				cap_close = 1
			end if
		end if
		
	case MSG_MOUSE_UP
		if( Controls_GetCapture() = ctl ) then
			if( msg->mx = ctl->ctl.rect.x + ctl->ctl.rect.w - 4 ) then
				Controls_SendMsg( cast( control_t ptr, ctl->ctl.parent), MSG_CLOSE, 0, 0, 0, 0, NULL )
			end if
		end if
		cap_close = 0

	end select

end function
