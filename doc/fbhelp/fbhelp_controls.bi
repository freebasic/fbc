#ifndef __FBHELP_CONTROLS_BI__
#define __FBHELP_CONTROLS_BI__

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


	#include once "common.bi"
	#include once "fbhelp_textbuffer.bi"

	#define MSG_NONE         0
	#define MSG_PAINT        1
	#define MSG_KEY_PRESS    2
	#define MSG_MOUSE_DOWN   3
	#define MSG_MOUSE_UP     4
	#define MSG_MOUSE_MOVE   5
	#define MSG_MOUSE_OVER   6
	#define MSG_MOUSE_UPDATE 7
	#define MSG_MOUSE_WHEEL  8
	#define MSG_SCROLL       9
	#define MSG_SET_SCROLL  10
	#define MSG_CLOSE       11
	#define MSG_UPDATE      12
	#define MSG_CLICK       13

	type message_t
		id as integer
		mx as integer
		my as integer
		mz as integer
		mb as integer
		ky as zstring ptr
	end type

	type form_t_ as form_t

	type control_t
		rect as rect_t
		fc as integer
		bc as integer
		flags as integer
		id as integer
		parent as form_t_ ptr
		handler as function _
			( _
				byval ctl as control_t ptr, _
				byval msg as message_t ptr _
			) as integer
	end type

	type form_t
		ctl as control_t
		nControls as integer
		pControls(1 to 16) as control_t ptr
		text as string
	end type

	declare sub Forms_Add _
		( _
			byval frm as form_t ptr _
		)

	declare sub Forms_Remove _
		( _
			byval frm as form_t ptr _
		)

	declare sub Forms_Add_Control _
		( _
			byval frm as form_t ptr, _
			byval ctl as control_t ptr _
		)

	declare sub Forms_Remove_Control _
		( _
			byval frm as form_t ptr, _
			byval ctl as control_t ptr _
		)

	declare function Forms_DrawAll _
		( _
			byval bForceRedraw as integer _
		) as integer

	declare function Forms_Draw _
		( _
			byval frm as form_t ptr, _
			byval bForceRedraw as integer _
		) as integer

	declare sub Control_Set _
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

	declare sub Control_Add _
		( _
			byval ctl as control_t ptr _
		)

	declare function Controls_ProcessMouse _
		( _
			byval mx as integer, _
			byval my as integer, _
			byval mz as integer, _
			byval mb as integer _
		) as integer

	declare function Controls_GetCapture() as control_t ptr

	declare function Controls_IsPointInRect _
		( _
			byval rect as rect_t ptr, _
			byval x as integer, _
			byval y as integer _
		) as integer

	declare function Controls_GetFocus() as control_t ptr
	declare function Controls_SetFocus _
	( _
		byval ctl as control_t ptr _
	) as control_t ptr


	declare function Controls_SendMsg _
		( _
			byval ctl as control_t ptr, _
			byval id as integer, _
			byval mx as integer, _
			byval my as integer, _
			byval mz as integer, _
			byval mb as integer, _
			byval ky as zstring ptr _
		) as integer

	const CONTROL_FLAG_REDRAW   = &h40000000
	const CONTROL_FLAG_UPDATE   = &h20000000
	const CONTROL_FLAG_VISIBLE   = &h10000000

	#define CtlNeedRedraw( ctl_ )  (( (ctl_)->ctl.flags and CONTROL_FLAG_REDRAW ) <> 0 )
	#define CtlSetRedraw( ctl_ )  (ctl_)->ctl.flags or= CONTROL_FLAG_REDRAW or CONTROL_FLAG_UPDATE
	#define CtlClrRedraw( ctl_ )  (ctl_)->ctl.flags and= not CONTROL_FLAG_REDRAW

	#define CtlNeedUpdate( ctl_ )  (( (ctl_)->ctl.flags and CONTROL_FLAG_UPDATE ) <> 0 )
	#define CtlSetUpdate( ctl_ )  (ctl_)->ctl.flags or= CONTROL_FLAG_UPDATE
	#define CtlClrUpdate( ctl_ )  (ctl_)->ctl.flags and= not CONTROL_FLAG_UPDATE


	#include once "fbhelp_controls_frame.bi"
	#include once "fbhelp_controls_static.bi"
	#include once "fbhelp_controls_scrollbar.bi"
	#include once "fbhelp_controls_helpbox.bi"
	#include once "fbhelp_controls_scrollbar.bi"
	#include once "fbhelp_controls_button.bi"
	#include once "fbhelp_controls_editbox.bi"


#endif

