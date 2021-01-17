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
public sub ScrollBar_Draw _
	( _
		byval ctl as ScrollBar_t ptr _
	)

	dim as integer yy, xx

		if( ctl->ctl.flags and SCROLLBAR_FLAG_VERTICAL )then

			with ctl->ctl.rect

				Screen_SetColor ctl->ctl.fc, ctl->ctl.bc
				Screen_DrawText .x, .y, chr(24)

				for yy = 1 to .h - 2
					if yy - 1 = ctl->xPos then
						Screen_DrawText .x, .y + yy, chr(219)
					else
						Screen_DrawText .x, .y + yy, chr(176)
					end if
				next yy
				Screen_DrawText .x, .y + .h - 1, chr(25)

			end with

		elseif( ctl->ctl.flags and SCROLLBAR_FLAG_HORIZONTAL )then

			with ctl->ctl.rect

				Screen_SetColor ctl->ctl.fc, ctl->ctl.bc
				Screen_DrawText .x, .y, chr(27)

				for xx = 1 to .w - 2
					if xx -1 = ctl->xPos then
						Screen_DrawText .x + xx, .y, chr(219)
					else
						Screen_DrawText .x + xx, .y, chr(176)
					end if
				next xx
				Screen_DrawText .x + .w - 1, .y, chr(26)

			end with

		end if

		CtlClrRedraw( ctl )

end sub

'':::::
public sub ScrollBar_SetPosition _
	( _
		byval ctl as ScrollBar_t ptr, _
		byval xPos as integer _
	)

	'' Update xVal Based on xPos

	if( ctl->xScale = 0 ) then
		ctl->xPos = 0 
		ctl->xVal = ctl->xValMin
	else
		if( xPos < ctl->xPosMin ) then
			ctl->xPos = ctl->xPosMin
		elseif( xPos > ctl->xPosMax ) then
			ctl->xPos = ctl->xPosMax
		else
			ctl->xPos = xPos
		end if

		ctl->xVal = ctl->xValMin + ctl->xScale * ctl->xPos
		if( ctl->xVal < ctl->xValMin ) then
			ctl->xVal = ctl->xValMin
		elseif( ctl->xVal > ctl->xValMax ) then
			ctl->xVal = ctl->xValMax
		end if

	end if

	CtlSetRedraw( ctl )

end sub

'':::::
public sub ScrollBar_SetValue _
	( _
		byval ctl as ScrollBar_t ptr, _
		byval xVal as integer _
	)

	'' Update xPos Based on xVal

	if( ctl->xScale = 0 ) then
		ctl->xPos = 0 
		ctl->xVal = ctl->xValMin
	else

		if( xVal < ctl->xValMin ) then
			ctl->xVal = ctl->xValMin
		elseif( xVal > ctl->xValMax ) then
			ctl->xVal = ctl->xValMax
		else
			ctl->xVal = xVal
		end if

		ctl->xPos = int( csng(ctl->xVal - ctl->xValMin) / ctl->xScale )
	end if

	CtlSetRedraw( ctl )

end sub

'':::::
public sub ScrollBar_SetLimits _
	( _
		byval ctl as ScrollBar_t ptr, _
		byval xValMin as integer, _
		byval xValMax as integer _
	)

	ctl->xValMin = xValMin
	ctl->xValMax = xValMax
	if( ctl->xValMax < ctl->xValMin ) then
		ctl->xValMax = ctl->xValMin
	end if

	ctl->xPosMin = 0
	ctl->xPosMax = ctl->ctl.rect.h - 2 - 1


	if( ctl->xValMax - ctl->xValMin <= 0 ) then
		ctl->xScale = 0
		ctl->xPosMax = 0
	else
		ctl->xScale = csng( ctl->xValMax - ctl->xValMin ) / csng( ctl->xPosMax - ctl->xPosMin )
	end if

	CtlSetRedraw( ctl )

end sub


'':::::
public function ScrollBar_Default_Handler _
	( _
		byval ctl_in as control_t ptr, _
		byval msg as message_t ptr _
	) as integer

	dim ctl as scrollbar_t ptr = cast( scrollbar_t ptr, ctl_in )
	dim as integer yy
	
	static scroll_cap as integer

	if( ctl = NULL ) then
		return FALSE
	end if

	if( msg = NULL ) then
		return FALSE
	end if

	select case msg->id
	case MSG_PAINT
		ScrollBar_Draw( ctl )

	case MSG_MOUSE_DOWN
		if( msg->mx = ctl->ctl.rect.x ) then
			if( msg->my = ctl->ctl.rect.y ) then
				scroll_cap = 1
			elseif( msg->my = ctl->ctl.rect.y + ctl->ctl.rect.h - 1) then
				scroll_cap = 2
			elseif( msg->my = ctl->ctl.rect.y + ctl->xPos + 1 ) then
				scroll_cap = 3
			elseif(msg->my < ctl->ctl.rect.y + ctl->xPos + 1 ) then
				scroll_cap = 4
			elseif(msg->my > ctl->ctl.rect.y + ctl->xPos + 1 ) then
				scroll_cap = 5
			end if
		end if

	case MSG_MOUSE_UP
		if( scroll_cap = 3 ) then

		end if
		scroll_cap = 0

	case MSG_MOUSE_UPDATE
		'' if( msg->mx = ctl->ctl.rect.x ) then
			if( scroll_cap = 1 ) then
				if( msg->my = ctl->ctl.rect.y ) then
					Controls_SendMsg( ctl->linkedctl, MSG_SCROLL, 0, 0, -1, 0, NULL )
					CtlSetRedraw( ctl )
				end if

			elseif( scroll_cap = 2 ) then
				if( msg->my = ctl->ctl.rect.y + ctl->ctl.rect.h - 1) then
					Controls_SendMsg( ctl->linkedctl, MSG_SCROLL, 0, 0, 1, 0, NULL )
					CtlSetRedraw( ctl )
				end if

			elseif( scroll_cap = 3 ) then
				if(msg->my > ctl->ctl.rect.y ) then
					if(msg->my < ctl->ctl.rect.y + ctl->ctl.rect.h - 1) then
						ScrollBar_SetPosition( ctl, msg->my - ctl->ctl.rect.y - 1 )
						Controls_SendMsg( ctl->linkedctl, MSG_SET_SCROLL, 0, 0, ctl->xVal, 0, NULL )
						CtlSetRedraw( ctl )
					end if
				end if

			elseif( scroll_cap = 4 ) then
				if(msg->my - ctl->ctl.rect.y - 1 < ctl->xPos ) then
					ScrollBar_SetPosition( ctl, ctl->xPos - 1 )
					Controls_SendMsg( ctl->linkedctl, MSG_SET_SCROLL, 0, 0, ctl->xVal, 0, NULL )
					CtlSetRedraw( ctl )
				end if 
					
			elseif( scroll_cap = 5 ) then
				if(msg->my - ctl->ctl.rect.y - 1 > ctl->xPos ) then
					ScrollBar_SetPosition( ctl, ctl->xPos + 1 )
					Controls_SendMsg( ctl->linkedctl, MSG_SET_SCROLL, 0, 0, ctl->xVal, 0, NULL )
					CtlSetRedraw( ctl )
				end if

			end if

		'' end if

	end select

end function
