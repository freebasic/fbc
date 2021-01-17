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
#include once "fbhelp_screen.bi"
#include once "fbhelp_controls.bi"

'':::::
public sub EditBox_Draw _
	( _
		byval ctl as editbox_t ptr _
	)

	static sp_fill as string

	if( len( sp_fill ) = 0 ) then
		sp_fill = string(MAX_LINE_WIDTH, 32)
	end if
	
	with ctl->ctl.rect
		
		dim as integer xchars, n

		Screen_SetColor ctl->ctl.bc, ctl->ctl.fc

		'' Figure out how to display the text, adjust ctl->leftindex
		'' if needed if d->buffer->mindex is outside the current text box

		'' check if ctl->buffer->mindex is inside the box
		if ctl->buffer->mindex < ctl->leftindex then
			ctl->leftindex = ctl->buffer->mindex - ctl->ctl.rect.w \ 2
		elseif ctl->buffer->mindex > ctl->leftindex + ctl->ctl.rect.w - 1 then
			ctl->leftindex = ctl->buffer->mindex - ctl->ctl.rect.w \ 2
		end if
		if( ctl->leftindex < 0 ) then
			ctl->leftindex = 0
		end if

		xchars = ctl->ctl.rect.w

		n = xchars
		if (ctl->buffer->mlength - ctl->leftindex) < xchars then
			n = ctl->buffer->mlength - ctl->leftindex
		end if

		if( n > 0 ) then
			Screen_DrawText .x, .y, ctl->buffer->mdata + ctl->leftindex, n
		end if
		if( xchars - n ) > 0 then
			Screen_DrawText .x + n, .y, strptr( sp_fill ), xchars - n
		end if

		if( Controls_GetFocus() = ctl ) then
			Screen_SetCursorPos( .x + ctl->buffer->mindex - ctl->leftindex, .y)
		end if

	end with

	CtlClrRedraw( ctl )

end sub

'':::::
public sub EditBox_Update _
	( _
			byval ctl as editbox_t ptr _
	)
		
	dim as integer bVisible = TRUE

	if( ctl->buffer->mindex < ctl->leftindex ) then
		bVisible = FALSE
	elseif( ctl->buffer->mindex >= ctl->leftindex + ctl->ctl.rect.w ) then
		bVisible = FALSE
	end if

	if( bVisible ) then
		Screen_SetCursorPos _
			( _
				ctl->ctl.rect.x + ctl->buffer->mindex - ctl->leftindex, _
				ctl->ctl.rect.y _
			)

		Screen_ShowCursor( )
	else

		Screen_HideCursor( )
	end if

	CtlClrUpdate( ctl )

end sub


'':::::
public function EditBox_KeyInput _
	( _
		byval ctl as editbox_t ptr, _
		byval key as zstring ptr _
	) as integer
	
	static as integer dirflag

	if( key = NULL ) then
		return FALSE
	end if

	if( len( *key ) = 0 ) then
		return FALSE
	end if

	select case *key
	case chr(255, 75) '' left
		if ctl->buffer->mindex > 0 then ctl->buffer->mindex -= 1

	case chr(255, 77) '' right
		if ctl->buffer->mindex < ctl->buffer->mlength then ctl->buffer->mindex += 1

	case chr(255, 71) '' home
		if ctl->buffer->mindex > 0 then	ctl->buffer->mindex = 0

	case chr(255, 79) '' end
		if ctl->buffer->mindex < ctl->buffer->mlength then ctl->buffer->mindex = ctl->buffer->mlength

	case chr(8)	'' backspace
		LINE_BUFFER_BackChar ctl->buffer

	case chr(255, 83) '' delete
		LINE_BUFFER_DeleteChar ctl->buffer
	
	case chr(32) to chr(126)
		LINE_BUFFER_InsertChar ctl->buffer, asc(*key)

	case else
		return FALSE

	end select

	CtlSetRedraw( ctl )

	return TRUE

end function

'':::::
public function EditBox_Default_Handler _
	( _
		byval ctl_in as control_t ptr, _
		byval msg as message_t ptr _
	) as integer

	dim ctl as editbox_t ptr = cast( editbox_t ptr, ctl_in )
	static ctl_cap as integer = 0

	if( ctl = NULL ) then
		return FALSE
	end if

	if( msg = NULL ) then
		return FALSE
	end if

	select case msg->id
	case MSG_PAINT
		EditBox_Draw( ctl )

	case MSG_UPDATE
		EditBox_Update( ctl )

	case MSG_KEY_PRESS
		if(Controls_GetCapture() = ctl ) then
			return( EditBox_KeyInput( ctl, msg->ky ) )
		end if

	case MSG_MOUSE_DOWN
		if( Controls_IsPointInRect( @ctl->ctl.rect, msg->mx, msg->my ) ) then
			ctl_cap = 1
			LINE_BUFFER_SetIndex(ctl->buffer, msg->mx - ctl->ctl.rect.x + ctl->leftindex)
		end if
		CtlSetRedraw( ctl )

	case MSG_MOUSE_UP
		if( ctl_cap = 1 ) then
			LINE_BUFFER_SetIndex(ctl->buffer, msg->mx - ctl->ctl.rect.x + ctl->leftindex)
			ctl_cap = 0
		end if
		CtlSetRedraw( ctl )

	case MSG_MOUSE_MOVE
		if( ctl_cap = 1 ) then
			LINE_BUFFER_SetIndex(ctl->buffer, msg->mx - ctl->ctl.rect.x + ctl->leftindex)
		end if
		CtlSetRedraw( ctl )

	end select

	return FALSE

end function
