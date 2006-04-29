''
''
'' allegro\gui -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_gui_bi__
#define __allegro_gui_bi__

#include once "allegro/base.bi"

type DIALOG_ as DIALOG

type DIALOG_PROC as function cdecl(byval as integer, byval as DIALOG_ ptr, byval as integer) as integer

type DIALOG
	proc as DIALOG_PROC
	x as integer
	y as integer
	w as integer
	h as integer
	fg as integer
	bg as integer
	key as integer
	flags as integer
	d1 as integer
	d2 as integer
	dp as any ptr
	dp2 as any ptr
	dp3 as any ptr
end type

type MENU
	text as zstring ptr
	proc as function cdecl() as integer
	child as MENU ptr
	flags as integer
	dp as any ptr
end type

type DIALOG_PLAYER
	obj as integer
	res as integer
	mouse_obj as integer
	focus_obj as integer
	joy_on as integer
	click_wait as integer
	mouse_ox as integer
	mouse_oy as integer
	mouse_oz as integer
	mouse_b as integer
	dialog as DIALOG ptr
end type

#define D_EXIT 1
#define D_SELECTED 2
#define D_GOTFOCUS 4
#define D_GOTMOUSE 8
#define D_HIDDEN 16
#define D_DISABLED 32
#define D_DIRTY 64
#define D_INTERNAL 128
#define D_USER 256
#define D_O_K 0
#define D_CLOSE 1
#define D_REDRAW 2
#define D_REDRAWME 4
#define D_WANTFOCUS 8
#define D_USED_CHAR 16
#define D_REDRAW_ALL 32
#define MSG_START 1
#define MSG_END 2
#define MSG_DRAW 3
#define MSG_CLICK 4
#define MSG_DCLICK 5
#define MSG_KEY 6
#define MSG_CHAR 7
#define MSG_UCHAR 8
#define MSG_XCHAR 9
#define MSG_WANTFOCUS 10
#define MSG_GOTFOCUS 11
#define MSG_LOSTFOCUS 12
#define MSG_GOTMOUSE 13
#define MSG_LOSTMOUSE 14
#define MSG_IDLE 15
#define MSG_RADIO 16
#define MSG_WHEEL 17
#define MSG_LPRESS 18
#define MSG_LRELEASE 19
#define MSG_MPRESS 20
#define MSG_MRELEASE 21
#define MSG_RPRESS 22
#define MSG_RRELEASE 23
#define MSG_USER 24

declare function d_yield_proc cdecl alias "d_yield_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_clear_proc cdecl alias "d_clear_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_box_proc cdecl alias "d_box_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_shadow_box_proc cdecl alias "d_shadow_box_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_bitmap_proc cdecl alias "d_bitmap_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_text_proc cdecl alias "d_text_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_ctext_proc cdecl alias "d_ctext_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_rtext_proc cdecl alias "d_rtext_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_button_proc cdecl alias "d_button_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_check_proc cdecl alias "d_check_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_radio_proc cdecl alias "d_radio_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_icon_proc cdecl alias "d_icon_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_keyboard_proc cdecl alias "d_keyboard_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_edit_proc cdecl alias "d_edit_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_list_proc cdecl alias "d_list_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_text_list_proc cdecl alias "d_text_list_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_textbox_proc cdecl alias "d_textbox_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_slider_proc cdecl alias "d_slider_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer
declare function d_menu_proc cdecl alias "d_menu_proc" (byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer

extern _AL_DLL gui_shadow_box_proc alias "gui_shadow_box_proc" as DIALOG_PROC
extern _AL_DLL gui_ctext_proc alias "gui_ctext_proc" as DIALOG_PROC
extern _AL_DLL gui_button_proc alias "gui_button_proc" as DIALOG_PROC
extern _AL_DLL gui_edit_proc alias "gui_edit_proc" as DIALOG_PROC
extern _AL_DLL gui_list_proc alias "gui_list_proc" as DIALOG_PROC
extern _AL_DLL gui_text_list_proc alias "gui_text_list_proc" as DIALOG_PROC
extern _AL_DLL gui_menu_draw_menu alias "gui_menu_draw_menu" as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer)
extern _AL_DLL gui_menu_draw_menu_item alias "gui_menu_draw_menu_item" as sub cdecl(byval as MENU ptr, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
extern _AL_DLL active_dialog alias "active_dialog" as DIALOG ptr
extern _AL_DLL active_menu alias "active_menu" as MENU ptr
extern _AL_DLL gui_mouse_focus alias "gui_mouse_focus" as integer
extern _AL_DLL gui_fg_color alias "gui_fg_color" as integer
extern _AL_DLL gui_mg_color alias "gui_mg_color" as integer
extern _AL_DLL gui_bg_color alias "gui_bg_color" as integer
extern _AL_DLL gui_font_baseline alias "gui_font_baseline" as integer
extern _AL_DLL gui_mouse_x alias "gui_mouse_x" as function cdecl() as integer
extern _AL_DLL gui_mouse_y alias "gui_mouse_y" as function cdecl() as integer
extern _AL_DLL gui_mouse_z alias "gui_mouse_z" as function cdecl() as integer
extern _AL_DLL gui_mouse_b alias "gui_mouse_b" as function cdecl() as integer

declare function gui_textout cdecl alias "gui_textout" (byval bmp as BITMAP ptr, byval s as zstring ptr, byval x as integer, byval y as integer, byval color as integer, byval centre as integer) as integer
declare function gui_strlen cdecl alias "gui_strlen" (byval s as zstring ptr) as integer
declare sub position_dialog cdecl alias "position_dialog" (byval dialog as DIALOG ptr, byval x as integer, byval y as integer)
declare sub centre_dialog cdecl alias "centre_dialog" (byval dialog as DIALOG ptr)
declare sub set_dialog_color cdecl alias "set_dialog_color" (byval dialog as DIALOG ptr, byval fg as integer, byval bg as integer)
declare function find_dialog_focus cdecl alias "find_dialog_focus" (byval dialog as DIALOG ptr) as integer
declare function offer_focus cdecl alias "offer_focus" (byval d as DIALOG ptr, byval obj as integer, byval focus_obj as integer ptr, byval force as integer) as integer
declare function dialog_message cdecl alias "dialog_message" (byval dialog as DIALOG ptr, byval msg as integer, byval c as integer, byval obj as integer ptr) as integer
declare function broadcast_dialog_message cdecl alias "broadcast_dialog_message" (byval msg as integer, byval c as integer) as integer
declare function do_dialog cdecl alias "do_dialog" (byval dialog as DIALOG ptr, byval focus_obj as integer) as integer
declare function popup_dialog cdecl alias "popup_dialog" (byval dialog as DIALOG ptr, byval focus_obj as integer) as integer
declare function init_dialog cdecl alias "init_dialog" (byval dialog as DIALOG ptr, byval focus_obj as integer) as DIALOG_PLAYER ptr
declare function update_dialog cdecl alias "update_dialog" (byval player as DIALOG_PLAYER ptr) as integer
declare function shutdown_dialog cdecl alias "shutdown_dialog" (byval player as DIALOG_PLAYER ptr) as integer
declare function do_menu cdecl alias "do_menu" (byval menu as MENU ptr, byval x as integer, byval y as integer) as integer
declare function alert cdecl alias "alert" (byval s1 as zstring ptr, byval s2 as zstring ptr, byval s3 as zstring ptr, byval b1 as zstring ptr, byval b2 as zstring ptr, byval c1 as integer, byval c2 as integer) as integer
declare function alert3 cdecl alias "alert3" (byval s1 as zstring ptr, byval s2 as zstring ptr, byval s3 as zstring ptr, byval b1 as zstring ptr, byval b2 as zstring ptr, byval b3 as zstring ptr, byval c1 as integer, byval c2 as integer, byval c3 as integer) as integer

#define OLD_FILESEL_WIDTH -1
#define OLD_FILESEL_HEIGHT -1

declare function file_select cdecl alias "file_select" (byval message as zstring ptr, byval path as zstring ptr, byval ext as zstring ptr) as integer
declare function file_select_ex cdecl alias "file_select_ex" (byval message as zstring ptr, byval path as zstring ptr, byval ext as zstring ptr, byval size as integer, byval w as integer, byval h as integer) as integer
declare function gfx_mode_select cdecl alias "gfx_mode_select" (byval card as integer ptr, byval w as integer ptr, byval h as integer ptr) as integer
declare function gfx_mode_select_ex cdecl alias "gfx_mode_select_ex" (byval card as integer ptr, byval w as integer ptr, byval h as integer ptr, byval color_depth as integer ptr) as integer

#include once "allegro/inline/gui.bi"

#endif
