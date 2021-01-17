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
#include once "fbhelp_controls.bi"
#include once "fbhelp_screen.bi"

dim shared as form_t ptr pForms( 1 to 16 )
dim shared as integer nForms = 0

dim shared as integer prev_mx
dim shared as integer prev_my
dim shared as integer prev_mb
dim shared as integer prev_mz

dim shared as integer curr_mx
dim shared as integer curr_my
dim shared as integer curr_mb
dim shared as integer curr_mz

dim shared as control_t ptr mcap_control = NULL
dim shared as control_t ptr focus_control = NULL

'':::::
public sub Forms_Add _
	( _
		byval frm as form_t ptr _
	)

	if( frm = NULL ) then
		exit sub
	end if

	nForms += 1
	pForms(nForms) = frm

end sub

public sub Forms_Remove _
	( _
		byval frm as form_t ptr _
	)

	dim as integer i, j

	if( frm = NULL ) then
		exit sub
	end if

	for i = 1 to nForms
		if( pForms(i) = frm ) then
			nForms -= 1
			exit for
		end if
	next i

	for j = i to nForms
		pForms(j) = pForms(j + 1)
	next j
	
end sub

'':::::
public sub Forms_Add_Control _
	( _
		byval frm as form_t ptr, _
		byval ctl as control_t ptr _
	)

	if( frm = NULL ) then
		exit sub
	end if

	if( ctl = NULL ) then
		exit sub
	end if
	
	frm->nControls += 1
	frm->pControls( frm->nControls ) = ctl

end sub

'':::::
public sub Forms_Remove_Control _
	( _
		byval frm as form_t ptr, _
		byval ctl as control_t ptr _
	)

	dim as integer i, j

	if( frm = NULL ) then
		exit sub
	end if

	if( ctl = NULL ) then
		exit sub
	end if

	for i = 1 to frm->nControls
		if( frm->pControls(i) = frm ) then
			frm->nControls -= 1
			exit for
		end if
	next i

	for j = i to frm->nControls
		frm->pControls(j) = frm->pControls(j + 1)
	next j
	
	frm->nControls += 1
	frm->pControls( frm->nControls ) = ctl

end sub

'':::::
public sub Control_Set _
	( _
		byval parent as form_t ptr, _
		byval ctl as control_t ptr, _
		byval x as integer, _
		byval y as integer, _
		byval w as integer, _
		byval h as integer, _
		byval fc as integer, _
		byval bc as integer, _
		byval flags as integer, _
		byval id as integer _
	)

	if( ctl = NULL ) then
		exit sub
	end if

	ctl->rect.x = x
	ctl->rect.y = y
	ctl->rect.w = w
	ctl->rect.h = h
	ctl->fc = fc
	ctl->bc = bc
	ctl->flags = flags
	ctl->id = id
	ctl->parent = parent

end sub


'':::::
public function Controls_IsPointInRect _
	( _
		byval rect as rect_t ptr, _
		byval x as integer, _
		byval y as integer _
	) as integer

	if( x >= rect->x ) then
		if( y >= rect->y ) then
			if( x < rect->x + rect->w ) then
				if( y < rect->y + rect->h ) then
					return TRUE
				end if
			end if
		end if
	end if

end function

'':::::
public function Forms_Draw _
	( _
		byval frm as form_t ptr, _
		byval bForceRedraw as integer _
	) as integer

	dim as integer i, ret = 0
	dim as control_t ptr ctl

	static as message_t msg

	if( frm = NULL ) then
		return FALSE
	end if

	msg.id = MSG_PAINT

	for i = 1 to frm->nControls
		ctl = frm->pControls(i)
		if( bForceRedraw ) then
			ctl->flags or= CONTROL_FLAG_REDRAW
		end if 
		if( (ctl->flags and (CONTROL_FLAG_REDRAW)) <> 0 ) then
			if( ctl->flags and CONTROL_FLAG_VISIBLE ) then
				if( ctl->handler <> NULL ) then
					ret or= ctl->handler( ctl, @msg )
				end if
			end if
		end if
	next i

	msg.id = MSG_UPDATE

	for i = 1 to frm->nControls
		if( (ctl->flags and (CONTROL_FLAG_UPDATE)) <> 0 ) then
			ctl->handler( ctl, @msg )
		end if
	next i
		
	Screen_BlinkCursor()

	return ret

end function

'':::::
public function Forms_DrawAll _
	( _
		byval bForceRedraw as integer _
	) as integer
	
	dim as integer i, n, ret = 0
	dim as control_t ptr ctl

	Screen_HideMouse()

	for i = 1 to nForms
		ctl = @pForms(i)->ctl
		if( ( ctl->flags and CONTROL_FLAG_REDRAW ) <> 0 ) then
			if( ctl->flags and CONTROL_FLAG_VISIBLE ) then	
				if( bForceRedraw ) then
					pForms(i)->ctl.flags or= CONTROL_FLAG_REDRAW
				end if
				ret = Forms_Draw( pForms(i), bForceRedraw )
			end if
		end if
	next i

	Screen_ShowMouse()

	return ret

end function

'':::::
public function Controls_GetControlFromXY _
	( _
		byval mx as integer, _
		byval my as integer _
	) as control_t ptr

	dim as integer i, j
	dim as control_t ptr ctl

	for j = nForms to 1 step - 1
		ctl = @pForms(j)->ctl
		if( ctl->flags and CONTROL_FLAG_VISIBLE ) then
			if( Controls_IsPointInRect( @ctl->rect, mx, my ) ) then
				for i = pForms(j)->nControls to 1 step - 1
					ctl = pForms(j)->pControls(i)
					if( ctl->flags and CONTROL_FLAG_VISIBLE ) then
						if( Controls_IsPointInRect( @ctl->rect, mx, my ) ) then
							return ctl
						end if
					end if
				next i
				return NULL
			end if
		end if
		exit for
	next j

	return NULL

end function

'':::::
public function Controls_GetCapture() as control_t ptr
	return( mcap_control )
end function

'':::::
public function Controls_GetFocus() as control_t ptr
	return( focus_control )
end function

'':::::
public function Controls_SetFocus _
	( _
		byval ctl as control_t ptr _
	) as control_t ptr
	
	dim ret as control_t ptr

	ret = focus_control

	focus_control = ctl

	return ret

end function

'':::::
public function Controls_SendMsg _
	( _
		byval ctl as control_t ptr, _
		byval id as integer, _
		byval mx as integer, _
		byval my as integer, _
		byval mz as integer, _
		byval mb as integer, _
		byval ky as zstring ptr _
	) as integer

	static as message_t msg

	if( ctl = NULL ) then
		return FALSE
	end if

	if( ctl->handler = NULL ) then
		return FALSE
	end if

	msg.id = id
	msg.mx = mx
	msg.my = my
	msg.mz = mz
	msg.mb = mb
	msg.ky = ky

	return( ctl->handler( ctl, @msg))

end function

'':::::
public function Controls_ProcessMouse _
	( _
		byval mx as integer, _
		byval my as integer, _
		byval mz as integer, _
		byval mb as integer _
	) as integer

	dim as control_t ptr ctl = NULL
	dim as integer result
	static as message_t msg

	if( Screen_MouseInstalled() = FALSE ) then
		return FALSE
	end if

	prev_mx = curr_mx
	prev_my = curr_my
	prev_mz = curr_mz
	prev_mb = curr_mb

	curr_mx = mx
	curr_my = my
	curr_mz = mz
	curr_mb = mb

	if( mcap_control = NULL ) then
		ctl = Controls_GetControlFromXY( curr_mx, curr_my )
	else
		ctl = mcap_control
	end if

	if( ctl = NULL ) then
		return( FALSE )
	end if

	msg.mx = curr_mx
	msg.my = curr_my
	msg.mz = prev_mz - curr_mz
	msg.mb = curr_mb
	msg.ky = 0

	if( ((prev_mb and 1) = 0) and ((curr_mb and 1) = 1) ) then
		'' Mouse Press
		mcap_control = ctl
		msg.id = MSG_MOUSE_DOWN
		if( ctl->handler ) then
			return( ctl->handler( ctl, @msg ) )
		end if

	elseif( ((prev_mb and 1) = 1) and ((curr_mb and 1) = 0) ) then
		'' Mouse Release
		msg.id = MSG_MOUSE_UP
		if( ctl->handler ) then
			result = ctl->handler( ctl, @msg )
		end if
		mcap_control = NULL
		return( result )

	elseif( prev_mz <> curr_mz ) then
		msg.id = MSG_MOUSE_WHEEL
		if( ctl->handler ) then
			return( ctl->handler( ctl, @msg ) )
		end if

	elseif( (prev_mx <> curr_mx) or (prev_my <> curr_my) )then
		'' Mouse Move
		if(mcap_control = ctl) then
			msg.id = MSG_MOUSE_MOVE
		else
			msg.id = MSG_MOUSE_OVER
		end if
		if( ctl->handler ) then
			return( ctl->handler( ctl, @msg ) )
		end if

	elseif( mcap_control = ctl ) then
		msg.id = MSG_MOUSE_UPDATE
		if( ctl->handler ) then
			return( ctl->handler( ctl, @msg ) )
		end if
	end if

	return( FALSE )

end function
