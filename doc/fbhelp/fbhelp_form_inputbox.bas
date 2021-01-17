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
#include once "fbhelp_form_inputbox.bi"

	dim shared bClose as integer
	dim shared last_button as integer


'':::::
private function Inputbox_Handler _
	( _
		byval ctl_in as control_t ptr, _
		byval msg as message_t ptr _
	) as integer

	select case msg->id
	case MSG_CLICK

		last_button = msg->mx
		bClose = TRUE
		return TRUE

	end select

end function

'':::::

#if __FB_GCC__

public function InputBox_show cdecl _
	( _
		byref result as string, _
		byval text as zstring ptr, _
		byval title as zstring ptr, _
		byval count as integer, _
		byval btn1 as zstring ptr = NULL, _
		byval btn2 as zstring ptr = NULL, _
		byval btn3 as zstring ptr = NULL, _
		byval btn4 as zstring ptr = NULL _
	) as integer

#else

public function InputBox_show cdecl _
	( _
		byref result as string, _
		byval text as zstring ptr, _
		byval title as zstring ptr, _
		byval count as integer, _
		... _
	) as integer

#endif

	dim as string k
	dim as integer mx,my,mz,mb
	dim as integer w, h, x, y, ret, i, xoffset, old_x, old_y, old_cursor
	dim as control_t ptr old_ctl
	dim as any ptr arg

	dim frm as form_t
	dim border as frame_t
	dim label as static_t
	dim edit as editbox_t
	redim btn(1 to 3) as button_t
	
	x = 5
	y = 5
	w = Screen_GetCols() - 10
	h = 12

	Control_Set NULL, @frm.ctl, x, y, w, h, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or CONTROL_FLAG_VISIBLE, 0
	with frm
		.ctl.handler = @Inputbox_Handler
	end with

	Control_Set @frm, @border.ctl, x, y, w, h, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or FRAME_FLAG_CLOSEBUTTON or CONTROL_FLAG_VISIBLE, 0
	with border
		.ctl.handler = @Frame_Default_Handler
		.title = ""
		.status = ""
	end with
	Forms_Add_Control @frm, cast( control_t ptr, @border )

	Control_Set @frm, @label.ctl, x + 2, y + 2, w - 4, 4, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or CONTROL_FLAG_VISIBLE, 0
	with label
		.ctl.handler = @Static_Default_Handler
		.text = *text
	end with
	Forms_Add_Control @frm, cast( control_t ptr, @label )

	Control_Set @frm, @edit.ctl, x + 2, y + 6, w - 4, 1, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or CONTROL_FLAG_VISIBLE, 0
	with edit
		.ctl.handler = @EditBox_Default_Handler
		.buffer = LINE_BUFFER_CREATE(256)
	end with
	Forms_Add_Control @frm, cast( control_t ptr, @edit )

	xoffset = ((w - 2) - (count * 10) - ((count - 1) * 5)) \ 2
	#if not __FB_GCC__
	arg = va_first
	#endif
	for i = 1 to count
		Control_Set @frm, @btn(i).ctl, x + xoffset + (i - 1) * 15, y + h - 3, 10, 1, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or CONTROL_FLAG_VISIBLE, i
		with btn(i)
			.ctl.handler = @Button_Default_Handler
			#if not __FB_GCC__
			.text = *va_arg( arg, zstring ptr )
			#else
			.text = *iif( i=1, btn1, iif( i=2, btn2, iif( i=3, btn3, iif(i=4, btn4, NULL))))
			#endif
		end with
		Forms_Add_Control @frm, cast( control_t ptr, @btn(i) )
		#if not __FB_GCC__
		arg = va_next( arg, zstring ptr )
		#endif
	next i


	Forms_Add @frm

	Screen_GetCursorPos( old_x, old_y )
	old_cursor = Screen_SetCursorState( TRUE )

	bClose = 0
	ret = 0
	last_button = 0

	LINE_BUFFER_SetText( edit.buffer, strptr( result ), len( result ) )
	LINE_BUFFER_SetIndex( edit.buffer, len( result ) )
	Screen_SetCursorPos( edit.ctl.rect.x + edit.buffer->mindex - edit.leftindex, edit.ctl.rect.y)

	old_ctl = Controls_SetFocus( cast( control_t ptr, @edit ) )

	do

		Forms_Draw( @frm, FALSE )

		if( Screen_MouseInstalled() <> FALSE ) then
			Screen_GetMouse( mx, my, mz, mb )
			Controls_ProcessMouse( mx, my, mz, mb )
		end if

		k = inkey
		if( len(k) = 0 ) then
			sleep 25
			k = inkey
		end if

		'' TODO: make a keyboard focus handler

		if( len(k) > 0 ) then

			if( last_button = 0 ) then
				
				if( EditBox_KeyInput( @edit, k ) = FALSE ) then

					select case k
					case chr(9) '' tab
						last_button = 1
						Screen_SetCursorPos( btn(last_button).ctl.rect.x, btn(last_button).ctl.rect.y)
						
					case chr(13)
						ret = 1 '' First button
						exit do

					case chr(27)
						ret = 0
						exit do

					end select
				else
					Screen_SetCursorPos( edit.ctl.rect.x + edit.buffer->mindex - edit.leftindex, edit.ctl.rect.y)

				end if

			else
			
				select case k
				case chr(255, 75) '' left
					last_button += count - 1
					last_button mod= count
					Screen_SetCursorPos( btn(last_button).ctl.rect.x, btn(last_button).ctl.rect.y)

				case chr(9), chr(255, 77) '' tab, right
					last_button += 1
					last_button mod= (count + 1)
					if( last_button = 0 ) then
						Screen_SetCursorPos( edit.ctl.rect.x + edit.buffer->mindex - edit.leftindex, edit.ctl.rect.y)
					else
						Screen_SetCursorPos( btn(last_button).ctl.rect.x, btn(last_button).ctl.rect.y)
					end if
					
				case chr(13)
					ret = last_button
					exit do

				case chr(27)
					ret = 0
					exit do

				end select

			end if

		end if

		if( bClose ) then
			ret = last_button
			exit do
		end if

	loop

	result = *LINE_BUFFER_GetTextPtr( edit.buffer )

	Forms_Remove( @frm )

	Controls_SetFocus( old_ctl )
	Screen_SetCursorPos( old_x, old_y )
	Screen_SetCursorState( old_cursor )

	return ret

end function
