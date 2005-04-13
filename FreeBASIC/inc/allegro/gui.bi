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
'      GUI routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_GUI_H
#define ALLEGRO_GUI_H

#include "allegro/base.bi"

type DIALOG_PROC as function(byval msg as integer, byval d as Any ptr, byval c as integer) as integer

Type DIALOG
	proc as sub(msg As Integer, d As DIALOG Ptr, c As Integer)
	x As Integer				' position and size of the object
	y As Integer
	w As Integer
	h As Integer
	fg As Integer				' foreground and background colors
	bg As Integer
	key As Integer				' keyboard shortcut (ASCII code)
	flags As Integer			' flags about the object state
	d1 As Integer				' any data the object might require
	d2 As Integer
	dp As UByte Ptr				' pointers to more object data
	dp2 As UByte Ptr
	dp3 As UByte Ptr
End Type

Type MENU					' a popup menu
	text As UByte Ptr			' menu item text
	proc as sub()			' callback function
	child As MENU Ptr			' to allow nested menus
	flags As Integer			' flags about the menu state
	dp As UByte Ptr				' any data the menu might require
End Type

Type DIALOG_PLAYER				' stored information about the state of an active GUI dialog
	obj As Integer
	res As Integer
	mouse_obj As Integer
	focus_obj As Integer
	joy_on As Integer
	click_wait As Integer
	mouse_ox As Integer
	mouse_oy As Integer
	mouse_oz As Integer
	mouse_b As Integer
	dialog As DIALOG Ptr
End Type

#define D_EXIT          1        ' object makes the dialog exit
#define D_SELECTED      2        ' object is selected
#define D_GOTFOCUS      4        ' object has the input focus 
#define D_GOTMOUSE      8        ' mouse is on top of object
#define D_HIDDEN        16       ' object is not visible
#define D_DISABLED      32       ' object is visible but inactive
#define D_DIRTY         64       ' object needs to be redrawn
#define D_INTERNAL      128      ' reserved for internal use
#define D_USER          256      ' from here on is free for your own use

' return values for the dialog procedures
#define D_O_K           0        ' normal exit status
#define D_CLOSE         1        ' request to close the dialog
#define D_REDRAW        2        ' request to redraw the dialog
#define D_REDRAWME      4        ' request to redraw this object
#define D_WANTFOCUS     8        ' this object wants the input focus
#define D_USED_CHAR     16       ' object has used the keypress
#define D_REDRAW_ALL    32       ' request to redraw all active dialogs


' messages for the dialog procedures
#define MSG_START       1        ' start the dialog, initialise 
#define MSG_END         2        ' dialog is finished - cleanup
#define MSG_DRAW        3        ' draw the object
#define MSG_CLICK       4        ' mouse click on the object
#define MSG_DCLICK      5        ' double click on the object
#define MSG_KEY         6        ' keyboard shortcut
#define MSG_CHAR        7        ' other keyboard input
#define MSG_UCHAR       8        ' unicode keyboard input
#define MSG_XCHAR       9        ' broadcast character to all objects
#define MSG_WANTFOCUS   10       ' does object want the input focus?
#define MSG_GOTFOCUS    11       ' got the input focus
#define MSG_LOSTFOCUS   12       ' lost the input focus
#define MSG_GOTMOUSE    13       ' mouse on top of object
#define MSG_LOSTMOUSE   14       ' mouse moved away from object
#define MSG_IDLE        15       ' update any background stuff
#define MSG_RADIO       16       ' clear radio buttons
#define MSG_WHEEL       17       ' mouse wheel moved
#define MSG_LPRESS      18       ' mouse left button pressed
#define MSG_LRELEASE    19       ' mouse left button released
#define MSG_MPRESS      20       ' mouse middle button pressed
#define MSG_MRELEASE    21       ' mouse middle button released
#define MSG_RPRESS      22       ' mouse right button pressed
#define MSG_RRELEASE    23       ' mouse right button released
#define MSG_USER        24       ' from here on are free...

declare function d_yield_proc cdecl alias "d_yield_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_clear_proc cdecl alias "d_clear_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_box_proc cdecl alias "d_box_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_shadow_proc cdecl alias "d_shadow_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_bitmap_proc cdecl alias "d_bitmap_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_text_proc cdecl alias "d_text_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_ctext_proc cdecl alias "d_ctext_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_rtext_proc cdecl alias "d_rtext_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_button_proc cdecl alias "d_button_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_check_proc cdecl alias "d_check_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_radio_proc cdecl alias "d_radio_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_icon_proc cdecl alias "d_icon_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_keyboard_proc cdecl alias "d_keyboard_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_edit_proc cdecl alias "d_edit_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_list_proc cdecl alias "d_list_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_text_list_proc cdecl alias "d_text_list_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_textbox_proc cdecl alias "d_textbox_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_slider_proc cdecl alias "d_slider_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_menu_proc cdecl alias "d_menu_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer

extern import gui_shadow_box_proc as DIALOG_PROC
extern import gui_ctext_proc as DIALOG_PROC
extern import gui_button_proc as DIALOG_PROC
extern import gui_edit_proc as DIALOG_PROC
extern import gui_list_proc as DIALOG_PROC
extern import gui_text_list_proc as DIALOG_PROC

extern import gui_menu_draw_menu as sub(byval x as integer, byval y as integer, byval w as integer, byval h as integer)
extern import gui_menu_draw_menu_item as sub(byval m as MENU ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval bar as integer, byval sel as integer)

extern import active_dialog as DIALOG ptr
extern import active_menu as MENU ptr

extern import gui_mouse_focus as integer

extern import gui_fg_color as integer
extern import gui_mg_color as integer
extern import gui_bg_color as integer

extern import gui_font_baseline as integer

extern import gui_mouse_x as function cdecl() as integer
extern import gui_mouse_y as function cdecl() as integer
extern import gui_mouse_z as function cdecl() as integer
extern import gui_mouse_b as function cdecl() as integer

declare function gui_textout cdecl alias "gui_textout" ( byval bmp as BITMAP ptr, byval s as string, byval x as integer, byval y as integer, byval _color as integer, byval centre as integer) as integer
declare function gui_strlen cdecl alias "gui_strlen" ( byval s as string ) as integer
declare sub position_dialog cdecl alias "position_dialog" ( byval dlg as DIALOG ptr, byval x as integer, byval y as integer )
declare sub centre_dialog cdecl alias "centre_dialog" ( byval dlg as DiALOG ptr )
declare sub set_dialog_color cdecl alias "set_dialog_color" ( byval dlg as DIALOG ptr, byval fg as integer, byval bg as integer )
declare function find_dialog_focus cdecl alias "find_dialog_focus" ( byval dlg as DIALOG ptr ) as integer
declare function offer_focus cdecl alias "offer_focus" ( byval d as DIALOG ptr, byval obj as integer, byval focus_obj as integer ptr, byval force as integer ) as integer
declare function dialog_message cdecl alias "dialog_message" ( byval d as DIALOG ptr, byval msg as integer, byval c as integer, byval obj as integer ptr ) as integer
declare function broadcast_dialog_message cdecl alias "broadcast_dialog_message" ( byval msg as integer, byval c as integer ) as integer
declare function do_dialog cdecl alias "do_dialog" ( byval d as DIALOG ptr, byval focus_obj as integer ) as integer
declare function popup_dialog cdecl alias "popup_dialog" ( byval dlg as DIALOG ptr, byval focus_obj as integer ) as integer
declare function init_dialog cdecl alias "init_dialog" ( byval d as DIALOG ptr, byval focus_obj as integer ) as DIALOG_PLAYER ptr
declare function update_dialog cdecl alias "update_dialog" ( byval player as DIALOG_PLAYER) as integer
declare function shutdown_dialog cdecl alias "shutdown_dialog" ( byval player as DIALOG_PLAYER Ptr ) as integer
declare function do_menu cdecl alias "do_menu" ( byval menu as MENU ptr, byval x as integer, byval y as integer ) as integer
Declare Function alert CDecl Alias "alert" (ByVal s1 as String, ByVal s2 As String, ByVal s3 As String, ByVal b1 As String, ByVal b2 As String, ByVal c1 As String, ByVal c2 As String) As Integer
declare function alert3 cdecl alias "alert3" ( byval s1 as string, byval s2 as string, byval s3 as string, byval b1 as string, byval b2 as string, byval b3 as string, byval c1 as integer, byval c2 as integer, byval c3 as integer ) as integer

#define OLD_FILESEL_WIDTH   -1
#define OLD_FILESEL_HEIGHT  -1

declare function file_select cdecl alias "file_select" ( byval message as string, byval path as byte ptr, byval ext as string ) as integer
declare function file_select_ex cdecl alias "file_select_ex" ( byval message as string, byval path as byte ptr, byval ext as string, byval size as integer, byval w as integer, byval h as integer ) as integer

Declare Function gfx_mode_select CDecl Alias "gfx_mode_select" (ByRef card As Integer, ByRef w As Integer, ByRef h As Integer) As Integer
Declare Function gfx_mode_select_ex CDecl Alias "gfx_mode_select_ex" (ByVal card As Integer Ptr, ByVal w As Integer Ptr, ByVal h As Integer Ptr, ByVal color_depth As Integer Ptr)

#include "allegro/inline/gui.inl"

#endif
