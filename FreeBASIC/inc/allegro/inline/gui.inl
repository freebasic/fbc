'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      GUI inline functions (generic C).
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_GUI_INL
#define ALLEGRO_GUI_INL

#include "allegro/gui.bi"

Private Inline Function object_message (ByVal d As DIALOG Ptr, ByVal msg As Integer, ByVal c As Integer) As Integer
	Dim ret As Integer
	
	If (msg = MSG_DRAW) Then
		If (d->flags And D_HIDDEN) Then
			object_message = D_O_K
			Exit Function
		End If
		acquire_screen
	End If

	ret = d->proc(msg, d, c)

	If (msg = MSG_DRAW) Then
		release_screen
	End If

	If (ret And D_REDRAWME) Then
		d->flags = d->flags Or D_DIRTY
		ret = ret And Not D_REDRAWME
	End If
	
	object_message = ret
End Function

#endif
